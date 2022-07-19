import { LightningElement, track, wire } from 'lwc';
import fetchDownTime from '@salesforce/apex/DownTimeController.fetchDownTime';

export default class DownTime extends LightningElement {
    @track downTimeRegions;
    @track downTimeData;

    @wire(fetchDownTime)
    wiredMethod(result) {
        console.log(result);
        const { data, error } = result;
        if (data) {
            this.downTimeRegions = data.downTimeRegions;
            this.downTimeData = data.downTimeData;
        }
        else if (error) {
            console.log(error);
        }
    };
}