public without sharing class AccountRelatedRecordController {
    @InvocableMethod(label='Account Contact Agent Action' 
                     description='This agent is used for the getting the contact details from Account object')
    
    public static list<string>getInformations(List<string>accNumber){
        List<Account>acc = [select id, Name, AccountNumber, (select Name from Contacts) from account where AccountNumber=: accNumber Limit 1];
        system.debug('Output'+acc);
        if(acc.size()>0){
            List<string> updcont = new list<string>();            
                for(contact conlst: acc[0].Contacts){
                    updcont.add(conlst.Name);
                } 
            return updcont; 
          //  return new list<string>{updcont[0].Name};
        }else{
            return new list<string>{'Provide a valid an Account Number'};
        }
    }

}