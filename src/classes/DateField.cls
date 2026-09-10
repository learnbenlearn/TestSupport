/**
 * TestSupport.TestDataField implementation for Date fields
 * @author Ben Learn
 * @since 06-24-2026
 * @group TestSupport
 */
@IsTest
public class DateField extends TestSupport.TestDataField {
    /**
     * Constructor to set up field specification for a Date field
     * @param field
     * @param dateValue
     */
    public DateField(Schema.SObjectField field, Date dateValue) {
        this.field = field;
        String fieldJSON = '"${fieldName}": "${year}-${month}-${day}"'.template(new Map<String, Object>{
            'fieldName' => field.getDescribe().getName(),
            'year' => dateValue.year(),
            'month' => TSUtils.formatTwoDigit(dateValue.month()),
            'day' => TSUtils.formatTwoDigit(dateValue.day())
        });
        super.setFieldJSON(fieldJSON);
    }
}