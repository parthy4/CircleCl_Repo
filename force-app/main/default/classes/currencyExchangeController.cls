public without sharing class currencyExchangeController {
    
    public class currencyConverter{        
        @InvocableVariable(required=true description='Pass the source current code given by the User')
        public string covertFrom;
        
        @InvocableVariable(required=true description='Pass the destination current code given by the User')
        public string covertTo;
        
        @InvocableVariable(required=true description='Pass the amount value given by the User')
        public decimal amount;        
    }
    
     public class currencyOutput{        
        @InvocableVariable(description='Total Conversion Rate')
        public decimal totalConversionRate;
     }
    
    public class conversionResponse{
        public string result;
        public decimal conversion_result;
    }

    @InvocableMethod(callout=true
                     label='Currency Exchange Service'
                     description='Convert the given amount from one currency to another')
    
    public static List<currencyOutput> getcurrencydetails(List<currencyConverter>requests){
        string api_key = System.Label.CurrencyExchangeEndpoint;
        string endpoint = 'https://v6.exchangerate-api.com/v6/' +api_key+ '/pair/'+
            			   requests[0].covertFrom + '/' + requests[0].covertTo + '/' + requests[0].amount;
        
        currencyOutput result = new currencyOutput();
        
        Http http = new Http();
        httpRequest req = new httpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        
        try{
           HttpResponse res = Http.send(req);
            if(res.getStatusCode() == 200){
                conversionResponse response = (conversionResponse) JSON.deserialize(res.getBody(), conversionResponse.class);
                if( response != null ){
                    result.totalConversionRate = response.conversion_result;
                }
            }            
        }
        catch(exception ex){
            system.debug( 'Error ::::'+ ex);
        }
        
        return new List<currencyOutput>{ result };
    }
}