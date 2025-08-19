public with sharing class AccountRelatedDetailsController {
    
    public class OutputResponse{
        @InvocableVariable
        public String Prompt;
    }
    
    public class InputRequest{
        @InvocableVariable(required=true)
        public Account RelatedEntity;
    }

    @InvocableMethod(label='Account Related Details'
                     description='Getting the Account Related Details'
                     capabilityType='PromptTemplateType://einstein_gpt__fieldCompletion')
    public static List<OutputResponse> getAccountRelatedDetails(List<InputRequest> requests) {
        List<OutputResponse> responses = new List<OutputResponse>();

        if (requests == null || requests.isEmpty() || requests[0].RelatedEntity == null) {
            OutputResponse res = new OutputResponse();
            res.Prompt = 'No Account provided.';
            responses.add(res);
            return responses;
        }

        Account acc = requests[0].RelatedEntity;
        StringBuilder sb = new StringBuilder();

        List<Contact> contacts = [SELECT Name, Email FROM Contact WHERE AccountId = :acc.Id];
        if (!contacts.isEmpty()) {
            for (Contact con : contacts) {
                sb.append(String.format('Contact Details:- Name is {0} and Email is {1}\n', new List<Object>{ con.Name, con.Email }));
            }
        } else {
            sb.append('There are no contact records\n');
        }

        List<Case> cases = [SELECT CaseNumber, Status FROM Case WHERE AccountId = :acc.Id];
        if (!cases.isEmpty()) {
            for (Case c : cases) {
                sb.append(String.format('Case Details:- CaseNumber is {0} and Status is {1}\n', new List<Object>{ c.CaseNumber, c.Status }));
            }
        } else {
            sb.append('There are no Case records\n');
        }

        List<Opportunity> opportunities = [SELECT Name, Amount, StageName FROM Opportunity WHERE AccountId = :acc.Id];
        if (!opportunities.isEmpty()) {
            for (Opportunity opp : opportunities) {
                sb.append(String.format('Opportunity Details:- Name is {0}, Amount is {1} and StageName is {2}\n', new List<Object>{ opp.Name, opp.Amount, opp.StageName }));
            }
        } else {
            sb.append('There are no Opportunity records\n');
        }

        OutputResponse res = new OutputResponse();
        res.Prompt = sb.toString();
        responses.add(res);

        return responses;
    }
}