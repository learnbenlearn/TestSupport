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
        this.fieldJSON = String.format(
            '"{0}": "{1}-{2}-{3}T-{4}:{5}:{6}Z"',
            new List<Object>{
                field.getDescribe().getName(),
                dt.year(),
                TestSupport.formatTwoDigit(dt.month()),
                TestSupport.formatTwoDigit(dt.day()),
                TestSupport.formatTwoDigit(dt.hour()),
                TestSupport.formatTwoDigit(dt.minute()),
                TestSupport.formatTwoDigit(dt.second())
            }
        );
    }
}