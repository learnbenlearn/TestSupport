@IsTest
public class DateField extends TestSupport.TestDataField {
    /**
     * Constructor to set up field specification for a Date field
     * @param field
     * @param dateValue
     */
    public DateField(Schema.SObjectField field, Date dateValue) {
        this.field = field;
        this.fieldJSON = String.format(
            '"{0}": "{1}-{2}-{3}"',
            new List<Object>{
                field.getDescribe().getName(),
                dateValue.year(),
                TestSupport.formatTwoDigit(dateValue.month()),
                TestSupport.formatTwoDigit(dateValue.day())
            }
        );
    }
}