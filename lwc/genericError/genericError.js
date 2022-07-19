import { LightningElement, api } from 'lwc';

export default class GenericError extends LightningElement {
    @api errorHeading = "There's been a problem.";
	@api errorMessage = "Something went wrong.";
}