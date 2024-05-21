@isTest
public class TestSupport {
    public static Integer getRandomInteger(Integer maxValue) {
        return (Math.random() * maxValue).intValue();
    }

    public virtual class TestDataField {
        public Schema.SObjectField field {get; protected set;}
        protected Object value;
        protected String fieldJSON;

        public Boolean isDynamic {
            get {
                if(this.isDynamic == null) {
                    this.isDynamic = false;
                }
                return this.isDynamic;
            }
            protected set;
        }

        // empty constructor for children classes
        @SuppressWarnings('PMD.EmptyStatementBlock')
        protected TestDataField() {}

        public TestDataField(Schema.SObjectField field, Object value) {
            this.field = field;
            this.value = value;
            this.fieldJSON = '"' + field.getDescribe().getName() + '": "' + value + '"';
        }

        public virtual String getFieldJSON() {
            return this.fieldJSON;
        }

        public virtual Object changeFieldValue() {
            throw new TSException('Not implemented.');
        }

        public virtual Object changeFieldValue(Object currentFieldValue) {
            throw new TSException('Not implemented.');
        }
    }

    public abstract class DataGeneration {
        protected final String S_OBJECT_TYPE;

        public Boolean generateRecordIDs {get; set;}
        public Boolean useFieldDefaults {get; set;}
        public Integer numberToGenerate {get; set;}
        public String generatorReturnValue {
            get; 
            set {
                if(value == 'all' || value == 'new' || value == null) {
                    this.generatorReturnValue = value;
                }
            }
        }

        public Map<Schema.SObjectField, TestDataField> specsByField {
            get {
                if(this.specsByField == null) {
                    this.specsByField = new Map<Schema.SObjectField, TestDataField>();
                }
                return specsByField;
            }
            set;
        }

        protected Map<Schema.SObjectField, TestDataField> defaultSpecsByField {
            get {
                if(this.defaultSpecsByField == null) {
                    this.defaultSpecsByField = this.loadDefaultSpecsByField();
                    if(this.generateRecordIDs && (this.S_OBJECT_TYPE.endsWith('__e') == false)) {
                        Schema.SObjectField idSObjectField = Schema.describeSObjects(new List<String>{this.S_OBJECT_TYPE})[0].fields.getMap().get('Id');
                        this.defaultSpecsByField.put(idSObjectField, new IdField(idSObjectField));
                    }
                }
                return this.defaultSpecsByField;
            }
            protected set;
        }     

        public List<sObject> records {
            get {
                if(this.records == null) {
                    this.records = new List<sObject>();
                }
                return this.records;
            }
            protected set;
        }

        public List<sObject> modifiedRecords {
            get {
                if(this.modifiedRecords == null) {
                    this.modifiedRecords = this.records.deepClone(true, true, true);
                }
                return this.modifiedRecords;
            }
            protected set;
        }
    
        protected DataGeneration(Map<String, Object> options) {
            this.generateRecordIDs = options.containsKey('generateRecordIDs') ? Boolean.valueOf(options.get('generateRecordIDs')) : true;
            this.useFieldDefaults = options.containsKey('useFieldDefaults') ? Boolean.valueOf(options.get('useFieldDefaults')) : true;
            this.numberToGenerate = options.containsKey('numberToGenerate') ? Integer.valueOf(options.get('numberToGenerate')) : 200;
            this.generatorReturnValue = options.containsKey('generatorReturnValue') ? String.valueOf(options.get('generatorReturnValue')) : 'new';
        }

        protected DataGeneration(Map<String, Object> options, List<TestDataField> fieldSpecs) {
            for(TestDataField fieldSpec : fieldSpecs) {
                this.specsByField.put(fieldSpec.field, fieldSpec);
            }

            this.generateRecordIDs = options.containsKey('generateRecordIDs') ? Boolean.valueOf(options.get('generateRecordIDs')) : false;
            this.useFieldDefaults = options.containsKey('useFieldDefaults') ? Boolean.valueOf(options.get('useFieldDefaults')) : true;
            this.numberToGenerate = options.containsKey('numberToGenerate') ? Integer.valueOf(options.get('numberToGenerate')) : 200;
            this.generatorReturnValue = options.containsKey('generatorReturnValue') ? String.valueOf(options.get('generatorReturnValue')) : 'new';
        }

