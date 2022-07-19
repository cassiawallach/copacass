import { LightningElement, api } from 'lwc';

export default class FilterPill extends LightningElement {
    @api filterName;
    @api filterTitle;

    /**
     * Method to remove the filter.
     */
    removeFilter() {
        this.dispatchCustomEvent('remove',this.filterName);
    }

    /**
     * Method to dispatch the custom event.
     * @param {string} eventName 
     * @param {object} result 
     */
     dispatchCustomEvent(eventName, result) {
		const oEvent = new CustomEvent(eventName,
			{
				'detail': result
			}
		);
		this.dispatchEvent(oEvent);
	}
}