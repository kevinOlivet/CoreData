CoreDataSimpleSections

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

I like the clean implementation of the CoreDataManager with it's static functions as the stack.
It's simplicity will allow it to be used for future projects that require persistence without complication.