import { LightningElement, api, wire } from 'lwc';
import getCurrentCopaUpdate from "@salesforce/apex/copaUpdateController.getCurrentCopaUpdate";
import COPA_UPDATE_THUMBNAIL from '@salesforce/resourceUrl/copaUpdate';
import COPA_UPDATE_LOGO from '@salesforce/resourceUrl/copaUpdateLogo';

export default class CopaUpdate extends LightningElement {
    @api footerText = 'LEARN MORE';
    copaUpdateLogo = COPA_UPDATE_LOGO;
    latestCopaUpdate;
    isBusy;
    status;

    // wire function property to fetch latest Copa Update
	@wire(getCurrentCopaUpdate, {currentCopaUpdateId : ''})
	getCurrentCopaUpdate(value) {
		const { data, error } = value; // destructure the provisioned value
		if (data && !data.isError) {
			this.latestCopaUpdate = data.result;
		}
		else if (data && data.isError) {
			console.log('(server error---> ' + 'There is an error while fetching data.');
            this.status = {
                hasError: true,
                errorMessage: "Server error while loading the Copa Update."
            };
		 }
		else if (error) {
			console.log('(error---> ' + JSON.stringify(error));
            this.status = {
                hasError: true,
                errorMessage: 'Error while loading the Copa Update.'
            };
		}
        this.isBusy = false;
	};

    constructor() {
		super();
		this.isBusy = true;
        this.status = {
			hasError: false,
			errorMessage: null
		};
	}

    get backgroundStyle() {
        return `background-image:url(${COPA_UPDATE_THUMBNAIL});background-repeat: no-repeat;background-size: contain;padding: 16.8%;height: 0;width: 100%;position: relative;border-top-left-radius:10px;border-top-right-radius:10px;`;
    }

    get hasLatestCopaUpdate() {
        return this.latestCopaUpdate && !this.isBusy && !this.status.hasError;
    }
}