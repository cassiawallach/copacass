import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import CertificateVerificationBanner from '@salesforce/resourceUrl/CertificateVerificationBanner';
import CommunityImages from '@salesforce/resourceUrl/Community';
import fetchAllStudents from '@salesforce/apex/CertificationValidatorController.fetchAllStudents';
import fetchAllCertifications from '@salesforce/apex/CertificationValidatorController.fetchAllCertifications';

export default class CertificationValidator extends LightningElement {
    certificationBanner = CertificateVerificationBanner;
    searchKey = '';
    isLoading = false;
    studentsData = [];
    isNoResultFound = false;
    certificationsData = [];
    showCertificationsData = false;

    get showStudentData() {
        return this.searchKey != '' ? true : false;
    }

    get isVerifyDisable() {
        return this.searchKey == '' ? true : false;
    }

    get hasStudentsData() {
        return this.studentsData.length > 0 ? true : false;
    }

    get hasCertificationsData() {
        return this.certificationsData.length > 0 ? true : false;
    }

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
       if (currentPageReference) {
          var urlStateParameters = currentPageReference.state;
          var stdId = urlStateParameters.StudentId || null;
          if(stdId != null){
            this.viewCertificationData(stdId);
          }
       }
    }

    handleSearch(event) {
        this.searchKey = event.target.value;
        this.reset();
    }

    reset() {
        this.isLoading = false;
        this.studentsData = [];
        this.isNoResultFound = false;
        this.certificationsData = [];
        this.showCertificationsData = false;
    }

    handleVerify() {
        this.isLoading = true;
        fetchAllStudents({ searchKey: this.searchKey })
            .then(result => {
                this.isLoading = false;
                this.studentsData = result;
                this.isNoResultFound = result.length > 0 ? false : true;
            })
            .catch(error => {
                console.log(error);
                this.isLoading = false;
            });
    }

    handleViewCertification(event) {
        this.viewCertificationData(event.target.name);
    }

    viewCertificationData(stdId){
        this.isLoading = true;
        fetchAllCertifications({ stdId: stdId })
            .then(result => {
                this.isLoading = false;

                var allCerts = [];
                result.forEach(function (data) {
                    var cetData = data;
                    var badgeName = (data.Certification_Program__r.Name).replaceAll(" ", "_");
                    cetData.badgeUrl = CommunityImages + '/CommunityResources/badges/' + badgeName + '.png';
                    allCerts.push(cetData);
                });

                this.certificationsData = allCerts;
                this.showCertificationsData = true;
            })
            .catch(error => {
                console.log(error);
                this.isLoading = false;
            });
    }

    closeModal() {
        this.showCertificationsData = false;
    }
}