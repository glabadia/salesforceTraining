trigger OrderEventTrigger on Order_Event__e (after insert) {
  List<Task> tasksList = new List<Task>();

  // Schema.SObjectType.Contact.fields.SSN__c.isAccessible()
  for (Order_Event__e order : Trigger.new) {
    if (order.Has_Shipped__c) {
      Task newTask = new Task();
      newTask.Priority = 'Medium';
      newTask.Subject = 'Follow up on shipped order ' + order.Order_Number__c;
      newTask.OwnerId = order.CreatedById;
      tasksList.add(newTask);
    }
  }

  insert tasksList;
}