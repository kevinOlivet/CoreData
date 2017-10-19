CoreDataClosure

This version uses a slightly more centralized method of fetching the CoreData.
The fetch method is in the CoreDataManager class and passes the results where needed in a closure.

It also implements an alert to confirm when an entry is deleted which would be useful in the future.

Further if has a nice pattern for choosing a picture and saving it to CoreData in the didFinishPickingMedia completion block.

The input for the name and address fields of the Person entity are gathered from an alert with textfields.
The text fields must not be empty or it won't save. 
Otherwise the error isn't handled.