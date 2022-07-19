import { LightningElement, track, wire } from 'lwc';
import fetchFloatingBanner from '@salesforce/apex/CommunityFloatingBannerController.fetchFloatingBanner';

export default class CommunityFloatingBanner extends LightningElement {
    @track bannerData;
    @track isLoading = false;
    @track showBanner = false;

    @wire(fetchFloatingBanner)
    wiredBanner(result) {
        console.log(result);
        this.isLoading = true;
        const { data, error } = result;
        if (data) {
            this.bannerData = data;
            this.isLoading = false;
            if (data.length > 0) {
                this.showBanner = true;
            }
        }
        else if (error) {
            this.bannerData = null;
            this.isLoading = false;
            this.showBanner = false;
        }
    };
}