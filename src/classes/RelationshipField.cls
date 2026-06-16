/**
 * TestSupport.TestDataField implementation for relationship fields
 * @author Ben Learn
 * @since 07-21-2024
 * @group TestSupport
 */
@IsTest
public class RelationshipField extends TestSupport.TestDataField {
    private Integer counter;
    private Integer numParentRecords;
    private List<Id> parentRecordIds;
    
    /**
     * Constructor to setup field specification for a relationship field.
     * @param field Schema.SObjectField instance for desired relationship field
     * @param parentRecordIds Set of parent record IDs to iterate through when generating records including relationship field
     */
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