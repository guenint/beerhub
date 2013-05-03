//
//  trgStylesViewController.h
//  beerhub
//
//  Created by Teddy Guenin on 5/3/13.
//  Copyright (c) 2013 Teddy Guenin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface trgStylesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSMutableArray *selectedIndexes;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
