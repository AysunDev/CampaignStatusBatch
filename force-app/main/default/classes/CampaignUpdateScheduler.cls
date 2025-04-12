public class CampaignUpdateScheduler implements  Schedulable {

    
    public void execute(SchedulableContext SC){
        
     
            CampaignUpdateBatch b = new CampaignUpdateBatch(); 
      Database.executeBatch(b,200);
}
}