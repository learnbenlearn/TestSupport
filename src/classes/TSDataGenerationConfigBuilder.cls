/**
 * Fluent builder for `TSDataGenerationConfig`. If not overridden, the following defaults will be used
 * `generateMasterRecords` => `false`
 * `generateRecordIDs` => `true`
 * `generatorReturnValue` => `TSGeneratorReturnValue.NEW_RECORDS`
 * `numberToGenerate` => `200`
 * `useFieldDefaults` => `true`
 * @author Ben Learn
 * @since 06-24-2026
 * @group Config
 */
@IsTest
public class TSDataGenerationConfigBuilder {
    private Boolean generateMasterRecords = false;
    private Boolean generateRecordIDs = true;
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
     * Shorthand fluent method to set numberToGenerate to 1
     * @return  `TSDataGenerationConfigBuilder`
     */
    public TSDataGenerationConfigBuilder singleRecord() {
        return this.setNumberToGenerate(1);
    }

    /**
     * Shorthand fluent method to set numberToGenerate to 200
     * @return  `TSDataGenerationConfigBuilder`
     */
    public TSDataGenerationConfigBuilder bulkRecords() {
        return this.setNumberToGenerate(200);
    }

    /**
     * Shorthand fluent method to set generateRecordIDs to false
     * @return  `TSDataGenerationConfigBuilder`
     */
    public TSDataGenerationConfigBuilder noRecordIDs() {
        return this.setGenerateRecordIDs(false);
    }

    /**
     * Shorthand fluent method to set generatorReturnValue to `TSGeneratorReturnValue.ALL_RECORDS`
     * @return  `TSDataGenerationConfigBuilder`
     */
    public TSDataGenerationConfigBuilder allRecords() {
        return this.setGeneratorReturnValue(TSGeneratorReturnValue.ALL_RECORDS);
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