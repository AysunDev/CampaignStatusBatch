public class CampaignUpdateBatch implements Database.Batchable<sObject> {
    
   public Database.QueryLocator start(Database.BatchableContext bc) {
       String query = 'SELECT Id, EndDate, Status FROM Campaign WHERE EndDate <= YESTERDAY AND Status != \'Expired\'';
       return Database.getQueryLocator(query);
   }

   public void execute(Database.BatchableContext bc, List<Campaign> cmpList) {
       try {
           if (!cmpList.isEmpty()) {
               for (Campaign cmp : cmpList) {
                   cmp.Status = 'Expired';
               }
               update cmpList;
           }          
       } catch (Exception e) {
           System.debug('Error updating campaigns: ' + e.getMessage());
       }
   }

   public void finish(Database.BatchableContext bc) {
       try {
           AppConfig__mdt config = [
               SELECT Notification_Email__c 
               FROM AppConfig__mdt 
               WHERE DeveloperName = 'Default' 
               LIMIT 1
           ];

           String recipient = config.Notification_Email__c;

           if (String.isNotBlank(recipient)) {
               Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
               mail.setToAddresses(new String[] { recipient });
               mail.setReplyTo('batch@acme.com');
               mail.setSenderDisplayName('Batch Processing');
               mail.setSubject('Batch Process Completed');
               mail.setPlainTextBody('The CampaignUpdateBatch has completed successfully.');

               Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
           }

       } catch (QueryException qe) {
           System.debug('Query error in finish(): ' + qe.getMessage());
       } catch (Exception e) {
           System.debug('Unknown error in finish(): ' + e.getMessage());
       }
   }
}
