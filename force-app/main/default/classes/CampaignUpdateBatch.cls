global class CampaignUpdateBatch implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Status, EndDate
            FROM Campaign
            WHERE EndDate < :Date.today()
            AND Status != 'Expired'
        ]);
    }

    global void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Campaign> updates = (List<Campaign>) scope;
        for (Campaign c : updates) {
            c.Status = 'Expired';
        }
        if (!updates.isEmpty()) {
            update updates;
        }
    }

    global void finish(Database.BatchableContext bc) {
        // optional logging
    }
}
