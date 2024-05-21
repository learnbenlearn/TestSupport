@isTest
public class RelationshipField extends TestSupport.TestDataField {
    private Integer counter;
    private Integer numParentRecords;
    private List<Id> parentRecords;
    
    public RelationshipField(Schema.SObjectField field, List<Id> parentRecords) {
        this.counter = 0;
        this.field = field;
        this.numParentRecords = parentRecords.size();
        this.parentRecords = parentRecords;
        this.isDynamic = true;
        this.fieldJSON = '"' + field.getDescribe().getName() + '": "{0}"';
    }

    public override String getFieldJSON() {
        Integer temp = this.counter;
        this.counter += 1;
        return this.fieldJSON.replace('{0}', this.parentRecords[Math.mod(temp, this.numParentRecords)]);
    }
}