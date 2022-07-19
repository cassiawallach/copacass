import { LightningElement, track, api, wire } from 'lwc';
import moment from '@salesforce/resourceUrl/moment';
import { loadScript } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { fireEvent } from 'c/pubSub';
import { CurrentPageReference } from 'lightning/navigation';

export default class DatePicker extends LightningElement {
    // Contains the array of records with having 'StartDate' as attribute in record object
    @api availableRecordsOnDates = [];
    @api noRecordsTitle = 'No Records!!!';
    @api noRecordsMessage = 'No records available for this date.';
    @track dateContext 
    @track selectedDate 
    @track datesInWeek = [];
    @track recordDatesWithIds = {};
    today;
    yearOptions = [];
    selectedYear;

    @wire(CurrentPageReference) pageRef;

    connectedCallback() {
        this.recordDatesWithIds = this.getRecordDatesSet();
        Promise.all([
            loadScript(this, moment)
          ]).then(() => {
            this.loadActivities();
        });
    }

    loadActivities(){
        this.today = window.moment();
        this.dateContext = window.moment();
        this.selectedDate = window.moment();
        this.setYearOptions(this.dateContext);
        this.refreshDateNodes();
    }

    refreshDateNodes() {
        this.setYear();
        this.datesInWeek = [];
        const currentMoment = window.moment(this.dateContext);
        // startOf mutates moment, hence clone before use
        const start = this.dateContext.clone().startOf('month');
        const startWeek = start.week();
        // months do not always have the same number of weeks. eg. February
        for (let week = startWeek; week <= startWeek + 5; week++) {
            let currWeek = {};
            currWeek.isoWeek = week;
            currWeek.dates = [];
            Array(7)
                .fill(0)
                .forEach((n, i) => {
                    const day = currentMoment
                        .week(week)
                        .startOf('week')
                        .clone()
                        .add(n + i, 'day');
                    let className = 'slds-day';
                    if (day.month() === this.dateContext.month()) {
                        if (day.isSame(this.today, 'day')) {
                            className += ' today';
                        }
                        if(this.recordDatesWithIds.hasOwnProperty(day.format('YYYY-MM-DD'))) {
                            className += ' event_date';
                        }
                    } else {
                        className += ' slds-disabled-text';
                    }
                    currWeek.dates.push({
                        className,
                        formatted: day.format('YYYY-MM-DD'),
                        text: day.format('DD'),
                        index: i * week
                    });
                });
                this.datesInWeek.push(currWeek);
        }
    }

    setYearOptions(dateContext) {
        this.selectedYear = dateContext.year();
        for(let iterator = 0; iterator <= 10; iterator++) {
            let year = {label: dateContext.year() + iterator, value: dateContext.year() + iterator, selected: false};
            if(year.value == this.selectedYear) {
                year.selected = true;
            }
            this.yearOptions.push(year);
        }
    }

    setYear() {
        if(this.selectedYear !== this.dateContext.year()) {
            // Reset the year to initial year if the current selected year in option is greater options in year
            if(this.dateContext.year() > this.yearOptions[this.yearOptions.length -1].value) {
                this.dateContext.set('year', this.yearOptions[0].value);
            }
            this.selectedYear = this.dateContext.year();
            let startDateInput = this.template.querySelector('[data-id="yearOption"]');
            startDateInput.value = this.selectedYear;
        }
    }

    previousMonth() {
        let prevDateContext = window.moment(this.dateContext).subtract(1, 'month');
        if(prevDateContext.year() < this.today.year()) {
            return;
        }
        this.dateContext = prevDateContext;
        this.refreshDateNodes();
    }

    nextMonth() {
        this.dateContext = window.moment(this.dateContext).add(1, 'month');
        this.refreshDateNodes();
    }

    goToday() {
        this.selectedDate = this.today;
        this.dateContext = this.today;
        this.refreshDateNodes();
    }

    handleChangeYear(event) {
        this.selectedYear = event.target.value;
        this.dateContext.set('year', this.selectedYear);
        this.refreshDateNodes();
    }

    getRecordDatesSet() {
        const recordDatesWithIds = {};
        for(let iterator = 0; iterator < this.availableRecordsOnDates.length; iterator++) {
            let startDate = this.availableRecordsOnDates[iterator].StartDate;
            let recordId = this.availableRecordsOnDates[iterator].Id;
            let recordIdsSet;
            if(recordDatesWithIds.hasOwnProperty(startDate)) {
                recordIdsSet = recordDatesWithIds[startDate];
                recordIdsSet.push(recordId);
                recordDatesWithIds[startDate] = recordIdsSet;
            }
            else {
                recordIdsSet = [];
                recordIdsSet.push(recordId);
                recordDatesWithIds[startDate] = recordIdsSet;
            }
        }
        return recordDatesWithIds;
    }

    handleSelectedDate(event) {
        const date = event.currentTarget.dataset.date;
        this.selectedDate = window.moment(date);
        this.dateContext = window.moment(date);
        if(this.recordDatesWithIds.hasOwnProperty(date)) {
            let recordIdsInDate = {};
            recordIdsInDate['date'] = date;
            recordIdsInDate['records'] = this.recordDatesWithIds[date];
            fireEvent(this.pageRef ,'dateselected', recordIdsInDate);
        }
        else {
            const event = new ShowToastEvent({
                title: this.noRecordsTitle,
                message: this.noRecordsMessage,
                variant: 'info'
            });
            this.dispatchEvent(event);
        }
    }

    get month() {
        if(this.dateContext) {
            return this.dateContext.format('MMMM');
        }
        return;
    }

    get isResults() {
        return this.datesInWeek.length !==0;
    }

    get hasYearOptions() {
        return this.yearOptions.length !==0;
    }
}