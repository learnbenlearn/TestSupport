@isTest
public class ControlledValueField extends TestSupport.TestDataField {
    private Integer counter;
    private Integer numSuppliedValues;
    private List<Object> suppliedValues;

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