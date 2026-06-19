/**
 * Test utility class to abstract retrieval of picklist values for sObject fields and prevent storing picklist values for the same field multiple times in memory
 * @author Ben Learn
 * @since 07-21-2024
 * @group TestSupport
 */
@IsTest
public class PicklistValueManager {
    private static Map<Schema.SObjectType, Map<Schema.SObjectField, List<String>>> picklistValuesByObjectField = new Map<Schema.SObjectType, Map<Schema.SObjectField, List<String>>>();

    /**
     * Public method to return the values for the picklist field specified by provided sObjectType and sObjectField
     * @param sObjectType
     * @param sObjectField
     * @return  `List<String>`
     */
    public static List<String> getFieldValues(Schema.SObjectType sObjectType, Schema.SObjectField sObjectField) {
        if(picklistValuesByObjectField.containsKey(sObjectType) == false) {
            picklistValuesByObjectField.put(sObjectType, new Map<Schema.SObjectField, List<String>>());
        }

        Map<Schema.SObjectField, List<String>> fieldMap = picklistValuesByObjectField.get(sObjectType);

        if(fieldMap.containsKey(sObjectField) == false) {
            fieldMap.put(sObjectField, getValuesForSObjectField(sObjectField));
        }

        return fieldMap.get(sObjectField);
    }

    @TestVisible
    private static List<String> getValuesForSObjectField(Schema.SObjectField sObjectField) {
        if(sObjectField.getDescribe().getType() != Schema.DisplayType.Picklist && sObjectField.getDescribe().getType() != Schema.DisplayType.MultiPicklist) {
            throw new PicklistValueManagerException('PicklistValueManager called with non-picklist field.');
        }

        List<String> picklistValues = new List<String>();
        for(Schema.PicklistEntry pe : sObjectField.getDescribe().getPicklistValues()) {
            picklistValues.add(pe.getValue());
        }
        return picklistValues;
    }

    /**
     * Custom exception
     */
    public class PicklistValueManagerException extends Exception {}
}