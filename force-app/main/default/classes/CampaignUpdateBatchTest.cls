@isTest
public class CampaignUpdateBatchTest {
    @testSetup
    static void makAsExpiredSetup(){
        List<Campaign> cmpList = new List<Campaign>();
        
        for(integer i=0 ; i<2 ; i++){
            Campaign cmp = new Campaign();
            cmp.Name= 'Test Campaign ' + i;
            date dt = Date.today();
            cmp.EndDate = dt.addDays(-1);
            cmp.Status='Planned';
            cmpList.add(cmp);
        }
        insert cmpList;
        
    }
        @isTest
        static void updateStatusTest(){
            Test.startTest();
        
            CampaignUpdateBatch b = new CampaignUpdateBatch(); 
      Database.executeBatch(b);
            Test.stopTest();
                List<Campaign> cmpList1 = [SELECT Id,Status FROM Campaign WHERE EndDate <= YESTERDAY AND Status != 'Expired'];
                  for(Campaign cmp : cmpList1){
          System.assertEquals('Expired', cmp.Status, 'Campaign status should be updated to Expired');
        }
        
    }
          
    }