@isTest
public class RelationshipField extends TestSupport.TestDataField {
    private Integer counter;
    private Integer numParentRecords;
    private List<Id> parentRecordIds;
    
    public RelationshipField(Schema.SObjectField field, Set<Id> parentRecordIds) {
        this.counter = 0;
        this.field = field;
        this.numParentRecords = parentRecordIds.size();
        this.parentRecordIds = new List<Id>(parentRecordIds);
        this.isDynamic = true;
        this.fieldJSON = '"' + field.getDescribe().getName() + '": "{0}"';
    }

    public override String getFieldJSON() {
        Integer temp = this.counter;
        this.counter += 1;
        return this.fieldJSON.replace('{0}', this.parentRecordIds[Math.mod(temp, this.numParentRecords)]);
    }
}