/**
 * Utility class for test support functionality
 * @author Ben Learn
 * @since 09-09-2026
 * @group TestSupport
 */
@IsTest
public class TSUtils {
    /**
     * Helper method to generate a random integer between 0 and a provided maxValue
     * @param maxValue
     * @return  `Integer`
     */
    public static Integer getRandomInteger(Integer maxValue) {
        return getRandomInteger(0, maxValue);
    }

    /**
     * Helper method to generate a random integer between provided min and max values
     * @param minValue
     * @param maxValue
     * @return  `Integer`
     */
    public static Integer getRandomInteger(Integer minValue, Integer maxValue) {
        return (Math.random() * (maxValue - minValue) + minValue).intValue();
    }

    /**
     * Helper method to return one digit integers as two digits left-padded with a 0. Used for date/datetime formatting
     * @param num
     * @return  `String`
     */
    public static String formatTwoDigit(Integer num) {
        String numString = String.valueOf(num);
        return numString.length() == 1 ? '0' + numString : numString;
    }

    /**
     * Helper method to generate test user with provided details
     * @param alias
     * @param email
     * @param lastName
     * @param profileName
     * @param username
     * @return  `User`
     */
    public static User generateTestUser(String alias, String email, String lastName, String profileName, String username) {
        return generateTestUser(alias, email, lastName, profileName, 'America/New_York', username);
    }

    /**
     * Overloaded helper method to generate test user with provided details including custom timeZoneSidKey
     * @param alias
     * @param email
     * @param lastName
     * @param profileName
     * @param timeZoneSidKey
     * @param username
     * @return  `User`
     */
    public static User generateTestUser(String alias, String email, String lastName, String profileName, String timeZoneSidKey, String username) {
        User u = new User(
            Alias = alias,
            Email = email,
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LastName = lastName,
            LocaleSidKey = 'en_US',
            ProfileId = [SELECT Id FROM Profile WHERE Name = :profileName].Id,
            TimeZoneSidKey = timeZoneSidKey,
            Username = username
        );
        return u;
    }

    /**
     * Utility method to generate `Map<Schema.SObjectField, TestSupport.TestDataField>` from `List<TestSupport.TestDataField>`
     * @param fieldSpecs
     * @return  `Map<Schema.SObjectField, TestSupport.TestDataField>`
     */
    public static Map<Schema.SObjectField, TestSupport.TestDataField> toSpecsByField(List<TestSupport.TestDataField> fieldSpecs) {
        Map<Schema.SObjectField, TestSupport.TestDataField> specsByField = new Map<Schema.SObjectField, TestSupport.TestDataField>();
        for(TestSupport.TestDataField fieldSpec : fieldSpecs) {
            specsByField.put(fieldSpec.field, fieldSpec);
        }
        return specsByField;
    }

    /**
     * Helper method to check if provided value is valid for field data type through SoapType
     * @param soapType
     * @param value
     * @return  `Boolean`
     */
    public static Boolean isTypeCompatibleValue(Schema.SoapType soapType, Object value) {
        if(value == null) {
            return true;
        }
        switch on soapType {
            when Boolean {
                return value instanceof Boolean;
            } when Date {
                return value instanceof Date;
            } when DateTime {
                return value instanceof DateTime;
            } when Time {
                return value instanceof Time;
            } when Integer {
                return value instanceof Integer;
            } when Double {
                return value instanceof Decimal || value instanceof Double || value instanceof Integer;
            } when ID {
                return value instanceof Id || value instanceof String;
            } when String {
                return value instanceof String;
            } when base64binary {
                return value instanceof Blob;
            } when else {
                return true;
            }
        }
    }
}