// @@Example: ex_objc_intro @@
#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "people.h"

/*
 The classes People, PeopleQuery, PeopleView, and PeopleRow are declared
 (interfaces are generated) in people.h as

 REALM_TABLE_DEF_3(People,
                   Name,  String,
                   Age,   Int,
                   Hired, Bool)

 and in people.m you must have

 REALM_TABLE_IMPL_3(People,
                    Name, String,
                    Age,  Int,
                    Hired, Bool)

 in order to generate the implementation of the classes.
*/

// Use it in a function
void ex_objc_intro() {
    // Create a realm and initialize with a table and rows
    RLMRealm *realm = [RLMRealm defaultRealmWithInitBlock:^(RLMRealm *realm) {
        if (realm.isEmpty) {
            // Create a table
            People *table = [realm createTableWithName:@"employees" asTableClass:[People class]];
            
            // Add rows
            [table addRow:@{@"Name": @"Mary", @"Age": @76, @"Hired": @NO}];
            [table addRow:@{@"Name": @"Lars", @"Age": @22, @"Hired": @YES}];
            [table addRow:@{@"Name": @"Phil", @"Age": @43, @"Hired": @NO}];
            [table addRow:@{@"Name": @"Anni", @"Age": @54, @"Hired": @YES}];
        }
    }];
    
    // Get the table
    People *table = [realm tableWithName:@"employees" asTableClass:[People class]];
    
    // Query the table
    PeopleQuery *query = [[table where].Age columnIsGreaterThan:30];
    PeopleView  *view  = [query findAll];
    
    // Iterate over all rows in view
    for (PeopleRow *row in view) {
        NSLog(@"Name: %@", row.Name);
    }
}
// @@EndExample@@
