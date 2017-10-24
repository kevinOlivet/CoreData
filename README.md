# CoreData
A collection of CoreData projects with elements for easy reuse.

This folder includes various projects intended to be used as a reference for future projects.

#CoreDataClosure

This version uses a slightly more centralized method of fetching the CoreData.
The fetch method is in the CoreDataManager class and passes the results where needed in a closure.

It also implements an alert to confirm when an entry is deleted which would be useful in the future.

Further if has a nice pattern for choosing a picture and saving it to CoreData in the didFinishPickingMedia completion block.

The input for the name and address fields of the Person entity are gathered from an alert with textfields.
The text fields must not be empty or it won't save.
Otherwise the error isn't handled.

#CoreDataFetchSections

This project implements a simple CoreData stack using an NSFetchedResultsController.
It has a two Entities: Person and Address with one attribute each though more attributes could be added.
Person is linked to Address with a one-to-many relationship with an inverse.
The entities are presented in a tableView with sections corresponding to Person.name.
All entries are sorted by name ascending.

It allows for adding or deleting a Person or address, adding or deleting an Address to Person, updating Person or Address.
Because the list is sorted it doesn't implement rearranging.
To add a Person tap the + button in the upper right.
To edit a Person and/or Address tap the cell you want to update.
To add an Address to a Person tap the headerView with the Person's name.

The headerView has a green plus button to help make it more obvious as tapping a section isn't usual behavior.
The navigation is added through a tapGesture recognizer added to the headerView.
I subclassed UITapGestureRecognizer to be able to pass the section to the handleTap function.

Unlike the other iterations of this project, I opted to fetch Address instead of Person.
Dealing with a many-one relationship is a little simpler than a one-many.

I was having trouble with the FetchedResultsController noticing and applying the changes throughout the tableview when Person was changed through Address.
The key is CoreDataManager.context.refreshAllObjects() to force it to update.

I like the clean implementation of the CoreDataManager with it's static functions as the stack.
It's simplicity will allow it to be used for future projects that require persistence without complication.

#CoreDataFetchSimple

This project implements a simple CoreData stack using a NSFetchedResultsController.
It has a single Entity with a few properties which are presented in a tableView without sections. The entries are sorted by name ascending.
It allows for adding, deleting and updating CoreData entries.
Because the list is sorted it doesn't implement rearranging.

I like the clean implementation of the CoreDataManager with it's static functions as the stack.
It's simplicity will allow it to be used for future projects that require persistence without complication.

#CoreDataSimple

This project implements a simple CoreData stack without a NSFetchedResultsController.
It has a single Entity with a few properties which are presented in a tableView without sections. The entries are sorted by name ascending.
It allows for adding, deleting and updating CoreData entries.
Because the list is sorted it doesn't implement rearranging.

I like the clean implementation of the CoreDataManager with it's static functions as the stack.
It's simplicity will allow it to be used for future projects that require persistence without complication.

#CoreDataSimpleSections

This project implements a simple CoreData stack without a NSFetchedResultsController.
It has a two Entities: Person and Address with one attribute each though more attributes could be added.
Person is linked to Address with a one-to-many relationship with an inverse.
The entities are presented in a tableView with sections corresponding to Person.
All entries are sorted by name ascending.

It allows for adding or deleting a Person, adding or deleting an Address to Person, updating Person or Address.
Because the list is sorted it doesn't implement rearranging.
To add a Person tap the + button in the upper right.
To edit a Person and/or Address tap the cell you want to update.
To add an Address to a Person tap the headerView with the Person's name

The headerView has a green plus button to help make it more obvious as tapping a section isn't usual behavior.
The navigation is added through a tapGesture recognizer added to the headerView.
I subclassed UITapGestureRecognizer to be able to pass the section to the handleTap function.

I like the clean implementation of the CoreDataManager with it's static functions as the stack.
It's simplicity will allow it to be used for future projects that require persistence without complication.
