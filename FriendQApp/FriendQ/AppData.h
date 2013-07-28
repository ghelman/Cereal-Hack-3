//
//  AppData.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppData : NSObject {
    NSString *nextURL;
	NSString *receivedData;
	NSMutableArray *results;
    
    int pageNumber;
    int pageCount;
    int totalResults;
    BOOL queryDone;
}

@property (nonatomic, retain) NSString *nextURL;
@property (nonatomic, retain) NSString *receivedData;
@property (nonatomic, retain) NSMutableArray *results;

@property (nonatomic) int pageNumber;
@property (nonatomic) int pageCount;
@property (nonatomic) int totalResults;
@property (nonatomic) BOOL queryDone;

-(void)queryWithUserID:(int)userid;

@end
