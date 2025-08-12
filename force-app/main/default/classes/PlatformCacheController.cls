public with sharing class PlatformCacheController {
    
	@AuraEnabled
	public static void storeDataController(){
		Contact cont = [SELECT Id, FirstName, LastName, AccountId FROM Contact WHERE Id = '003gK000001FzFZQA0' LIMIT 1];
		Cache.Session.put('DefaultPartition', cont);
	//	Cache.Session.put('local.TacoCat.DefaultPartition', cont);
	}

	@AuraEnabled
	public static Contact retrieveDataCacheController(){
		return (Contact) Cache.Session.get('DefaultPartition');
		// Data Retrived
	}

	@AuraEnabled
	public static Contact retrieveDataSOQLController(){
		return [SELECT Id, FirstName, LastName, AccountId FROM Contact WHERE Id = '003gK000001FzFZQA0' LIMIT 1];
	} 
  
}