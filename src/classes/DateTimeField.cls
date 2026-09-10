/**
 * TestSupport.TestDataField implementation for DateTime fields
 * @author Ben Learn
 * @since 07-21-2024
 * @group TestSupport
 */
@IsTest
public class DateTimeField extends TestSupport.TestDataField {
    /**
     * Constructor to set up field specification for a DateTime field
     * @param field
     * @param dt
     */
    public DateTimeField(Schema.SObjectField field, DateTime dt) {
        this.field = field;
        String fieldJSON = '"${fieldName}": "${year}-${month}-${day}T-${hour}:${minute}:${second}Z"'.template(new Map<String, Object>{
            'fieldName' => field.getDescribe().getName(),
            'year' => dt.year(),
            'month' => TSUtils.formatTwoDigit(dt.month()),
            'day' => TSUtils.formatTwoDigit(dt.day()),
            'hour' => TSUtils.formatTwoDigit(dt.hour()),
            'minute' => TSUtils.formatTwoDigit(dt.minute()),
            'second' => TSUtils.formatTwoDigit(dt.second())
        });
        super.setFieldJSON(fieldJSON);
    }
}