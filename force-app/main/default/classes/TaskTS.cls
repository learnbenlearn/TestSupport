@isTest
public class TaskTS extends TestSupport.DataGeneration  {
    public TaskTS(Map<String, Object> options) {
        super(options, Schema.SObjectType.Task.getKeyPrefix());
    }

    public override List<sObject> generate() {
        List<Task> testTasks = new List<Task>();
        for(Integer i = 0; i < this.numberToGenerate; i++) {
            testTasks.add(new Task(
                Id = this.insertRecords ? null : this.generateRecordId(),
                Status = Math.mod(i, 2) == 0 ? 'Not Started' : 'Completed'
            ));
        }

        if(this.insertRecords) insert testTasks;
        this.records = new Map<Id, sObject>(testTasks);
        return testTasks;
    }
}