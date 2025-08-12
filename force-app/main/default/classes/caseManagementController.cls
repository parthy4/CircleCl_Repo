public without sharing class caseManagementController {

    @InvocableMethod(label='Case Status' description='Return case status as user ask for it')
    public static List<string>getCaseNumber(list<string>casenumber){
        List<case> cs= [select Id, Status from case where CaseNumber=: casenumber[0] limit 1];
        if(cs.size() >0){
            return new list<string>{cs[0].status};
        } else{
            return new list<string> {'Provide a valid Case Number'};
        }
    }
}