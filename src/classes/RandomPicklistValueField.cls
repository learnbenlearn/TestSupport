/**
 * TestSupport.TestDataField implementation for random picklist fields. Will return a random value from the picklist definition
 * @author Ben Learn
 * @since 07-21-2024
 * @group TestSupport
 */
@IsTest
public class RandomPicklistValueField extends TestSupport.TestDataField {
    private List<String> picklistValues;
    private Integer numPicklistValues;

    /**
     * Constructor to set up field specification for a random picklist field
     * @param field
     */
    public RandomPicklistValueField(Schema.SObjectField field) {
        this.field = field;

        this.picklistValues = PicklistValueManager.getFieldValues(field.getDescribe().getSObjectType(), field);
        this.numPicklistValues = this.picklistValues.size();
        this.isDynamic = true;
        this.fieldJSON = '"' + field.getDescribe().getName() + '": "{0}"';
    }

    public override String getFieldJSON() {
        return this.fieldJSON.replace('{0}', this.picklistValues[TestSupport.getRandomInteger(this.numPicklistValues)]);
    }

    public override Object changeFieldValue(Object currentFieldValue) {
        Integer currentPicklistIndex = this.picklistValues.indexOf(String.valueOf(currentFieldValue));
        Integer randomIndex = TestSupport.getRandomInteger(this.numPicklistValues - 1);
        Integer newPicklistIndex = Math.mod(randomIndex == currentPicklistIndex ? randomIndex + 1 : randomIndex, numPicklistValues - 1);
        return this.picklistValues[newPicklistIndex];
    }
}