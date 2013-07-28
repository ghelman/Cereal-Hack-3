//
//  Recommendation.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recommendation : NSObject {
    int rID;
    int recepientid;
    int statusid;
    NSString *status;
    int media_typeid;
    NSString *media_type;
    
    NSString *title;
    NSString *desc;
    NSString *url;
    NSString *user_name;
    NSString *sender_name;
    NSString *user_pic;
    NSString *sender_pic;
}

@property (nonatomic) int rID;
@property (nonatomic) int statusid;
@property (nonatomic) int recepientid;
@property (nonatomic,retain) NSString *status;
@property (nonatomic) int media_typeid;
@property (nonatomic,retain) NSString *media_type;

@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *desc;
@property (nonatomic,retain) NSString *url;
@property (nonatomic,retain) NSString *user_name;
@property (nonatomic,retain) NSString *sender_name;
@property (nonatomic,retain) NSString *user_pic;
@property (nonatomic,retain) NSString *sender_pic;

@end
