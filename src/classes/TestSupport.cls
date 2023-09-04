@isTest
public class TestSupport {
    public enum Tags {
        COUNTER_SUFFIX,
        RANDOM_PICKLIST_VALUE
    }

    private final static List<Tags> STANDALONE_TAGS = new List<Tags>{
        Tags.RANDOM_PICKLIST_VALUE
    };

    public class FieldSpecification {
        Schema.SObjectField field;
        Object value;
        Tags tag;

        public FieldSpecification(Schema.SObjectField field, Object value) {
            this.field = field;
            this.value = value;
        }

        public FieldSpecification(Schema.SObjectField field, Object value, Tags tag) {
            this.field = field;
            this.value = value;
            if(STANDALONE_TAGS.contains(tag)) {
                throw new TSException('Chosen tag is a standalone tag. Field value should not be provided with tag.');
            } else {
                this.tag = tag;
            }
        }

        public FieldSpecification(Schema.SObjectField field, Tags tag) {
            this.field = field;
            if(STANDALONE_TAGS.contains(tag)) {
                this.tag = tag;
            } else {
                throw new TSException('Chosen tag is not a standalone tag. Field value should be provided with tag.');
            }
        }
    }

    public class Picklist {
        public Schema.SObjectField field {get; private set;}
        public List<String> values {get; private set;}

        public Picklist(Schema.SObjectField field) {
            this.field = field;

            List<String> values = new List<String>();
            for(Schema.PicklistEntry pe : field.getDescribe().getPicklistValues()) {
                values.add(pe.getValue());
            }
            this.values = values;
        }

    }

    public abstract class DataGeneration {
        private Integer idSuffix = 0;
        private final String ID_PREFIX;

        protected String recordJSONProperties; // final?? .. should this be a singleton or not?
        protected List<String> recordJSONOrderedPicklists; // final??
        protected String sObjectType; // make constant later

        protected final Map<String, List<String>> PICKLIST_VALUES_BY_FIELD; // should this be populated by a separate setter?

        public Boolean bypassDuplicateRules {get; set;} // probably drop this as well?
        public Boolean insertRecords {get; set;} // drop this
        public Boolean returnCreatedRecords {get; set;} // drop this
        public Boolean updateRecords {get; set;} // where is this used?
        public Boolean useFieldDefaults {get; set;} // add support for this
        public Integer numberToGenerate {get; set;}
        public Map<Id, sObject> records {get; protected set;}
        public Map<Id, sObject> modifiedRecords {
            get {
                if(this.modifiedRecords == null) {
                    this.modifiedRecords = new Map<Id, sObject>(this.records.values().deepClone(true, true, true));
                }
                return this.modifiedRecords;
            }
            protected set;
        }
    
        protected DataGeneration(Map<String, Object> options, String idPrefix) {
            this.bypassDuplicateRules = options.containsKey('bypassDuplicateRules') ? Boolean.valueOf(options.get('bypassDuplicateRules')) : false;
            this.insertRecords = options.containsKey('insertRecords') ? Boolean.valueOf(options.get('insertRecords')) : false;
            this.returnCreatedRecords = options.containsKey('returnCreatedRecords') ? Boolean.valueOf(options.get('returnCreatedRecords')) : true;
            this.updateRecords = options.containsKey('updateRecords') ? Boolean.valueOf(options.get('updateRecords')) : false;
            this.useFieldDefaults = options.containsKey('useFieldDefaults') ? Boolean.valueOf(options.get('useFieldDefaults')) : true;
            this.numberToGenerate = options.containsKey('numberToGenerate') ? Integer.valueOf(options.get('numberToGenerate')) : 200;
            this.ID_PREFIX = idPrefix;
        }

