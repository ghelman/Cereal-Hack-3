//
//  MyQViewController.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppData.h"

@interface MyQViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    AppData *dataQuery;
	NSMutableDictionary *viewCells;

    UITableView *queueTable;
}

@property (nonatomic, retain) AppData *dataQuery;
@property (nonatomic, retain) NSMutableDictionary *viewCells;

@property (nonatomic, retain) IBOutlet UITableView *queueTable;

@end
