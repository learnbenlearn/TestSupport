@IsTest
private class AccountTSExampleUse {
    @IsTest
    private static void testAccountGeneration() {
        AccountTSExample generator = new AccountTSExample(
            TSDataGenerationConfig.builder().setMode(TSGeneratorMode.SINGLE_RECORD).setGeneratorReturnValue(
                TSGeneratorReturnValue.NEW_RECORDS
            ).build()
        );
        List<Account> generatedAccounts = (List<Account>) generator.generate();

        Boolean stateAndCountryPicklistsEnabled = Schema.SObjectType.Account.fields.getMap().containsKey('ShippingStateCode');
        Assert.areEqual('Test Account 0', generatedAccounts[0].Name);
        Assert.areEqual('223 4567890', generatedAccounts[0].Phone);
        Assert.areEqual('1 Beaver Stadium', generatedAccounts[0].ShippingStreet);
        Assert.areEqual('University Park', generatedAccounts[0].ShippingCity);
        if(stateAndCountryPicklistsEnabled) {
            Assert.areEqual('PA', generatedAccounts[0].ShippingStateCode);
        } else {
            Assert.areEqual('Pennsylvania', generatedAccounts[0].ShippingState);
        }
        Assert.areEqual('16802', generatedAccounts[0].ShippingPostalCode);
    }
}