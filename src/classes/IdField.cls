/**
 * TestSupport.TestDataField implementation for Id fields. For each new record, will generate a fake record ID that consists of the three character key prefix for the specified
 * sObject followed by an incremented integer
 * @author Ben Learn
 * @since 07-21-2024
 * @group TestSupport
 */
@IsTest
public class IdField extends TestSupport.TestDataField {
    private static final Integer ID_FIELD_PADDING_LENGTH = 15;
    private Integer counter;

    /**
     * Constructor to set up field specification for an Id field
     * @param field
     */
    public IdField(Schema.SObjectField field) {
        this.counter = 0;
        
        this.field = field;
        this.isDynamic = true;
        this.fieldJSON = '"' + field.getDescribe().getName() + '": "' + field.getDescribe().getSObjectType().getDescribe().getKeyPrefix() + '{0}"';
    }

    public override String getFieldJSON() {
        return this.fieldJSON.replace('{0}', String.valueOf(this.counter++).leftPad(ID_FIELD_PADDING_LENGTH, '0'));
    }
}