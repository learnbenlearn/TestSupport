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
    public AccountTSExample(TSDataGenerationConfig config, List<TestDataField> fieldSpecs) {
        super(config, fieldSpecs);
    }

    protected override Map<Schema.SObjectField, TestDataField> loadDefaultSpecsByField() {
        Boolean stateAndCountryPicklistsEnabled = Schema.SObjectType.Account.fields.getMap().containsKey('ShippingStateCode');

        Map<Schema.SObjectField, TestDataField> defaultSpecsByField = new Map<Schema.SObjectField, TestDataField>{
            Account.Name => new CounterSuffixField(Account.Name, 'Test Account '),
            Account.Phone => new TestSupport.TestDataField(Account.Phone, '223 4567890'),
            Account.ShippingStreet => new TestSupport.TestDataField(Account.ShippingStreet, '1 Beaver Stadium'),
            Account.ShippingCity => new TestSupport.TestDataField(Account.ShippingCity, 'University Park'),
            Account.ShippingPostalCode => new TestSupport.TestDataField(Account.ShippingPostalCode, '16802')
        };
        if(stateAndCountryPicklistsEnabled) {
            defaultSpecsByField.put(Account.ShippingStateCode, new TestSupport.TestDataField(Account.ShippingStateCode, 'PA'));
        } else {
            defaultSpecsByField.put(Account.ShippingState, new TestSupport.TestDataField(Account.ShippingState, 'Pennsylvania'));
        }
        
        return defaultSpecsByField;
    }
}