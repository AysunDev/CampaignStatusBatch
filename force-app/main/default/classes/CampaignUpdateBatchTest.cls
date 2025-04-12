@isTest
public class CampaignUpdateBatchTest {

    @testSetup
    static void markAsExpiredSetup() {
        List<Campaign> cmpList = new List<Campaign>();

        for (Integer i = 0; i < 2; i++) {
            cmpList.add(new Campaign(
                Name = 'Test Campaign ' + i,
                EndDate = Date.today().addDays(-1),
                Status = 'Planned' // Status != 'Expired' olacak şekilde
            ));
        }

        insert cmpList;
    }

    @isTest
    static void updateStatusTest() {
        Test.startTest();
        Database.executeBatch(new CampaignUpdateBatch(), 200);
        Test.stopTest();

        // Güncellemeden sonra, artık Status 'Expired' olmalı
        List<Campaign> updatedList = [SELECT Id, Status FROM Campaign];
        for (Campaign cmp : updatedList) {
            System.assertEquals('Expired', cmp.Status, 'Campaign status should be updated to Expired');
        }
    }
}
