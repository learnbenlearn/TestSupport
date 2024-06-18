@isTest
public class DateTimeField extends TestSupport.TestDataField {
    public DateTimeField(Schema.SObjectField field, DateTime dt) {
        this.field = field;
        this.fieldJSON = String.format(
            '"{0}": "{1}-{2}-{3}T-{4}:{5}:{6}Z"', 
            new List<Object>{
                field.getDescribe().getName(), 
                dt.year(), 
                formatTwoDigit(dt.month()), 
                formatTwoDigit(dt.day()), 
                formatTwoDigit(dt.hour()), 
                formatTwoDigit(dt.minute()), 
                formatTwoDigit(dt.second())
            }
        );
    }

    private String formatTwoDigit(Integer num) {
        String numString = String.valueOf(num);
        return numString.length() == 1 ? '0' + numString : numString;
    }
}