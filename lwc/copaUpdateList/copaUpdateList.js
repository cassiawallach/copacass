import { LightningElement, api, wire} from 'lwc';
import getRecentCopaUpdates from '@salesforce/apex/copaUpdateController.getRecentCopaUpdates';

export default class CopaUpdateList extends LightningElement {
    @api currentCopaUpdateId;
    @api recentCopaUpdateLabel;
    @api numberOfRecentCopaUpdates;
    isBusy;
    recentCopadoUpdates;
    status;

    constructor() {
		super();
		this.isBusy = true;
        this.recentCopadoUpdates = [];
        this.status = {
			hasError: false,
			errorMessage: null
		};
	}

    // wire function property to fetch latest Copa Update
	@wire(getRecentCopaUpdates, {currentCopaUpdateId: '$currentCopaUpdateId', numberOfRecords: '$numberOfRecentCopaUpdates'})
	getRecentCopaUpdates(value) {
		const { data, error } = value; // destructure the provisioned value
		if (data && !data.isError) {
			this.recentCopadoUpdates = data.result;
			this.isBusy = false;
		}
		else if (data && data.isError) {
			console.log('(server error---> ' + 'There is an error while fetching data.');
            this.status = {
                hasError: true,
                errorMessage: "Server error while loading the Recent Copa Updates."
            };
			this.isBusy = false;
		}
		else if (error) {
			console.log('(error---> ' + JSON.stringify(error));
            this.status = {
                hasError: true,
                errorMessage: 'Error while loading the Recent Copa Updates.'
            };
			this.isBusy = false;
		}
	};

    get hasRecords() {
		return this.recentCopadoUpdates && this.recentCopadoUpdates.length > 0 && !this.isBusy;
	}

    get showCopaUpdates() {
        return !this.isBusy && !this.status.hasError;
    }
}