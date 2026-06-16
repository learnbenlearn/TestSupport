@IsTest
public class RecordTypeField extends TestSupport.TestDataField {
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

    public RecordTypeField(Schema.SObjectField field, Id recordTypeId) {
        this.field = field;
        this.fieldJSON = String.format('"{0}": "{1}"', new List<Object>{field.getDescribe().getName(), recordTypeId});
    }
}