        protected virtual Map<Schema.SObjectField, TestDataField> loadDefaultSpecsByField() {
            throw new TestSupport.TSException('Default field specs are not defined for this class.');
        }

        public void setFieldSpec(TestDataField fieldSpec) {
            this.specsByField.put(fieldSpec.field, fieldSpec);
        }

        public void setFieldSpecs(List<TestDataField> fieldSpecs) {
            for(TestDataField fieldSpec : fieldSpecs) {
                this.specsByField.put(fieldSpec.field, fieldSpec);
            }
        }

        public void overwriteFieldSpecs(List<TestDataField> fieldSpecs) {
            this.specsByField.clear();
            this.setFieldSpecs(fieldSpecs);
        }

        public virtual List<sObject> generate() {
            List<String> jsonRecords = new List<String>();

            List<TestDataField> dynamicFields = new List<TestDataField>();
            List<String> jsonStaticFields = new List<String>();
            for(TestDataField fieldSpec : this.specsByField.values()) {
                if(fieldSpec.isDynamic) {
                    dynamicFields.add(fieldSpec);
                } else {
                    jsonStaticFields.add(fieldSpec.getFieldJSON());
                }
            }

            if(this.useFieldDefaults) {
                for(TestDataField fieldSpec : this.defaultSpecsByField.values()) {
                    if(specsByField.containsKey(fieldSpec.field) == false) {
                        if(fieldSpec.isDynamic) {
                            dynamicFields.add(fieldSpec);
                        } else {
                            jsonStaticFields.add(fieldSpec.getFieldJSON());
                        }
                    }
                }
            }

            for(Integer i = 0; i < this.numberToGenerate; i++) {
                List<String> jsonFields = new List<String>();
                for(TestDataField dynamicField : dynamicFields) {
                    jsonFields.add(dynamicField.getFieldJSON());
                }
                jsonFields.addAll(jsonStaticFields);
                jsonRecords.add('{' + String.join(jsonFields, ', ') + '}');
            }

            if(this.generatorReturnValue == 'new') {
                List<sObject> tempRecords = (List<sObject>) JSON.deserialize('[' + String.join(jsonRecords, ', ') + ']', Type.forName('List<' + this.S_OBJECT_TYPE + '>'));
                this.records.addAll(tempRecords);
                return tempRecords;
            } else if(this.generatorReturnValue == 'all') {
                this.records.addAll((List<sObject>) JSON.deserialize('[' + String.join(jsonRecords, ', ') + ']', Type.forName('List<' + this.S_OBJECT_TYPE + '>')));
                return this.records;
            } else {
                return null;
            }
        }

        public DataGeneration resetRecordChanges() {
            this.modifiedRecords = this.records.deepClone(true, true, true);
            return this;
        }

        public DataGeneration clearField(Schema.DescribeFieldResult fieldToClear) {
            String fieldName = fieldToClear.getName();
            for(sObject record : this.modifiedRecords) {
                record.put(fieldName, null);
            }
            return this;
        }

        public DataGeneration changeField(Schema.SObjectField fieldToChange) {
            String fieldName = fieldToChange.getDescribe().getName();
            TestDataField fieldSpec;
            if(this.specsByField.containsKey(fieldToChange)) {
                fieldSpec = this.specsByField.get(fieldToChange);
            } else if(this.defaultSpecsByField.containsKey(fieldToChange)) {
                fieldSpec = this.defaultSpecsByField.get(fieldToChange);
            } else {
                throw new TSException('No specification for this field.' + (this.useFieldDefaults ? ' There is no default specification for this field.' : ''));
            }

            for(sObject record : this.modifiedRecords) {
                record.put(fieldName, fieldSpec.changeFieldValue(record.get(fieldName)));
            }

            return this;
        }

        public DataGeneration changeField(Schema.SObjectField fieldToChange, Object newValue) {
            String fieldName = fieldToChange.getDescribe().getName();
            for(sObject record : this.modifiedRecords) {
                record.put(fieldName, newValue);
            }
            return this;
        }
    }

    public class TSException extends Exception {}
}