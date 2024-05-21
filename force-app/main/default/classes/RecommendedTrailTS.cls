@isTest
public class RecommendedTrailTS extends TestSupport.DataGeneration  {
    public final List<trailheadapp__Trail__c> TRAILS;
    public final List<Mix_Category__c> MIX_CATEGORIES;

    public RecommendedTrailTS(Map<String, Object> options, List<trailheadapp__Trail__c> trails, List<Mix_Category__c> mixCategories) {
        super(options, Schema.SObjectType.Recommended_Trail__c.getKeyPrefix());
        this.TRAILS = trails;
        this.MIX_CATEGORIES = mixCategories;
    }

    public override List<sObject> generate() {
        List<Recommended_Trail__c> testRecommendedTrails = new List<Recommended_Trail__c>();
        for(Integer i = 0; i < this.numberToGenerate; i++) {
            testRecommendedTrails.add(new Recommended_Trail__c(
                Id = this.insertRecords ? null : this.generateRecordId(),
                Mix_Category__c = MIX_CATEGORIES[Integer.valueOf(Math.floor(MIX_CATEGORIES.size()/10))].Id,
                Trail__c = TRAILS[i].Id
            ));
        }

        if(this.insertRecords) {
            Database.DMLOptions dmlOptions = new Database.DMLOptions();
            dmlOptions.DuplicateRuleHeader.allowSave = this.bypassDuplicateRules;
            Database.insert(testRecommendedTrails, dmlOptions);
        }
        this.records = new Map<Id, sObject>(testRecommendedTrails);
        return testRecommendedTrails;
    }
}
