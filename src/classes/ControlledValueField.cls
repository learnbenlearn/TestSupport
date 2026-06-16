/**
 * TestSupport.TestDataField implementation for controlled value fields. Mostly used for picklist fields, but can be used for any field that should have one of a set of
 * predefined values. Iterates through set of predefined values with each generated record
 * @author Ben Learn
 * @since 07-21-2024
 * @group TestSupport
 */
@IsTest
public class ControlledValueField extends TestSupport.TestDataField {
    private Integer counter;
    private Integer numSuppliedValues;
    private List<Object> suppliedValues;

    /**
     * Constructor to set up field specification for a controlled value field
     * @param field
     * @param suppliedValues
     */
    public ControlledValueField(Schema.SObjectField field, List<Object> suppliedValues) {
        this.counter = 0;
        this.field = field;
        this.numSuppliedValues = suppliedValues.size();
        this.suppliedValues = suppliedValues;
        this.isDynamic = true;
        this.fieldJSON = '"' + field.getDescribe().getName() + '": "{0}"';
    }

    public override String getFieldJSON() {
        Integer temp = this.counter;
        this.counter += 1;
        return this.fieldJSON.replace('{0}', String.valueOf(this.suppliedValues[Math.mod(temp, this.numSuppliedValues)]));
    }
}