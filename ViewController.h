//
//  ViewController.h
//  CoreDataPOC
//
//  Created by Hari Priyanka on 02/07/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayDataViewController.h"
#import "AllRecordsViewController.h"
@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *nameTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *emailTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *phoneTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *idTxtFld;
- (IBAction)saveBtnAction:(id)sender;
@property (strong) NSManagedObject *detail;

- (IBAction)searchBtnAction:(id)sender;
- (IBAction)displayAllBtnAction:(id)sender;


@end
