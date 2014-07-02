//
//  ViewController.m
//  CoreDataPOC
//
//  Created by Hari Priyanka on 02/07/14.
//  Copyright (c) 2014. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    UIApplication *myApp = [UIApplication sharedApplication];
    id delegate = myApp.delegate;
    if (([delegate performSelector:@selector(managedObjectContext)]) != nil) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.nameTxtFld)
    {
        [self.emailTxtFld becomeFirstResponder];
    }
    if(textField == self.emailTxtFld)
    {
        [self.phoneTxtFld becomeFirstResponder];
    }
    if(textField == self.phoneTxtFld)
    {
        [self.idTxtFld becomeFirstResponder];
    }
    if(textField == self.idTxtFld)
    {
        [self.idTxtFld resignFirstResponder];
        [self saveBtnAction:self];
    }

    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nameTxtFld resignFirstResponder];
    [self.emailTxtFld resignFirstResponder];
    [self.phoneTxtFld resignFirstResponder];
    [self.idTxtFld resignFirstResponder];
}
/*
 * Saving the records in Core Data
 */
- (IBAction)saveBtnAction:(id)sender {


    if ([self.nameTxtFld.text isEqualToString:@""] || [self.emailTxtFld.text isEqualToString:@""] || [self.phoneTxtFld.text isEqualToString:@""]||[self.idTxtFld.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Data" message:@"Enter all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSManagedObjectContext *context = [self managedObjectContext];
        //Updating the exiting ID
        if (self.detail)
        {
            [self.detail setValue:self.nameTxtFld.text forKey:@"nameStr"];
            [self.detail setValue:self.emailTxtFld.text forKey:@"emailStr"];
            [self.detail setValue:self.phoneTxtFld.text forKey:@"phoneStr"];
            [self.detail setValue:self.idTxtFld.text forKey:@"idStr"];
        
                NSError *error = nil;
                    // Save the object to persistent store
                if (![context save:&error])
                {
                    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                }
                else
                {
                    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Changes" message:@"Updated" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
        
        }
        else
        {
           
            // Creating new record
            NSManagedObject *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"PocEntity" inManagedObjectContext:self.managedObjectContext];
            [newEntry setValue:self.nameTxtFld.text forKey:@"nameStr"];
            [newEntry setValue:self.emailTxtFld.text forKey:@"emailStr"];
            [newEntry setValue:self.phoneTxtFld.text forKey:@"phoneStr"];
            [newEntry setValue:self.idTxtFld.text forKey:@"idStr"];
            NSError *error;
            // Save the object to persistent store
            if (![context save:&error])
            {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            }
            else
            {
                UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Details" message:@"Saved" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }
    }
    /* Empties the text fields */
    self.nameTxtFld.text = @"";
    self.emailTxtFld.text = @"";
    self.phoneTxtFld.text = @"";
    self.idTxtFld.text = @"";
}
/*
 * Displays the last stored value
 */
- (IBAction)searchBtnAction:(id)sender {
    DisplayDataViewController *displayVCObj = [[DisplayDataViewController alloc] initWithNibName:@"DisplayDataViewController" bundle:nil];
    [self.navigationController pushViewController:displayVCObj animated:YES];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem=backButton;

}

- (IBAction)displayAllBtnAction:(id)sender {
    
    AllRecordsViewController *allRecordsVCObj = [[AllRecordsViewController alloc] initWithNibName:@"AllRecordsViewController" bundle:nil];
    [self.navigationController pushViewController:allRecordsVCObj animated:YES];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=backButton;

}
@end
