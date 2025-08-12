import {LightningElement} from 'lwc';
import retrieveDataCacheController from '@salesforce/apex/PlatformCacheController.retrieveDataCacheController';
import retrieveDataSOQLController from '@salesforce/apex/PlatformCacheController.retrieveDataSOQLController';
import storeDataController from '@salesforce/apex/PlatformCacheController.storeDataController';

export default class PlatformCacheLwc extends LightningElement {

   connectedCallback() {
		this.storeData()
	}

	storeData(){
		storeDataController().then(()=>{
			console.log('We stored the data');
		})
	}


	retrieveDataCache(){
		retrieveDataCacheController().then(data =>{
            console.log('This is the Cache data ::: ' + JSON.stringify(data));
		})
	}

	retrieveDataSOQL(){
		retrieveDataSOQLController().then(data =>{
			console.log('This is the SOQL data ::: ' + JSON.stringify(data));
		})
	}
}