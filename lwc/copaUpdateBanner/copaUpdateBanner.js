import { LightningElement, api} from 'lwc';
import COPA_UPDATE_BANNER from '@salesforce/resourceUrl/copaUpdate';
import COPA_UPDATE_LOGO from '@salesforce/resourceUrl/copaUpdateLogo';

export default class CopaUpdateBanner extends LightningElement {
    copaBanner = COPA_UPDATE_BANNER;
    copaUpdateLogo = COPA_UPDATE_LOGO;
    @api currentCopaUpdate;

    get backgroundStyle() {
        return `background-image:url(${COPA_UPDATE_BANNER});background-repeat: no-repeat;background-size: contain;padding: 16.8%;height: 0;width: 100%;position: relative;`;
    }
}