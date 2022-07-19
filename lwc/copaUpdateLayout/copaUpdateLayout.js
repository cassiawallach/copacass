import { LightningElement, wire, api } from 'lwc';
import getCurrentCopaUpdate from '@salesforce/apex/copaUpdateController.getCurrentCopaUpdate';

export default class CopaUpdateLayout extends LightningElement {
	@api recentCopaUpdateLabel = 'Recent Copa Updates';
	@api numberOfRecentCopaUpdates = 3;
    isBusy;
    status;
    currentCopaUpdateId = '';
    currentCopaUpdate;

    constructor() {
		super();
		this.isBusy = true;
        this.status = {
			hasError: false,
			errorMessage: null
		};
        this.setCurrentCopaUpdateId();
	}

    // wire function property to fetch latest Copa Update
	@wire(getCurrentCopaUpdate, {currentCopaUpdateId: '$currentCopaUpdateId'})
	getCurrentCopaUpdate(value) {
		const { data, error } = value; // destructure the provisioned value
		if (data && !data.isError) {
			this.currentCopaUpdate = data.result;
			this.isBusy = false;
		}
		else if (data && data.isError) {
			console.log('(server error---> ' + 'There is an error while fetching data.');
            this.status = {
                hasError: true,
                errorMessage: "Server error while loading the Copa Update."
            };
			this.isBusy = false;
		}
		else if (error) {
			console.log('(error---> ' + JSON.stringify(error));
            this.status = {
                hasError: true,
                errorMessage: 'Error while loading the Copa Update.'
            };
			this.isBusy = false;
		}
	};

    setCurrentCopaUpdateId() {
		let id = new URL(window.location.href).searchParams.get('id');
		if(id) {
			this.currentCopaUpdateId = id;
		}
	}

	get hasRecord() {
		return this.currentCopaUpdate && !this.isBusy && !this.status.hasError;
	}

	get hasNoRecord() {
		return !this.currentCopaUpdate && !this.isBusy && !this.status.hasError;
	}
}