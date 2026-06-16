@IsTest
private class AccountTSExampleUse {
    @IsTest
    private static void testAccountGeneration() {
        AccountTSExample generator = new AccountTSExample(
            TSDataGenerationConfig.builder().setGenerateMasterRecords(false).setNumberToGenerate(5).setGeneratorReturnValue(
                TSDataGenerationConfig.GeneratorReturnValue.NEW_RECORDS
            ).build()
        );
        List<Account> generatedAccounts = (List<Account>) generator.generate();

        Boolean stateAndCountryPicklistsEnabled = Schema.SObjectType.Account.fields.getMap().containsKey('ShippingStateCode');
        Assert.areEqual(5, generatedAccounts.size());
        for(Integer i = 0; i < generatedAccounts.size(); i++) {
            Assert.areEqual('Test Account ' + i, generatedAccounts[i].Name);
            Assert.areEqual('223 4567890', generatedAccounts[i].Phone);
            Assert.areEqual('1 Beaver Stadium', generatedAccounts[i].ShippingStreet);
            Assert.areEqual('University Park', generatedAccounts[i].ShippingCity);
            if(stateAndCountryPicklistsEnabled) {
                Assert.areEqual('PA', generatedAccounts[i].ShippingStateCode);
            } else {
                Assert.areEqual('Pennsylvania', generatedAccounts[i].ShippingState);
            }
            Assert.areEqual('16802', generatedAccounts[i].ShippingPostalCode);
        }
    }
}