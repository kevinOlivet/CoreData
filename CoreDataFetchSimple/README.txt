CoreDataFetchSimple

This project implements a simple CoreData stack using a NSFetchedResultsController.
It has a single Entity with a few properties which are presented in a tableView without sections. The entries are sorted by name ascending.
It allows for adding, deleting and updating CoreData entries.
Because the list is sorted it doesn't implement rearranging.

I like the clean implementation of the CoreDataManager with it's static functions as the stack.
It's simplicity will allow it to be used for future projects that require persistence without complication.