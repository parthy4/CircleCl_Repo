public class AccountRelatedDetailsController {
    
    public class OutputResponse{
        @InvocableVariable
        public string Prompt;
    }
    
    public class InputResquest{
        @InvocableVariable
        public Account RelatedEntity;
    }

    //Loading the Invocable Method
    //This method is used to get the Account related details like Contacts, Cases and Opportunities
    
    @InvocableMethod(label= 'Account Related Details'
                     description= 'Getting the Account Related Details'
    				 CapabilityType= 'PromptTemplateType://einstein_gpt__fieldCompletion')
    
    public static List<OutputResponse> getAccountReleatedDetails(List<InputResquest>request ){
        
       List <OutputResponse> outresp = New List <OutputResponse>();
        
        string responseString = null;
        Account AccId = request[0].RelatedEntity;
        
        List<contact> contacts = [select Id, Name, Email from contact where AccountId=: AccId.Id];
        if(contacts.size()>0){ 
            for(contact con: contacts){
                responseString = responseString+ string.format('Contact Details:- Name is {0} and Email is {1}', new list <object>{con.Name, con.Email});
                responseString = responseString + '\n';
            } 
        }
        else {
            responseString = responseString +'There are no contact records' +'\n';
        }
        
        
        List<Case> cases = [select Id, CaseNumber, Status from Case where AccountId=: AccId.Id];
        if(contacts.size()>0){ 
            for(Case objCon: cases){
                responseString = responseString+ string.format('Case Details:- CaseNumber is {0} and Status is {1}', new list <object>{objCon.CaseNumber, objCon.Status});
                responseString = responseString + '\n';
            }
        } else {
            responseString = responseString +'There are no Case records' +'\n';
            
        }
        
        List<Opportunity> opp = [select Id, Name, Amount, StageName from Opportunity where AccountId=: AccId.Id];
        if(opp.size()>0){ 
            for(Opportunity objOpp: opp){
                responseString = responseString+ string.format('Opportunity Details:- Name is {0}, Amount is{1} and StageName is {2}', new list <object>{objOpp.Name, objOpp.Amount, objOpp.StageName});
                responseString = responseString + '\n';
            } 
        } else {
            responseString = responseString +'There are no Opportunity records' +'\n';
            
        }
        
        OutputResponse res= new OutputResponse();
        res.Prompt = responseString;
        outresp.add(res);
            
        return outresp;
    }

}