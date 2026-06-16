@IsTest
public class TSDataGenerationConfig {
    public enum GeneratorReturnValue {NEW_RECORDS, ALL_RECORDS}

    public final Boolean generateMasterRecords {public get; set;}
    public final Boolean generateRecordIDs {public get; set;}
    public final Boolean useFieldDefaults {public get; set;}
    public final Integer numberToGenerate {public get; set;}
    public final GeneratorReturnValue generatorReturnValue {public get; set;}

    public TSDataGenerationConfig(TSDataGenerationConfigBuilder builder) {
        this.generateMasterRecords = builder.getGenerateMasterRecords();
        this.generateRecordIDs = builder.getGenerateRecordIDs();
        this.useFieldDefaults = builder.getUseFieldDefaults();
        this.numberToGenerate = builder.getNumberToGenerate();
        this.generatorReturnValue = builder.getGeneratorReturnValue();
    }

    public static TSDataGenerationConfigBuilder builder() {
        return new TSDataGenerationConfigBuilder();
    }

    public static TSDataGenerationConfig fromMap(Map<String, Object> options) {
        if(options == null) {
            return builder().build();
        }

        TSDataGenerationConfigBuilder builder = new TSDataGenerationConfigBuilder();
        if(options.containsKey('generateMasterRecords')) {
            builder.setGenerateMasterRecords(Boolean.valueOf(options.get('generateMasterRecords')));
        }
        if(options.containsKey('generateRecordIDs')) {
            builder.setGenerateRecordIDs(Boolean.valueOf(options.get('generateRecordIDs')));
        }
        if(options.containsKey('useFieldDefaults')) {
            builder.setUseFieldDefaults(Boolean.valueOf(options.get('useFieldDefaults')));
        }
        if(options.containsKey('numberToGenerate')) {
            builder.setNumberToGenerate(Integer.valueOf(options.get('numberToGenerate')));
        }
        if(options.containsKey('generatorReturnValue')) {
            builder.setGeneratorReturnValue(getGeneratorReturnValue(String.valueOf(options.get('generatorReturnValue'))));
        }
        return builder.build();
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

        public TSDataGenerationConfigBuilder() {
            this.generatorReturnValue = TSDataGenerationConfig.GeneratorReturnValue.NEW_RECORDS;
        }

        public TSDataGenerationConfigBuilder setGenerateMasterRecords(Boolean generateMasterRecords) {
            this.generateMasterRecords = generateMasterRecords == null ? false : generateMasterRecords;
            return this;
        }

        public TSDataGenerationConfigBuilder setGenerateRecordIDs(Boolean generateRecordIDs) {
            this.generateRecordIDs = generateRecordIDs == null ? true : generateRecordIDs;
            return this;
        }

        public TSDataGenerationConfigBuilder setUseFieldDefaults(Boolean useFieldDefaults) {
            this.useFieldDefaults = useFieldDefaults == null ? true : useFieldDefaults;
            return this;
        }

        public TSDataGenerationConfigBuilder setNumberToGenerate(Integer numberToGenerate) {
            this.numberToGenerate = numberToGenerate == null ? 200 : numberToGenerate;
            return this;
        }

        public TSDataGenerationConfigBuilder setGeneratorReturnValue(TSDataGenerationConfig.GeneratorReturnValue generatorReturnValue) {
            this.generatorReturnValue = generatorReturnValue;
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