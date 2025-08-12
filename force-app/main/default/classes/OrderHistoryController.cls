public with sharing class OrderHistoryController {
    
    public class wrapperRequest{
   	 @InvocableVariable(required=true description='Pass the customer email to context variable')
    	 public string customerEmail;
	}

	public class wrapperResponse{
    	@InvocableVariable(description='show the customer order in the UI')
   	    public list<order> orders;
	}
    
	@InvocableMethod(label='Get Customer Orders' description='Get the customer orders based on their emails')
    public static List<WrapperResponse> transferCases(List<wrapperRequest> requests){
        
    List<WrapperResponse> returnResponse = new List<WrapperResponse> ();
    WrapperResponse response = new WrapperResponse ();
    response.orders=[select Id, Customer_Email__c, ordernumber, description, Status, EffectiveDate, Name from Order where Customer_Email__c = :requests[0].customerEmail];
    returnResponse.add(response);
    return returnResponse;
	}

}