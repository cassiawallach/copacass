import { LightningElement, track, wire } from 'lwc';
import getCopaEvents from '@salesforce/apex/copaEventsController.getCopaEvents';


export default class CopaEventsLayout extends LightningElement {
    @track isBusy = true;
    @track allCopaEventsWithStartDate = [];
    status;

    constructor() {
        super();
        this.status = {
			hasError: false,
			errorMessage: null
		};
    }

    /**
     * Wire function to fetch all copa events.
     * @param {object} value 
     */
    @wire(getCopaEvents, {pageSize: null, page: null, tags: null})
    getCopaEvents(value) {
        const { data, error } = value; // destructure the provisioned value
        if (data && !data.isError) {
            this.isBusy = false;
            this.allCopaEventsWithStartDate = data.result;
        }
        else if (data && data.isError) {
            this.status = {
                hasError: true,
                errorMessage: "Server error while loading the Events Calendar data."
            };
            this.isBusy = false;
        }
        else if (error) {
            this.status = {
                hasError: true,
                errorMessage: 'Error while loading the Events Calendar data.'
            };
            this.isBusy = false;
        }
     };

    /**
     * Check whether there are copa events records or not.
     */
    get hasRecords() {
        return (this.allCopaEventsWithStartDate.length > 0 && !this.isBusy && !this.status.hasError);
    }
}