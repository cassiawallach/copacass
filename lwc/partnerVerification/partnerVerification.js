import { LightningElement,track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import verifyPartner from '@salesforce/apex/PartnerVerificationController.verifyPartner';

export default class PartnerVerification extends NavigationMixin(LightningElement) {
    @track message;
    @track isSuccess;
    @track usrId;
    @track isLoading = true;

    constructor(){
        super();
        this.usrId = new URL(window.location.href).searchParams.get('uid');
        this.verifyUser();
    }

    verifyUser(){
        verifyPartner({userid : this.usrId})
        .then((result) => {
            this.isLoading = false;
            console.log(result);
            this.message = 'You have successfully registered as a Partner User! You can login to the community using your credentials.';
            this.isSuccess = true;

            const evt = new ShowToastEvent({
                title: 'Congratulations !',
                message: 'You have successfully registered as a Partner User! You can login to the community using your credentials.',
                variant: 'success',
                mode: 'sticky',
            });
            this.dispatchEvent(evt);

            this[NavigationMixin.Navigate]({
                type: 'standard__namedPage',
                attributes: {
                    pageName: 'home'
                },
            });
        })
        .catch((error) => {
            this.isLoading = false;
            console.log(error);
            this.message = error.body.message;
            this.isSuccess = false;
        });
    }
}