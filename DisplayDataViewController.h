//
//  DisplayDataViewController.h
//  CoreDataPOC
//
//  Created by Hari Priyanka on 02/07/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface DisplayDataViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *emailLbl;
@property (strong, nonatomic) IBOutlet UILabel *phoneLbl;
@property (strong, nonatomic) IBOutlet UILabel *idLbl;

@property(strong)NSMutableArray *fetchedRecordArray;
@end
