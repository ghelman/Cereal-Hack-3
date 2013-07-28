//
//  Recommendation.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "Recommendation.h"

@implementation Recommendation 
@synthesize rID, status, recepientid, statusid, media_type, media_typeid, title, desc, url;
@synthesize user_name, user_pic, sender_name, sender_pic;


-(void)dealloc {
    if(status != nil)
        [status release];
    if(media_type != nil)
        [media_type release];
    if(title != nil)
        [title release];
    if(desc != nil)
        [desc release];
    if(user_name != nil)
        [user_name release];
    if(user_pic != nil)
        [user_pic release];
    if(sender_pic != nil)
        [sender_pic release];
    if(sender_name != nil)
        [sender_name release];
    [super dealloc];
}

@end
