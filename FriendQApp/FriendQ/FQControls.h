//
//  FQControls.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Login.h"

@interface FQControls : NSObject {
    // Account variables
    Login *user;
    
    NSMutableArray *queue;
}

@property(nonatomic, retain) Login *user;

@property(nonatomic, retain) NSMutableArray *queue;

-(id)init;
-(id)initWithResume;
+(id)currentControls;
-(void)save;

-(BOOL)loggedIn;
-(void)logOut;
-(NSString*)userName;

@end
