/**
 * TestSupport.TestDataField implementation for Boolean fields
 * @author Ben Learn
 * @since 07-21-2024
 * @group TestSupport
 */
@isTest
public class BooleanField extends TestSupport.TestDataField {
    private Boolean currentBoolValue;

    /**
     * Default constructor to set up field specification for a Boolean field. Defaults value for first generated record to true
     * @param field 
     */    
    public BooleanField(Schema.SObjectField field) {
        this(field, true);
    }

    /**
     * Overloaded constructor to set up field specification for a Boolean field with custom value for first generated record
     * @param field 
     * @param initialBoolValue 
     */    
    public BooleanField(Schema.SObjectField field, Boolean initialBoolValue) {
        this.currentBoolValue = initialBoolValue;
        this.field = field;
        this.isDynamic = true;
        this.fieldJSON = '"' + field.getDescribe().getName() + '": {0}';
    }

    public override String getFieldJSON() {
        Boolean temp = this.currentBoolValue;
        this.currentBoolValue = !this.currentBoolValue;
        return this.fieldJSON.replace('{0}', String.valueOf(temp));
    }
}