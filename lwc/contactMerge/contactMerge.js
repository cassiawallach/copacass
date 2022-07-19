import { LightningElement } from 'lwc';
import mergeContactData from '@salesforce/apex/ContactMergeController.mergeContactData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ContactMerge extends LightningElement {
  errorMsg = null;
  isLoading = false;
  oldContactId = '';
  oldUserId = '';
  newContactId = '';
  newUserId = '';

  handleChange(event) {
    this[event.target.name] = event.target.value;
  }

  handleMerge() {
    if (!this.isInputValid()) {
      this.errorMsg = 'Please fill all required fields';
      return false;
    }

    this.errorMsg = null;
    this.isLoading = true;

    mergeContactData({ oldContactId: this.oldContactId, oldUserId: this.oldUserId, newContactId: this.newContactId, newUserId: this.newUserId })
      .then(result => {
        this.isLoading = false;
        this.errorMsg = null;
        this.oldContactId = '';
        this.oldUserId = '';
        this.newContactId = '';
        this.newUserId = '';

        this.dispatchEvent(
          new ShowToastEvent({
            title: 'Congratulations!!!',
            variant: 'success',
            message: 'Contact Migrated Successfully'
          })
        );
      })
      .catch(error => {
        console.log(error);
        this.errorMsg = error.body.message;
        this.isLoading = false;
      });
  }

  isInputValid() {
    let isValid = true;
    let inputFields = this.template.querySelectorAll('lightning-input');
    inputFields.forEach(inputField => {
      if (!inputField.checkValidity()) {
        inputField.reportValidity();
        isValid = false;
      }
    });
    return isValid;
  }
}