/**
 * TestSupport.TestDataField implementation for counter suffix fields. For each new record, will generate a field value that consists of a provided base value followed by an
 * incremented integer
 * @author Ben Learn
 * @since 07-21-2024
 * @group TestSupport
 */
@isTest
public class CounterSuffixField extends TestSupport.TestDataField {
    private Integer counter;

    /**
     * Constructor to set up field specification for a counter suffix field
     * @param field 
     * @param value 
     */    
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