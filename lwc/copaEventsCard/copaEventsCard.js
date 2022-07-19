import { LightningElement, api } from 'lwc';
import COMMUNITY_RESOURCE from '@salesforce/resourceUrl/Community';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import IsGuest from '@salesforce/user/isGuest';
import createCommunityEventRegistration from '@salesforce/apex/copaEventsController.createCommunityEventRegistration';

export default class CopaEventsCard extends LightningElement {
    calendar_icon = COMMUNITY_RESOURCE + '/CommunityResources/icons/calendar.png';
    @api copaEvent;
    @api actionEventId;
    eventStartDay;
    eventStartMonth;
    showDetails = false;
    isBusy = false;
    buttonBrand = 'brand';
    registerButtonLabel = 'Register';
    registerButtonDisabled = false;
    isRendered = false;

    connectedCallback() {
        this.setEventVars();
        if(this.actionEventId == this.copaEvent.Id) {
            this.handleRegistration();
        }
    }

    renderedCallback() {
        if(this.copaEvent && this.copaEvent.IsUserRegistered && !this.isRendered) {
            this.isRendered = true;
            this.buttonBrand = 'success';
            this.registerButtonLabel = 'Registered';
            this.registerButtonDisabled = true;
        }
    }

    setEventVars() {
        var parts = this.copaEvent.StartDate.split('-');
        // The month (parts[1]); JavaScript counts months from 0:
        // January - 0, February - 1, etc.
        var eventStartDate = new Date(parts[0], parts[1] - 1, parts[2]);
        this.eventStartDay = parts[2];
        this.eventStartMonth = eventStartDate.toLocaleString('default', { month: 'short' });
    }

    handleCollapsible() {
        this.showDetails = !this.showDetails;
    }

    @api
    handleRegistration() {
        if(this.copaEvent.IsUserRegistered) {
            return;
        }
        if(this.copaEvent.EventType == 'Marketing_Events') {
            window.open(this.copaEvent.RegistrationLink, "_blank");
        }
        else if(this.copaEvent.EventType == 'Community_Events') {
            if(IsGuest) {
                let urlString = window.location.href;
                let startURL = urlString.substring(urlString.indexOf("/s/")) + '?evtId=' + this.copaEvent.Id + '&action=reg';
                let loginURL = '/Login?startURL=' + encodeURIComponent(startURL);
                window.open(loginURL, "_self");
            }
            else {
                this._createCommunityEventRegistration();
            }
        }
    }

    // Method to save the input data into server
	_createCommunityEventRegistration() {
		this.isBusy = true;
		createCommunityEventRegistration({
			eventId: this.copaEvent.Id
		})
			.then((result) => {
				if (!result.isError) {
					this.isBusy = false;
                    if(result.result) {
                        //toast message
                        const event = new ShowToastEvent({
                            title: 'Congratulations!!!',
                            message: 'Your registration is successful.',
                            variant: 'success'
                        });
                        this.dispatchEvent(event);
                        this.dispatchCustomEvent('register',true);
                    }
                    else {
                        //toast message
                        const event = new ShowToastEvent({
                            title: 'Error!!',
                            message: result.message,
                            variant: 'error'
                        });
                        this.dispatchEvent(event);
                    }
				} else {
					this.isBusy = false;
                    //toast message
                    const event = new ShowToastEvent({
                        title: 'Error!!',
                        message: 'Server error while registering under this event.',
                        variant: 'error'
                    });
                    this.dispatchEvent(event);
				}
			})
			.catch((error) => {
				this.isBusy = false;
                //toast message
                const event = new ShowToastEvent({
                    title: 'Error!!',
                    message: 'Error while registering under this event.',
                    variant: 'error'
                });
                this.dispatchEvent(event);
			});
	}

    dispatchCustomEvent(eventName, result) {
		const oEvent = new CustomEvent(eventName,
			{
				'detail': result
			}
		);
		this.dispatchEvent(oEvent);
	}

    get backgroundStyle() {
        return `background-image:url(${this.calendar_icon});background-repeat: no-repeat;background-size: contain;width: 111px;height: 120px;`;
    }
}