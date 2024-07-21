/**
 * Main class for support generation of mock data for Apex tests.
 * @author Ben Learn
 * @since 07-21-2024
 * @group TestSupport
 */
@isTest
public class TestSupport {
    /**
     * Helper method to generate a random integer between 0 and a provided maxValue
     * @param maxValue 
     * @return  `Integer`
     */    
    public static Integer getRandomInteger(Integer maxValue) {
        return (Math.random() * maxValue).intValue();
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
     * Virtual class to represent fields in implementations/instantiations of DataGeneration class and subclasses
     */    
    public virtual class TestDataField {
        /**
         * field represented by the instantiation of this class
         */        
        public Schema.SObjectField field {get; protected set;}
        protected Object value;
        protected String fieldJSON;

        /**
         * public property determining if the field has a dynamic value or predefined constant value
         */        
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

        /**
         * Constructor for basic field specifications with a constant (non-dynamic) value
         * @param field 
         * @param value 
         */        
        public TestDataField(Schema.SObjectField field, Object value) {
            this.field = field;
            this.value = value;
            this.fieldJSON = '"' + field.getDescribe().getName() + '": "' + value + '"';
        }

        /**
         * Virtual method to return field-value pair in JSON format. Called by DataGeneration.generate() method
         * @return  `String`
         */        
        public virtual String getFieldJSON() {
            return this.fieldJSON;
        }

        /**
         * Virtual method to change the value of the field represented by an instantiation of this class. Not implemented in parent
         * class, but made available for subclasses if they can change the field value without needing any further information about 
         * what the new field value should be
         * @return  `Object`
         * @exception 
         */        
        public virtual Object changeFieldValue() {
            throw new TSException('Not implemented.');
        }

        /**
         * Virtual method to change the value of the field represented by an instantation of this class. Not implemented in parent
         * class, but made available for subclasses if they can change the field value based only on the current value of the field
         * @param currentFieldValue 
         * @return  `Object`
         * @exception 
         */        
        public virtual Object changeFieldValue(Object currentFieldValue) {
            throw new TSException('Not implemented.');
        }
    }

    /**
     * Abstract class to generate mock data for sObjects
     */    
    public abstract class DataGeneration {
        protected final String S_OBJECT_TYPE;

        /**
         * Public property to determine if the master records should be generated. Only used when generateRecordIDs is also true. Defaulted to false in constructor
         */
        public Boolean generateMasterRecords{get; set;}

        /**
         * Public property to determine if fake record IDs should be generated. Should be set to false when generated records are going to be inserted. Defaulted to true in 
         * constructor
         */        
        public Boolean generateRecordIDs {get; set;}

        /**
         * Public property to determine if default field specifications should be used. Defaulted to true in constructor
         */        
        public Boolean useFieldDefaults {get; set;}

        /**
         * Public property to specify number of mock records to generate on each call to generate(). Defaulted to 200 in constructor
         */        
        public Integer numberToGenerate {get; set;}

        /**
         * Public property to specify whether generate() calls should return only newly generated records or all records that have been generated to that point. Defaulted to
         * new in constructor
         */        
        public String generatorReturnValue {
            get; 
            set {
                if(value == 'all' || value == 'new' || value == null) {
                    this.generatorReturnValue = value;
                }
            }
        }

        protected Map<Schema.SObjectField, TestDataField> specsByField {
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
                    if(this.generateMasterRecords && this.generateRecordIDs) {
                        this.defaultSpecsByField.putAll(this.loadMasterDetailFields());
                    }
                }
                return this.defaultSpecsByField;
            }
            set;
        }

        protected Schema.SObjectField idField {
            get {
                if(this.idField == null) {
                    this.idField = Schema.describeSObjects(new List<String>{this.S_OBJECT_TYPE})[0].fields.getMap().get('Id'); 
                }
                return this.idField;
            }
            set;
        }

        protected IdField idFieldSpec {
            get {
                if(this.idFieldSpec == null && this.idField != null) {
                    this.idFieldSpec = new IdField(this.idField);
                }
                return this.idFieldSpec;
            }
            set;
        }

        /**
         * Property to hold all generated records
         */        
        public List<sObject> records {
            get {
                if(this.records == null) {
                    this.records = new List<sObject>();
                }
                return this.records;
            }
            protected set;
        }

