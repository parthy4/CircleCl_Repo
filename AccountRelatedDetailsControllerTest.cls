@isTest
private class AccountRelatedDetailsControllerTest {

    @isTest
    static void testGetAccountRelatedDetails_WithData() {
        // 1. Setup test data
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Contact con = new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            Email = 'test@contact.com',
            AccountId = acc.Id
        );
        insert con;

        Case c = new Case(
            Status = 'New',
            Origin = 'Web',
            AccountId = acc.Id
        );
        insert c;
        // We need to requery to get the auto-generated CaseNumber
        c = [SELECT CaseNumber FROM Case WHERE Id = :c.Id];

        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30),
            Amount = 50000,
            AccountId = acc.Id
        );
        insert opp;

        // 2. Prepare request
        AccountRelatedDetailsController.InputRequest req = new AccountRelatedDetailsController.InputRequest();
        req.RelatedEntity = new Account(Id = acc.Id);
        List<AccountRelatedDetailsController.InputRequest> requests = new List<AccountRelatedDetailsController.InputRequest>{ req };

        // 3. Call method
        Test.startTest();
        List<AccountRelatedDetailsController.OutputResponse> responses = AccountRelatedDetailsController.getAccountRelatedDetails(requests);
        Test.stopTest();

        // 4. Assert results
        System.assertEquals(1, responses.size(), 'Should return one response wrapper.');
        
        String prompt = responses[0].Prompt;
        System.assert(prompt != null, 'Prompt should not be null.');
        
        System.assert(prompt.contains('Contact Details:- Name is Test Contact and Email is test@contact.com'), 'Prompt should contain contact details.');
        System.assert(prompt.contains('Case Details:- CaseNumber is ' + c.CaseNumber + ' and Status is New'), 'Prompt should contain case details.');
        System.assert(prompt.contains('Opportunity Details:- Name is Test Opp, Amount is 50000 and StageName is Prospecting'), 'Prompt should contain opportunity details.');
    }

    @isTest
    static void testGetAccountRelatedDetails_NoData() {
        // 1. Setup test data
        Account acc = new Account(Name = 'Test Account No Children');
        insert acc;

        // 2. Prepare request
        AccountRelatedDetailsController.InputRequest req = new AccountRelatedDetailsController.InputRequest();
        req.RelatedEntity = new Account(Id = acc.Id);
        List<AccountRelatedDetailsController.InputRequest> requests = new List<AccountRelatedDetailsController.InputRequest>{ req };

        // 3. Call method
        Test.startTest();
        List<AccountRelatedDetailsController.OutputResponse> responses = AccountRelatedDetailsController.getAccountRelatedDetails(requests);
        Test.stopTest();

        // 4. Assert results
        System.assertEquals(1, responses.size(), 'Should return one response wrapper.');
        
        String prompt = responses[0].Prompt;
        System.assert(prompt != null, 'Prompt should not be null.');
        
        System.assert(prompt.contains('There are no contact records'), 'Prompt should indicate no contacts.');
        System.assert(prompt.contains('There are no Case records'), 'Prompt should indicate no cases.');
        System.assert(prompt.contains('There are no Opportunity records'), 'Prompt should indicate no opportunities.');
    }
}

