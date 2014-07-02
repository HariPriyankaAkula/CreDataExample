//
//  RecordsCell.h
//  CoreDataPOC
//
//  Created by Hari Priyanka on 02/07/14.
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *idNumber;
@property (strong, nonatomic) IBOutlet UILabel *nameRecord;
@property (strong, nonatomic) IBOutlet UILabel *emailRecord;
@property (strong, nonatomic) IBOutlet UILabel *phoneRecord;

@end