        /**
         * Public property to hold modified copies of generated records. Used for modifying records before update operations or mocking of update operations
         */        
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
            this(options, new List<TestDataField>());
        }

        protected DataGeneration(Map<String, Object> options, List<TestDataField> fieldSpecs) {
            for(TestDataField fieldSpec : fieldSpecs) {
                this.specsByField.put(fieldSpec.field, fieldSpec);
            }

            this.generateMasterRecords = Boolean.valueOf(options.get('generateMasterRecords') ?? false);
            this.generateRecordIDs = Boolean.valueOf(options.get('generateRecordIDs') ?? true);
            this.useFieldDefaults = Boolean.valueOf(options.get('useFieldDefaults') ?? true);
            this.numberToGenerate = Integer.valueOf(options.get('numberToGenerate') ?? 200);
            this.generatorReturnValue = String.valueOf(options.get('generatorReturnValue') ?? 'new');
        }

        protected virtual Map<Schema.SObjectField, TestDataField> loadDefaultSpecsByField() {
            throw new TestSupport.TSException('Default field specs are not defined for this class.');
        }

        protected virtual Map<Schema.SObjectField, RelationshipField> loadMasterDetailFields() {
            throw new TestSupport.TSException('Master Detail field specs are not defined for this class.');
        }

        /**
         * Public method to set a field specification after instantiation of DataGeneration subclass. If a specification already exists for the provided field, this method will 
         * overwrite that existing specification. All other existing field specifications will be preserved.
         * @param fieldSpec 
         * @return  `DataGeneration`
         */        
        public DataGeneration setFieldSpec(TestDataField fieldSpec) {
            this.specsByField.put(fieldSpec.field, fieldSpec);
            return this;
        }

        /**
         * Public method to set multiple field specifications after instantiation of DataGeneration subclass. Any specifications that already exist for provided fields will
         * be overridden by this method. All other existing field specifications will be preserved.
         * @param fieldSpecs 
         * @return  `DataGeneration`
         */        
        public DataGeneration setFieldSpecs(List<TestDataField> fieldSpecs) {
            for(TestDataField fieldSpec : fieldSpecs) {
                this.specsByField.put(fieldSpec.field, fieldSpec);
            }
            return this;
        }

        /**
         * Public method to overwrite all field specifications after instantiation of DataGeneration subclass. Clears all existing specifications (whether a new specification for
         * that field is provided or not) and replaces them with provided field specifications.
         * @param fieldSpecs 
         * @return  `DataGeneration`
         */        
        public DataGeneration overwriteFieldSpecs(List<TestDataField> fieldSpecs) {
            this.specsByField.clear();
            return this.setFieldSpecs(fieldSpecs);
        }

        /**
         * Public method to generate mock data. Made virtual to allow subclasses to provide their own implementations if needed
         * @return  `List<sObject>`
         */        
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
                    if(this.specsByField.containsKey(fieldSpec.field) == false) {
                        if(fieldSpec.isDynamic) {
                            dynamicFields.add(fieldSpec);
                        } else {
                            jsonStaticFields.add(fieldSpec.getFieldJSON());
                        }
                    }
                }
            }

            if(this.generateRecordIDs && (this.idField != null) && (this.specsByField.containsKey(this.idField) == false)) {
                dynamicFields.add(this.idFieldSpec);
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

        /**
         * Fluent method to reset modifiedRecords property so that it matches records property. Changes to the existing records can then be made for purposes of update calls or
         * mocking update operations. Only needs to be called if wanting to discard existing record changes that have already been made
         * @return  `DataGeneration`
         */        
        public DataGeneration resetRecordChanges() {
            this.modifiedRecords = this.records.deepClone(true, true, true);
            return this;
        }

        /**
         * Fluent method to clear the value of a specified field in the modifiedRecords property
         * @param fieldToClear 
         * @return  `DataGeneration`
         */        
        public DataGeneration clearField(Schema.SObjectField fieldToClear) {
            String fieldName = fieldToClear.getDescribe().getName();
            for(sObject record : this.modifiedRecords) {
                record.put(fieldName, null);
            }
            return this;
        }

        /**
         * Fluent method to change the value of a specified field in the modifiedRecords property. Should only be called if field subclass implements 
         * changeFieldValue(Object currentFieldValue)
         * @param fieldToChange 
         * @return  `DataGeneration`
         * @exception throws TSException if there is not an existing field specification for the provided field
         */        
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

        /**
         * Overloaded fluent method to change the value of a specified field in the modifiedRecords property
         * @param fieldToChange 
         * @param newValue 
         * @return  `DataGeneration`
         */        
        public DataGeneration changeField(Schema.SObjectField fieldToChange, Object newValue) {
            String fieldName = fieldToChange.getDescribe().getName();
            for(sObject record : this.modifiedRecords) {
                record.put(fieldName, newValue);
            }
            return this;
        }
    }

    /**
     * Custom exception
     */    
    public class TSException extends Exception {}
}