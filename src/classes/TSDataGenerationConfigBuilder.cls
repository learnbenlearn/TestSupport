/**
 * Fluent builder for `TSDataGenerationConfig`. If not overridden, the following defaults will be used
 * `generateMasterRecords` => `false`
 * `generateRecordIDs` => `true`
 * `generatorMode` => `null`
 * `generatorReturnValue` => `TSGeneratorReturnValue.NEW_RECORDS`
 * `numberToGenerate` => `200`
 * `useFieldDefaults` => `true`
 * @author Ben Learn
 * @since 06-24-2026
 * @group Config
 */
@IsTest
public class TSDataGenerationConfigBuilder {
    private static final Map<TSGeneratorMode, Integer> NUMBER_TO_GENERATE_BY_MODE = new Map<TSGeneratorMode, Integer>{
        TSGeneratorMode.SINGLE_RECORD => 1,
        TSGeneratorMode.BULK_RECORDS => 200
    };
    private Boolean generateMasterRecords = false;
    private Boolean generateRecordIDs = true;
    private TSGeneratorMode generatorMode;
    private TSGeneratorReturnValue generatorReturnValue = TSGeneratorReturnValue.NEW_RECORDS;
    private Integer numberToGenerate = 200;
    private Boolean useFieldDefaults = true;

    public Boolean generateMasterRecordsWasSet {
        get {
            if(this.generateMasterRecordsWasSet == null) {
                this.generateMasterRecordsWasSet = false;
            }
            return this.generateMasterRecordsWasSet;
        }
        private set;
    }
    public Boolean generateRecordIDsWasSet {
        get {
            if(this.generateRecordIDsWasSet == null) {
                this.generateRecordIDsWasSet = false;
            }
            return this.generateRecordIDsWasSet;
        }
        private set;
    }
    public Boolean useFieldDefaultsWasSet {
        get {
            if(this.useFieldDefaultsWasSet == null) {
                this.useFieldDefaultsWasSet = false;
            }
            return this.useFieldDefaultsWasSet;
        }
        private set;
    }
    public Boolean numberToGenerateWasSet {
        get {
            if(this.numberToGenerateWasSet == null) {
                this.numberToGenerateWasSet = false;
            }
            return this.numberToGenerateWasSet;
        }
        private set;
    }
    public Boolean generatorReturnValueWasSet {
        get {
            if(this.generatorReturnValueWasSet == null) {
                this.generatorReturnValueWasSet = false;
            }
            return this.generatorReturnValueWasSet;
        }
        private set;
    }

    /**
     * fluent setter for generateMasterRecords
     * @param generateMasterRecords
     * @return  `TSDataGenerationConfigBuilder`
     */
    public TSDataGenerationConfigBuilder setGenerateMasterRecords(Boolean generateMasterRecords) {
        this.generateMasterRecords = generateMasterRecords == null ? false : generateMasterRecords;
        this.generateMasterRecordsWasSet = true;
        return this;
    }

    /**
     * fluent setter for generateRecordIDs
     * @param generateRecordIDs
     * @return  `TSDataGenerationConfigBuilder`
     */
    public TSDataGenerationConfigBuilder setGenerateRecordIDs(Boolean generateRecordIDs) {
        this.generateRecordIDs = generateRecordIDs == null ? true : generateRecordIDs;
        this.generateRecordIDsWasSet = true;
        return this;
    }

    /**
     * fluent setter for generatorReturnValue
     * @param generatorReturnValue
     * @return  `TSDataGenerationConfigBuilder`
     */
    public TSDataGenerationConfigBuilder setGeneratorReturnValue(TSGeneratorReturnValue generatorReturnValue) {
        this.generatorReturnValue = generatorReturnValue;
        this.generatorReturnValueWasSet = true;
        return this;
    }

    /**
     * fluent setter for generatorMode
     * @param generatorMode
     * @return  `TSDataGenerationConfigBuilder`
     */
    public TSDataGenerationConfigBuilder setMode(TSGeneratorMode generatorMode) {
        this.generatorMode = generatorMode;
        this.numberToGenerate = NUMBER_TO_GENERATE_BY_MODE.get(generatorMode);
        return this;
    }

    /**
     * fluent setter for numberToGenerate
     * @param numberToGenerate
     * @return  `TSDataGenerationConfigBuilder`
     */
    public TSDataGenerationConfigBuilder setNumberToGenerate(Integer numberToGenerate) {
        this.numberToGenerate = numberToGenerate == null ? 200 : numberToGenerate;
        this.numberToGenerateWasSet = true;
        return this;
    }

    /**
     * fluent setter for useFieldDefaults
     * @param useFieldDefaults
     * @return  `TSDataGenerationConfigBuilder`
     */
    public TSDataGenerationConfigBuilder setUseFieldDefaults(Boolean useFieldDefaults) {
        this.useFieldDefaults = useFieldDefaults == null ? true : useFieldDefaults;
        this.useFieldDefaultsWasSet = true;
        return this;
    }

    /**
     * builder method
     * @return  `TSDataGenerationConfig`
     */
    public TSDataGenerationConfig build() {
        return new TSDataGenerationConfig(this);
    }

    /**
     * getter for generateMasterRecords
     * @return  `Boolean`
     */
    public Boolean getGenerateMasterRecords() {
        return this.generateMasterRecords;
    }

    /**
     * getter for generateMasterRecords
     * @return  `Boolean`
     */
    public Boolean getGenerateRecordIDs() {
        return this.generateRecordIDs;
    }

    /**
     * getter for generatorMode
     * @return  `TSGeneratorMode`
     */
    public TSGeneratorMode getGeneratorMode() {
        return this.generatorMode;
    }

    /**
     * getter for generatorReturnValue
     * @return  `GeneratorReturnValue`
     */
    public TSGeneratorReturnValue getGeneratorReturnValue() {
        return this.generatorReturnValue;
    }

    /**
     * getter for numberToGenerate
     * @return  `Integer`
     */
    public Integer getNumberToGenerate() {
        return this.numberToGenerate;
    }

    /**
     * getter for useFieldDefaults
     * @return  `Boolean`
     */
    public Boolean getUseFieldDefaults() {
        return this.useFieldDefaults;
    }
}