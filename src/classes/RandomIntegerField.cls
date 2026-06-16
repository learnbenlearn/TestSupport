/**
 * TestSupport.TestDataField implementation for random integer fields that will have a value between the provided min and max
 * @author Ben Learn
 * @since 07-21-2024
 * @group TestSupport
 */
@IsTest
public class RandomIntegerField extends TestSupport.TestDataField {
    private Integer min;
    private Integer max;

    /**
     * Constructor to set up field specification for a random integer field
     * @param field
     * @param min
     * @param max
     */
    public RandomIntegerField(Schema.SObjectField field, Integer min, Integer max) {
        this.field = field;
        this.isDynamic = true;
        this.min = min;
        this.max = max;
        this.fieldJSON = '"' + field.getDescribe().getName() + '": {0}';
    }

    public override String getFieldJSON() {
        return this.fieldJSON.replace('{0}', String.valueOf(Integer.valueOf(Math.floor(Math.random() * (this.max - this.min) + this.min))));
    }
}