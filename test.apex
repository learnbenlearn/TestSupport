String jsonString = '[{"Name": "Test"}]';
Type accountType = Type.forName('List<Account>');
List<sObject> s = (List<sObject>) JSON.deserialize(jsonString, accountType);
System.debug(s instanceOf List<Account>);
