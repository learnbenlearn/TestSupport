@IsTest
public class TSDataGenerationConfig {
    public final Boolean generateMasterRecords {get; set;}
    public final Boolean generateMasterRecordsWasSet {get; set;}
    public final Boolean generateRecordIDs {get; set;}
    public final Boolean generateRecordIDsWasSet {get; set;}
    public final Boolean useFieldDefaults {get; set;}
    public final Boolean useFieldDefaultsWasSet {get; set;}
    public final Integer numberToGenerate {get; set;}
    public final Boolean numberToGenerateWasSet {get; set;}
    public final TSGeneratorMode generatorMode {get; set;}
    public final TSGeneratorReturnValue generatorReturnValue {get; set;}
    public final Boolean generatorReturnValueWasSet {get; set;}

    /**
     * constructor with builder instance
     * @param builder
     */
    public TSDataGenerationConfig(TSDataGenerationConfigBuilder builder) {
        this.generateMasterRecords = builder.getGenerateMasterRecords();
        this.generateMasterRecordsWasSet = builder.generateMasterRecordsWasSet;
        this.generateRecordIDs = builder.getGenerateRecordIDs();
        this.generateRecordIDsWasSet = builder.generateRecordIDsWasSet;
        this.generatorMode = builder.getGeneratorMode();
        this.generatorReturnValue = builder.getGeneratorReturnValue();
        this.generatorReturnValueWasSet = builder.generatorReturnValueWasSet;
        this.numberToGenerate = builder.getNumberToGenerate();
        this.numberToGenerateWasSet = builder.numberToGenerateWasSet;
        this.useFieldDefaults = builder.getUseFieldDefaults();
        this.useFieldDefaultsWasSet = builder.useFieldDefaultsWasSet;
    }

    /**
     * static method to get new builder instance
     * @return  `TSDataGenerationConfigBuilder`
     */
    public static TSDataGenerationConfigBuilder builder() {
        return new TSDataGenerationConfigBuilder();
    }
}