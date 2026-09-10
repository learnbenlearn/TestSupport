/**
 * TestSupport.TestDataField implementation for counter fields. For each new record, will generate an incremented integer value
 * @author Ben Learn
 * @since 09-10-2026
 * @group TestSupport
 */
@IsTest
public class CounterField extends TestSupport.TestDataField {
    private Integer counter;

    /**
     * Constructor for a counter field with a starting integer of 0
     * @param field
     */
    public CounterField(Schema.SObjectField field) {
        this(field, 0);
    }

    /**
     * Constructor for a counter field with a custom starting integer
     * @param field
     * @param startingValue
     */
    public CounterField(Schema.SObjectField field, Integer startingValue) {
        this.field = field;
        this.isDynamic = true;
        this.counter = startingValue;
        String fieldJSONTemplate = '"' + this.field.getDescribe().getName() + '": ${counter}';
        super.checkTypeCompatibility(field, this.counter);
        super.setFieldJSON(
            fieldJSONTemplate,
            fieldJSONTemplate.template(new Map<String, Object>{'counter' => this.counter})
        );
    }

    public override String getFieldJSON() {
        return this.fieldJSON.template(new Map<String, Object>{'counter' => this.counter++});
    }
}