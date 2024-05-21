@isTest
public class RecommendedBadgeTS extends TestSupport.DataGeneration  {
    public final List<trailheadapp__Badge__c> BADGES;
    public final List<Mix_Category__c> MIX_CATEGORIES;

    public RecommendedBadgeTS(Map<String, Object> options, List<trailheadapp__Badge__c> badges, List<Mix_Category__c> mixCategories) {
        super(options, Schema.SObjectType.Recommended_Badge__c.getKeyPrefix());
        this.BADGES = badges;
        this.MIX_CATEGORIES = mixCategories;
    }

    public override List<sObject> generate() {
        List<Recommended_Badge__c> testRecommendedBadges = new List<Recommended_Badge__c>();

        for(Integer i = 0; i < this.numberToGenerate; i++) {
            testRecommendedBadges.add(new Recommended_Badge__c(
                Id = this.insertRecords ? null : this.generateRecordId(),
                Mix_Category__c = MIX_CATEGORIES[Integer.valueOf(Math.floor(Math.mod(i, MIX_CATEGORIES.size())))].Id,
                High_Priority__c = Math.mod(i, 10) == 0 ? true : null
            ));
        }

        if(this.insertRecords) {
            Database.DMLOptions dmlOptions = new Database.DMLOptions();
            dmlOptions.DuplicateRuleHeader.allowSave = this.bypassDuplicateRules;
            Database.insert(testRecommendedBadges, dmlOptions);
        }
        this.records = new Map<Id, sObject>(testRecommendedBadges);
        return testRecommendedBadges;
    }
}
