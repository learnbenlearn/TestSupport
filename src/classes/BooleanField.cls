@isTest
public class BooleanField extends TestSupport.TestDataField {
    private Boolean currentBoolValue;

    public BooleanField(Schema.SObjectField field) {
        this(field, true);
    }

    public BooleanField(Schema.SObjectField field, Boolean initialBoolValue) {
        this.currentBoolValue = initialBoolValue;
        this.field = field;
        this.isDynamic = true;
        this.fieldJSON = '"' + field.getDescribe().getName() + '": {0}"';
    }

    public override String getFieldJSON() {
        Boolean temp = this.currentBoolValue;
        this.currentBoolValue = !this.currentBoolValue;
        return this.fieldJSON.replace('{0}', String.valueOf(temp));
    }
}