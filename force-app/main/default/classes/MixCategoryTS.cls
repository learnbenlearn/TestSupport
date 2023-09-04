@isTest
public class MixCategoryTS extends TestSupport.DataGeneration  {
    public final List<Recommended_Badge_Mix__c> RECOMMENDED_BADGE_MIXES;

    public MixCategoryTS(Map<String, Object> options, List<Recommended_Badge_Mix__c> recommendedBadgeMixes) {
        super(options, Schema.SObjectType.Mix_Category__c.getKeyPrefix());
        this.RECOMMENDED_BADGE_MIXES = recommendedBadgeMixes;
    }

    public override List<sObject> generate() {
        List<Mix_Category__c> testMixCategories = new List<Mix_Category__c>();

        for(Integer i = 0; i < this.numberToGenerate; i++) {
            testMixCategories.add(new Mix_Category__c(
                Id = this.insertRecords ? null : this.generateRecordId(),
                Name = this.RECOMMENDED_BADGE_MIXES[Math.mod(i, RECOMMENDED_BADGE_MIXES.size())].Name + ' Category ' + i,
                Recommended_Badge_Mix__c = this.RECOMMENDED_BADGE_MIXES[Math.mod(i, RECOMMENDED_BADGE_MIXES.size())].Id
            ));
        }

        if(this.insertRecords) insert testMixCategories;
        this.records = new Map<Id, sObject>(testMixCategories);
        return this.returnCreatedRecords ? testMixCategories : null;
    }
}