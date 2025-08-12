public with sharing class EscalateCaseController {
    
    public class wrapperRequest{
        @InvocableVariable(required= true description='Pass the case number given by the user')
        public String casenumber;
    }

    public class wrapperResponse{        
        @InvocableVariable(description='Show the message to the UI')
        public String message;
    }
    
    @InvocableMethod(label='Escalate Case ' description= 'Escalate the case to the correct team')
    Public static List<WrapperResponse> transferCases(List<wrapperRequest> requests){
        List<wrapperResponse> returnResponse = new List<wrapperResponse>();
        case cs = [SELECT Id, type, casenumber FROM Case WHERE Casenumber=:requests[0].casenumber LIMIT 1];
        Group queue = [SELECT Id FROM Group WHERE Type='Queue' AND Name =: cs.Type];
        cs.OwnerId = queue.Id;
        update cs;
        
        wrapperResponse res = new wrapperResponse();
        res.message = 'Case '+cs.CaseNumber+' is successfully transferred to the '+cs.Type+ 'team';
        returnResponse.add(res);
        return returnResponse;
    }
    
}