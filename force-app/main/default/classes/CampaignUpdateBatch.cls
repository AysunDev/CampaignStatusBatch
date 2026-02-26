public with sharing class AccountUtility {

    public static Account getAccountById(Id accId) {
        List<Account> accs = [SELECT Id FROM Account WHERE Id = :accId LIMIT 1];
        return accs.isEmpty() ? null : accs[0];
    }

    public static Account getAccountByName(String accName) {
        List<Account> accs = [SELECT Id, Name FROM Account WHERE Name = :accName LIMIT 1];
        return accs.isEmpty() ? null : accs[0];
    }

    public static List<Account> getAllAccounts() {
        return [SELECT Id, Name, Active__c FROM Account];
    }

    public static List<Account> getActiveAccounts() {
        return [SELECT Id, Active__c FROM Account WHERE Active__c = 'Yes'];
    }

    public static List<Account> getInactiveAccounts() {
        return [SELECT Id, Active__c FROM Account WHERE Active__c = 'No'];
    }

    public static void updateRatingOfAccounts(String rating) {
        List<Account> accs = [SELECT Id, Rating FROM Account WHERE Rating != :rating LIMIT 2000];
        if (accs.isEmpty()) return;

        for (Account a : accs) a.Rating = rating;
        update accs;
    }
}
