@IsTest
public class TSDataGenerationConfig {
    public enum GeneratorReturnValue {NEW_RECORDS, ALL_RECORDS}

    public final Boolean generateMasterRecords {get; set;}
    public final Boolean generateMasterRecordsWasSet {get; set;}
    public final Boolean generateRecordIDs {get; set;}
    public final Boolean generateRecordIDsWasSet {get; set;}
    public final Boolean useFieldDefaults {get; set;}
    public final Boolean useFieldDefaultsWasSet {get; set;}
    public final Integer numberToGenerate {get; set;}
    public final Boolean numberToGenerateWasSet {get; set;}
    public final GeneratorReturnValue generatorReturnValue {get; set;}
    public final Boolean generatorReturnValueWasSet {get; set;}

    public TSDataGenerationConfig(TSDataGenerationConfigBuilder builder) {
        this.generateMasterRecords = builder.getGenerateMasterRecords();
        this.generateMasterRecordsWasSet = builder.generateMasterRecordsWasSet;
        this.generateRecordIDs = builder.getGenerateRecordIDs();
        this.generateRecordIDsWasSet = builder.generateRecordIDsWasSet;
        this.useFieldDefaults = builder.getUseFieldDefaults();
        this.useFieldDefaultsWasSet = builder.useFieldDefaultsWasSet;
        this.numberToGenerate = builder.getNumberToGenerate();
        this.numberToGenerateWasSet = builder.numberToGenerateWasSet;
        this.generatorReturnValue = builder.getGeneratorReturnValue();
        this.generatorReturnValueWasSet = builder.generatorReturnValueWasSet;
    }

    public static TSDataGenerationConfigBuilder builder() {
        return new TSDataGenerationConfigBuilder();
    }

    private static GeneratorReturnValue getGeneratorReturnValue(String generatorReturnValueString) {
        generatorReturnValueString = generatorReturnValueString.toUpperCase();
        if(generatorReturnValueString == 'NEW' || generatorReturnValueString == 'NEW_RECORDS') {
            return GeneratorReturnValue.NEW_RECORDS;
        } else if(generatorReturnValueString == 'ALL' || generatorReturnValueString == 'ALL_RECORDS') {
            return GeneratorReturnValue.ALL_RECORDS;
        }
        return null;
    }

    public class TSDataGenerationConfigBuilder {
        private Boolean generateMasterRecords = false;
        private Boolean generateRecordIDs = true;
        private Boolean useFieldDefaults = true;
        private Integer numberToGenerate = 200;
        private TSDataGenerationConfig.GeneratorReturnValue generatorReturnValue;

        private Boolean generateMasterRecordsWasSet {
            get {
                if(this.generateMasterRecordsWasSet == null) {
                    this.generateMasterRecordsWasSet = false;
                }
                return this.generateMasterRecordsWasSet;
            }
            set;
        }
        private Boolean generateRecordIDsWasSet {
            get {
                if(this.generateRecordIDsWasSet == null) {
                    this.generateRecordIDsWasSet = false;
                }
                return this.generateRecordIDsWasSet;
            }
            set;
        }
        private Boolean useFieldDefaultsWasSet {
            get {
                if(this.useFieldDefaultsWasSet == null) {
                    this.useFieldDefaultsWasSet = false;
                }
                return this.useFieldDefaultsWasSet;
            }
            set;
        }
        private Boolean numberToGenerateWasSet {
            get {
                if(this.numberToGenerateWasSet == null) {
                    this.numberToGenerateWasSet = false;
                }
                return this.numberToGenerateWasSet;
            }
            set;
        }
        private Boolean generatorReturnValueWasSet {
            get {
                if(this.generatorReturnValueWasSet == null) {
                    this.generatorReturnValueWasSet = false;
                }
                return this.generatorReturnValueWasSet;
            }
            set;
        }

        public TSDataGenerationConfigBuilder setGenerateMasterRecords(Boolean generateMasterRecords) {
            this.generateMasterRecords = generateMasterRecords == null ? false : generateMasterRecords;
            this.generateMasterRecordsWasSet = true;
            return this;
        }

        public TSDataGenerationConfigBuilder setGenerateRecordIDs(Boolean generateRecordIDs) {
            this.generateRecordIDs = generateRecordIDs == null ? true : generateRecordIDs;
            this.generateRecordIDsWasSet = true;
            return this;
        }

        public TSDataGenerationConfigBuilder setUseFieldDefaults(Boolean useFieldDefaults) {
            this.useFieldDefaults = useFieldDefaults == null ? true : useFieldDefaults;
            this.useFieldDefaultsWasSet = true;
            return this;
        }

        public TSDataGenerationConfigBuilder setNumberToGenerate(Integer numberToGenerate) {
            this.numberToGenerate = numberToGenerate == null ? 200 : numberToGenerate;
            this.numberToGenerateWasSet = true;
            return this;
        }

        public TSDataGenerationConfigBuilder setGeneratorReturnValue(TSDataGenerationConfig.GeneratorReturnValue generatorReturnValue) {
            this.generatorReturnValue = generatorReturnValue;
            this.generatorReturnValueWasSet = true;
            return this;
        }

        public TSDataGenerationConfig build() {
            return new TSDataGenerationConfig(this);
        }

        // Accessors for TSDataGenerationConfig
        public Boolean getGenerateMasterRecords() {
            return generateMasterRecords;
        }

        public Boolean getGenerateRecordIDs() {
            return generateRecordIDs;
        }

        public Boolean getUseFieldDefaults() {
            return useFieldDefaults;
        }

        public Integer getNumberToGenerate() {
            return numberToGenerate;
        }

        public TSDataGenerationConfig.GeneratorReturnValue getGeneratorReturnValue() {
            return generatorReturnValue;
        }
    }
}