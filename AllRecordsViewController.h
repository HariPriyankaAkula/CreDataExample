//
//  AllRecordsViewController.h
//  CoreDataPOC
//
//  Created by Hari Priyanka on 02/07/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordsCell.h"
@interface AllRecordsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *recordsTableView;

- (IBAction)deleteBtnAction:(id)sender;
@property(strong)NSMutableArray *fetchedRecordArray;
@end
