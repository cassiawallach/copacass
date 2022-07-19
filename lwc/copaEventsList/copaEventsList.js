import { LightningElement, track, wire, api } from 'lwc';
import getAllCopaEventsCount from '@salesforce/apex/copaEventsController.getAllCopaEventsCount';
import getCopaEvents from '@salesforce/apex/copaEventsController.getCopaEvents';
import { refreshApex } from '@salesforce/apex';
import { registerListener, unregisterAllListeners } from 'c/pubSub';
import { CurrentPageReference } from 'lightning/navigation';
const DELAY = 300; // dealy apex callout timing in miliseconds

export default class CopaEventsList extends LightningElement {
    @track totalCopaEvents;
    @track isBusy = true;
    @track copaEvents = [];
    @track tags = {
        searchEvent : '',
        eventsDateFilter : ''
    };
    selectedDateString = '';
    status;
    // Pagination variables
    @track pageSize;
    @track currentPage;
    /**
     * Options for records per page.
     */
    @track recordsPerPageOptions = [
        { label: '2 Records/Page', value: '2' },
        { label: '5 Records/Page', value: '5' },
        { label: '10 Records/Page', value: '10' }
    ];
    defaultRecordsPerPage = '5';
    delayTimeout;
    actionEventId = '';

    @wire(CurrentPageReference) pageRef;
     /**
     * Wire function to fetch the copa events.
     * @param {object} value 
     */
    @wire(getCopaEvents, {pageSize: '$pageSize', page: '$currentPage', tags: '$tags'})
    getCopaEvents(value) {
        this.copaEventsWiredActivities = value;
        const { data, error } = value; // destructure the provisioned value
        if (data && !data.isError) {
            this.isBusy = false;
            this.copaEvents = data.result;
            this.handleRegisterInCopaEvent();
        }
        else if (data && data.isError) {
            this.status = {
                hasError: true,
                errorMessage: "Server error while loading the Events data."
            };
            this.isBusy = false;
        }
        else if (error) {
            this.status = {
                hasError: true,
                errorMessage: 'Error while loading the Events data.'
            };
            this.isBusy = false;
        }
    };

    /**
     * Wire function to get the copa events count.
     * @param {object} value 
     */
    @wire(getAllCopaEventsCount, {tags: '$tags'})
    getAllCopaEventsCount(value) {
        const { data, error } = value; // destructure the provisioned value
        if (data && !data.isError) {
            this.totalCopaEvents = data.result;
        }
        else if (data && data.isError) {
            this.status = {
                hasError: true,
                errorMessage: "Server error while loading the Events data."
            };
        }
        else if (error) {
            this.status = {
                hasError: true,
                errorMessage: 'Error while loading the Events data.'
            };
        }
    };

    constructor() {
        super();
        this.status = {
			hasError: false,
			errorMessage: null
		};
    }

    connectedCallback() {
        registerListener('dateselected', this.handleDateSelected, this);
    }

    disconnectedCallback() {
        unregisterAllListeners(this);
      }

    /* Pagination methods start */

    /**
     * Handle pagination
     * @param {object} event 
     */
    handlePage(event) {
        let pageVars = event.detail;
        if(this.currentPage != pageVars.currentPage || this.pageSize != pageVars.pageSize) {
            this.setBusy();
        }
        this.currentPage = pageVars.currentPage;
        this.pageSize = pageVars.pageSize;
    }
    /* Pagination methods end */

    handleChange(event) {
        this.setBusy();
        const eveName = event.target.name;
        const eveValue = event.target.value;
        window.clearTimeout(this.delayTimeout);
        if(eveName == 'searchEvent') {
            this.delayTimeout = setTimeout(() => {
                this.tags[eveName] = eveValue;
                this.refreshDataThroughWire();
            }, DELAY);
        }
        else {
            this.tags[eveName] = eveValue;
            this.refreshDataThroughWire();
        }
    }

    handleRemoveFilter(event) {
        this.setBusy();
        let filterName = event.detail;
        this.tags[filterName] = '';
        if(filterName == 'eventsDateFilter') {
            this.selectedDateString = '';
        }
        this.refreshDataThroughWire();
    }

    // Refresh events list on registration in event.
    handleRefreshAfterRegister(event) {
        this.setBusy();
        refreshApex(this.copaEventsWiredActivities);
    }

    refreshDataThroughWire() {
        // Reset current page in filtering
        this.template.querySelector('c-project-configuration-pagination').resetCurrentPage();
        let tagsCopy = this.tags;
        this.tags = {};
        this.tags = tagsCopy;
    }

    handleRegisterInCopaEvent() {
		let id = new URL(window.location.href).searchParams.get('evtId');
        let action = new URL(window.location.href).searchParams.get('action');
        if(id && action && action == 'reg') {
            this.actionEventId = id;
        }
	}

    handleDateSelected(selectedDateWithRecordIds) {
        this.setBusy();
        this.tags.eventsDateFilter = Array.from(selectedDateWithRecordIds.records).join(',');
        // Convert date in proper format
        var parts = selectedDateWithRecordIds.date.split('-');
        var eventStartDate = new Date(parts[0], parts[1] - 1, parts[2]);
        var eventStartDay = parts[2];
        var eventStartMonth = eventStartDate.toLocaleString('default', { month: 'short' })
        this.selectedDateString = eventStartMonth + ' ' + eventStartDay + ', ' + parts[0];
        this.refreshDataThroughWire();
    }

    /**
     * Method to set the busy equals to true.
     */
    setBusy() {
        this.isBusy = true;
    }

    /**
     * To get the number of copa events on a page.
     */
    get currentPageRecords() {
        return this.copaEvents.length;
    }

    /**
     * Check whether there are copa events records or not.
     */
    get hasNoRecords() {
        return (this.copaEvents.length == 0 && !this.isBusy && !this.status.hasError);
    }
}