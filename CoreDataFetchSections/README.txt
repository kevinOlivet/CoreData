CoreDataFetchSections

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