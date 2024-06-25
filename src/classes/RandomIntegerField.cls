@isTest
public class RandomIntegerField extends TestSupport.TestDataField {
    private Integer min;
    private Integer max;

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