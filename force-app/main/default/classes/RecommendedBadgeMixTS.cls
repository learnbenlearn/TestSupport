@isTest
public class RecommendedBadgeMixTS extends TestSupport.DataGeneration  {
    public Boolean includeDefaultMix;

    public RecommendedBadgeMixTS(Map<String, Object> options) {
        super(options, Schema.SObjectType.Recommended_Badge_Mix__c.getKeyPrefix());
        this.includeDefaultMix = options.get('includeDefaultMix') == null ? false : Boolean.valueOf(options.get('includeDefaultMix'));
    }

    public override List<sObject> generate() {
        List<Recommended_Badge_Mix__c> testRecommendedBadgeMixes = new List<Recommended_Badge_Mix__c>();
        Boolean privateMix = false;

        for(Integer i = 0; i < this.numberToGenerate; i++) {
            if(i == 0 && this.includeDefaultMix) {        
                testRecommendedBadgeMixes.add(new Recommended_Badge_Mix__c(
                    Id = this.insertRecords ? null : this.generateRecordId(),
                    Name = 'Test Mix ' + i,
                    Private_Mix__c = privateMix,
                    Default_Badge_Mix__c = true
                ));
            } else {
                testRecommendedBadgeMixes.add(new Recommended_Badge_Mix__c(
                    Id = this.insertRecords ? null : this.generateRecordId(),
                    Name = 'Test Mix ' + i,
                    Private_Mix__c = privateMix
                ));
            }
            privateMix = !privateMix;
        }

        if(this.insertRecords) {
            Database.DMLOptions dmlOptions = new Database.DMLOptions();
            dmlOptions.DuplicateRuleHeader.allowSave = this.bypassDuplicateRules;
            Database.insert(testRecommendedBadgeMixes, dmlOptions);
        }
        this.records = new Map<Id, sObject>(testRecommendedBadgeMixes);
        return this.returnCreatedRecords ? testRecommendedBadgeMixes : null;
    }
}
