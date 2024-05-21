@isTest
private class PicklistValueManagerTests {

    @isTest
    private static void getFieldValues_PicklistField_ReturnsFieldValues() {
        List<String> accountRatings = PicklistValueManager.getValuesForSObjectField(Account.Rating);
        List<String> accountOwnerships = PicklistValueManager.getValuesForSObjectField(Account.Ownership);

        Assert.areEqual(accountRatings, PicklistValueManager.getFieldValues(Account.sObjectType, Account.Rating), 'Unequal picklist values when PicklistValueManager has no entries for object.');
        Assert.areEqual(accountOwnerships, PicklistValueManager.getFieldValues(Account.sObjectType, Account.Ownership), 'Unequal picklist values when PicklistValueManager has entries for object but not field.');
        Assert.areEqual(accountRatings, PicklistValueManager.getFieldValues(Account.sObjectType, Account.Rating), 'Unequal picklist values when PicklistValueManager has entries for object and field.');
    }

    @isTest
    private static void getFieldValues_NonPicklistField_ThrowsError() {
        Exception err;
        try {
            List<String> accountNames = PicklistValueManager.getFieldValues(Account.sObjectType, Account.Name);
        } catch(Exception e) {
            err = e;
        }
        Assert.isInstanceOfType(err, PicklistValueManager.PicklistValueManagerException.class, 'Expected PicklistValueManagerException when calling PicklistValueManager with non-picklist field.');
    }
}