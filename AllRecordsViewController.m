//
//  AllRecordsViewController.m
//  CoreDataPOC
//
//  Created by Hari Priyanka on 02/07/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "AllRecordsViewController.h"

@interface AllRecordsViewController ()

@end

@implementation AllRecordsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Fetch the records from persistent data store
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"PocEntity"];
    self.fetchedRecordArray = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.recordsTableView reloadData];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedRecordArray count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"RecordCell";
    
    RecordsCell *cell = (RecordsCell *) [tableView
                                               dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *obj = [[NSBundle mainBundle]loadNibNamed:@"RecordsCell" owner:self options:nil];
        for (id objects in obj)
        {
            if ([objects isKindOfClass:[RecordsCell class]])
            {
                cell = (RecordsCell *)objects;
            }
        }
    }
    // Configure the cell...
    
    NSManagedObject *detailRecord = [self.fetchedRecordArray objectAtIndex:indexPath.row];

    cell.nameRecord.text = [detailRecord valueForKey:@"nameStr"];
    cell.phoneRecord.text = [detailRecord valueForKey:@"phoneStr"];
    cell.emailRecord.text = [detailRecord valueForKey:@"emailStr"];
    cell.idNumber.text = [detailRecord valueForKey:@"idStr"];

    return cell;
}
/*
 Allows user to delete the row from the database, tableview and internal array defined by swiping the row.
 */
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    //Checks to see if the gesture was a delete gesture
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [context deleteObject:[self.fetchedRecordArray objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error])
        {
            NSLog(@"Can't delete %@ %@", error, [error localizedDescription]);
            return;
        }
        //Removes the row
        [self.fetchedRecordArray removeObjectAtIndex:indexPath.row];
        [self.recordsTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Deleted" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)deleteBtnAction:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext]; // your managed object context
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PocEntity"];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if (objects == nil) {
        // handle error
        NSLog(@"Can't delete ");
    }
    else
    {
        for (NSManagedObject *object in objects) {
            [context deleteObject:object];
        }
        [context save:&error];
    }
    [self.recordsTableView reloadData];
    
}
@end
