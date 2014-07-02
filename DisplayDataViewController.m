//
//  DisplayDataViewController.m
//  CoreDataPOC
//
//  Created by Hari Priyanka on 02/07/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "DisplayDataViewController.h"

@interface DisplayDataViewController ()

@end

@implementation DisplayDataViewController

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
}
- (void)viewDidLoad
{

    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"PocEntity"];
    
    NSError *error      = nil;
    NSArray *results    = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    if([results count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Data" message:@"Empty database" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        self.nameLbl.text  = @"";
        self.emailLbl.text = @"";
        self.phoneLbl.text = @"";
        self.idLbl.text = @"";
    }
    else
    {
        self.nameLbl.text  = [[results valueForKey:@"nameStr"] lastObject];
        self.emailLbl.text = [[results valueForKey:@"emailStr"] lastObject];
        self.phoneLbl.text = [[results valueForKey:@"phoneStr"] lastObject];
        self.idLbl.text = [[results valueForKey:@"idStr"] lastObject];
    }

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
