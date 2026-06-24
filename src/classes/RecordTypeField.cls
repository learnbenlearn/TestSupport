/**
 * TestSupport.TestDataField implementation for record type fields
 * @author Ben Learn
 * @since 06-24-2026
 * @group TestSupport
 */
@IsTest
public class RecordTypeField extends TestSupport.TestDataField {
    /**
     * Constructor to set up field specification for a record type field based on record type label/name
     * @param field
     * @param recordTypeName
     * @exception IllegalArgumentException
     */
    public RecordTypeField(Schema.SObjectField field, String recordTypeName) {
        DescribeSObjectResult objectDescribeResult = field.getDescribe().getSObjectType().getDescribe();
        Map<String, Schema.RecordTypeInfo> recordTypesByName = objectDescribeResult.getRecordTypeInfosByName();
        Map<String, Schema.RecordTypeInfo> recordTypesByDeveloperName = objectDescribeResult.getRecordTypeInfosByDeveloperName();
        Id recordTypeId;
        if(recordTypesByName.containsKey(recordTypeName)) {
            recordTypeId = recordTypesByName.get(recordTypeName).getRecordTypeId();
        } else if(recordTypesByDeveloperName.containsKey(recordTypeName)) {
            recordTypeId = recordTypesByDeveloperName.get(recordTypeName).getRecordTypeId();
        } else {
            throw new IllegalArgumentException('No record type found with ' + recordTypeName + ' as name or developer name.');
        }
        this.field = field;
        this.fieldJSON = String.format('"{0}": "{1}"', new List<Object>{field.getDescribe().getName(), recordTypeId});
    }

    /**
     * Constructor to set up field specification for a record type field based on record type id
     * @param field
     * @param recordTypeId
     */
    public RecordTypeField(Schema.SObjectField field, Id recordTypeId) {
        this.field = field;
        this.fieldJSON = String.format('"{0}": "{1}"', new List<Object>{field.getDescribe().getName(), recordTypeId});
    }
}