        protected DataGeneration(Map<String, Object> options, String idPrefix, List<FieldSpecification> fieldSpecs) {
            List<String> properties =  new List<String>();
            List<String> orderedPicklists = new List<String>();
            Integer formatArg = 1;
            for(FieldSpecification fs : fieldSpecs) {
                if(fs.tag == null) {
                    properties.add('"' + fs.field.getDescribe().getName() + '": "' + fs.value + '"');
                } else if(fs.tag == Tags.COUNTER_SUFFIX) {
                    // this assumes there's always a counter suffix field...
                    properties.add('"' + fs.field.getDescribe().getName() + '": "' + fs.value + '{0}"');
                } else if(fs.tag == Tags.RANDOM_PICKLIST_VALUE) {
                    properties.add('"' + fs.field.getDescribe().getName() + '": "{' + formatArg + '}"');
                    orderedPicklists.add(fs.field.getDescribe().getName());
                    formatArg++;
                }
            }
            
            this.recordJSONProperties = String.join(properties, ', ');
            this.recordJSONOrderedPicklists = orderedPicklists;

            this.bypassDuplicateRules = options.containsKey('bypassDuplicateRules') ? Boolean.valueOf(options.get('bypassDuplicateRules')) : false;
            this.insertRecords = options.containsKey('insertRecords') ? Boolean.valueOf(options.get('insertRecords')) : false;
            this.returnCreatedRecords = options.containsKey('returnCreatedRecords') ? Boolean.valueOf(options.get('returnCreatedRecords')) : true;
            this.updateRecords = options.containsKey('updateRecords') ? Boolean.valueOf(options.get('updateRecords')) : false;
            this.useFieldDefaults = options.containsKey('useFieldDefaults') ? Boolean.valueOf(options.get('useFieldDefaults')) : true;
            this.numberToGenerate = options.containsKey('numberToGenerate') ? Integer.valueOf(options.get('numberToGenerate')) : 200;
            this.ID_PREFIX = idPrefix;
        }

        public abstract List<sObject> generate();

        public virtual List<sObject> generateFromRecordJSON() {
            List<sObject> records = new List<sObject>();

            List<Object> recordJSONObjects = new List<Object>();
            for(Integer i = 0; i < this.numberToGenerate; i++) {
                List<Object> formatArguments = new List<Object>();
                formatArguments.add(i);
                for(String picklist : this.recordJSONOrderedPicklists) {
                    formatArguments.add(this.getRandomPicklistValue(this.PICKLIST_VALUES_BY_FIELD.get(picklist)));
                }
                // boolean to see if includes any tags. no tags => no string.format call

                records.add((sObject) JSON.deserialize('{' + String.format(this.recordJSONProperties, formatArguments) + '}', Type.forName(this.sObjectType)));
            }
            if(this.insertRecords) insert records;
            // abstract for insert vs publish platform events?

            return this.returnCreatedRecords ? records : null;
        }

        



        protected String generateRecordId() {
            String recordId = ID_PREFIX + String.valueOf(idSuffix).leftPad(15, '0');
            idSuffix += 1;
            return recordId;
        }

        // abstract picklist stuff into separate class
        protected String getRandomPicklistValue(List<String> picklistValues) {
            Integer randomIndex = (Math.random() * (picklistValues.size() - 1)).intValue();
            return picklistValues[randomIndex];
        }

        protected String getNewRandomPicklistValue(List<String> picklistValues, Object currentPicklistValue) {
            Integer currentPicklistValueIndex = picklistValues.indexOf(String.valueOf(currentPicklistValue));
            Integer randomIndex;
            do {
                randomIndex = (Math.random() * (picklistValues.size() - 1)).intValue();
            } while(currentPicklistValueIndex == randomIndex);
            return picklistValues[randomIndex];
        }

        public DataGeneration resetRecordChanges() {
            this.modifiedRecords = new Map<Id, sObject>(this.records.values().deepClone(true, true, true));
            return this;
        }

        // should field stuff be in separate class as well?
        public DataGeneration clearField(Schema.DescribeFieldResult fieldToClear) {
            String fieldName = fieldToClear.getName();
            for(sObject record : this.modifiedRecords.values()) {
                record.put(fieldName, null);
            }
            return this;
        }

        public DataGeneration changeField(Schema.DescribeFieldResult fieldToChange, Object newValue) {
            String fieldName = fieldToChange.getName();
            for(sObject record : this.modifiedRecords.values()) {
                record.put(fieldName, newValue);
            }
            return this;
        }

        protected DataGeneration changePicklistField(Schema.DescribeFieldResult fieldToChange, List<String> picklistValues) {
            if(fieldToChange.getType() != Schema.DisplayType.PICKLIST) {
                throw new TSException('Cannot call changePicklistField() with non-picklist field.');
            }

            String fieldName = fieldToChange.getName();
            for(sObject record : this.modifiedRecords.values()) {
                record.put(fieldName, this.getNewRandomPicklistValue(picklistValues, record.get(fieldName)));
            }
            return this;
        }
    }



    public class TSException extends Exception {}
}