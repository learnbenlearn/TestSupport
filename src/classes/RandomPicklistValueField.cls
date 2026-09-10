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
        String fieldJSONTemplate = '"' + field.getDescribe().getName() + '": "${randomPicklistValue}"';
        super.setFieldJSON(
            fieldJSONTemplate,
            fieldJSONTemplate.template(new Map<String, Object>{
                'randomPicklistValue' => this.picklistValues[TSUtils.getRandomInteger(this.numPicklistValues)]
            })
        );
    }

    public override String getFieldJSON() {
        return this.fieldJSON.template(new Map<String, Object>{
            'randomPicklistValue' => this.picklistValues[TSUtils.getRandomInteger(this.numPicklistValues)]
        });
    }

    public override Object changeFieldValue(Object currentFieldValue) {
        Integer currentPicklistIndex = this.picklistValues.indexOf(String.valueOf(currentFieldValue));
        Integer randomIndex = TSUtils.getRandomInteger(this.numPicklistValues - 1);
        Integer newPicklistIndex = Math.mod(randomIndex == currentPicklistIndex ? randomIndex + 1 : randomIndex, numPicklistValues);
        return this.picklistValues[newPicklistIndex];
    }
}