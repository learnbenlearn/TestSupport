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
        List<String> picklistValues;
        if(picklistValuesByObjectField.containsKey(sObjectType)) {
            if(picklistValuesByObjectField.get(sObjectType).containsKey(sObjectField)) {
                picklistValues = picklistValuesByObjectField.get(sObjectType).get(sObjectField);
            } else {
                picklistValues = getValuesForSObjectField(sObjectField);
                Map<Schema.SObjectField, List<String>> picklistValuesForSObject = picklistValuesByObjectField.get(sObjectType);
                picklistValuesForSObject.put(sObjectField, picklistValues);
                picklistValuesByObjectField.put(sObjectType, picklistValuesForSObject);
            }
        } else {
            picklistValues = getValuesForSObjectField(sObjectField);
            picklistValuesByObjectField.put(sObjectType, new Map<Schema.SObjectField, List<String>>{sObjectField => picklistValues});
        }
        return picklistValues;
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