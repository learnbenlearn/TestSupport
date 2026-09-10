@IsTest
public class AccountTSExample extends TestSupport.DataGeneration {
    protected override String getSObjectType() {
        return 'Account';
    }

    public AccountTSExample() {
        super();
    }
    public AccountTSExample(TSDataGenerationConfig config) {
        super(config);
    }
    public AccountTSExample(TSDataGenerationConfig config, List<TestSupport.TestDataField> fieldSpecs) {
        super(config, fieldSpecs);
    }

    protected override Map<Schema.SObjectField, TestSupport.TestDataField> loadDefaultSpecsByField() {
        Boolean stateAndCountryPicklistsEnabled = Schema.SObjectType.Account.fields.getMap().containsKey('ShippingStateCode');

        Map<Schema.SObjectField, TestSupport.TestDataField> defaultSpecsByField = TestSupport.toSpecsByField(new List<TestSupport.TestDataField>{
            new CounterSuffixField(Account.Name, 'Test Account '),
            new TestSupport.TestDataField(Account.Phone, '223 4567890'),
            new TestSupport.TestDataField(Account.ShippingStreet, '1 Beaver Stadium'),
            new TestSupport.TestDataField(Account.ShippingCity, 'University Park'),
            new TestSupport.TestDataField(Account.ShippingPostalCode, '16802')
        });
        if(stateAndCountryPicklistsEnabled) {
            defaultSpecsByField.put(Account.ShippingStateCode, new TestSupport.TestDataField(Account.ShippingStateCode, 'PA'));
        } else {
            defaultSpecsByField.put(Account.ShippingState, new TestSupport.TestDataField(Account.ShippingState, 'Pennsylvania'));
        }
        
        return defaultSpecsByField;
    }
}