public class CampaignUpdateBatch implements Database.Batchable<sObject> {
    
   public Database.QueryLocator start(Database.BatchableContext bc){
    String query = 'SELECT Id, EndDate,Status FROM Campaign WHERE EndDate <= YESTERDAY AND  Status != \'Expired\'';
      return Database.getQueryLocator(query);
   }

   public void execute(Database.BatchableContext bc, List<Campaign> cmpList){
     for(Campaign cmp : cmpList){
     cmp.Status = 'Expired';
     }
     update cmpList;
    }

   public void finish(Database.BatchableContext bc){
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

mail.setToAddresses(new String[] {'aysundoslu78@gmail.com'});
mail.setReplyTo('batch@acme.com');
mail.setSenderDisplayName('Batch Processing');
mail.setSubject('Batch Process Completed');
mail.setPlainTextBody('Batch Process has completed');

Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
}
   }