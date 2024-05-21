@isTest
public class IdField extends TestSupport.TestDataField {
    private Integer counter;

    public IdField(Schema.SObjectField field) {
        this.counter = 0;
        
        this.field = field;
        this.isDynamic = true;
        this.fieldJSON = '"' + field.getDescribe().getName() + '": "' + field.getDescribe().getSObjectType().getDescribe().getKeyPrefix() + '{0}"';
    }

    public override String getFieldJSON() {
        return this.fieldJSON.replace('{0}', String.valueOf(this.counter++).leftPad(15, '0'));
    }
}