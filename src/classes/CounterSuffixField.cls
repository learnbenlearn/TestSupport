@isTest
public class CounterSuffixField extends TestSupport.TestDataField {
    private Integer counter;

    public CounterSuffixField(Schema.SObjectField field, Object value) {
        this.counter = 0;

        this.field = field;
        this.value = value;
        this.isDynamic = true;
        this.fieldJSON = '"' + this.field.getDescribe().getName() + '": "' + this.value + '{0}"';
    }

    public override String getFieldJSON() {
        return this.fieldJSON.replace('{0}', String.valueOf(this.counter++));
    }
    
}