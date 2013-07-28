//
//  FQControls.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "FQControls.h"
#import "FQAppDelegate.h"
#import "AppData.h"

@implementation FQControls
@synthesize user;
@synthesize queue;

-(id) init {
	//get past data
	//self = [self initWithResume];
	//NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	//overwrite data with game defaults
    self.user = [[[Login alloc] init] autorelease];
    
    //get queue
    self.queue = [[[NSMutableArray alloc] init] autorelease];
        
    return self;
}

-(id)initWithResume {
	self = [self init];
    
    //load user
    self.user = [[Login alloc] initWithResume];
    
    return self;
}

+(id)currentControls {
	FQAppDelegate *appDelegate = (FQAppDelegate *)[[UIApplication sharedApplication] delegate];
	if(appDelegate.controls != nil)
        return appDelegate.controls;
    
    return [[FQControls alloc] initWithResume];
}

-(void)save {
	
	//save values to prefs
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    //save user
    if(self.user != nil)
        [self.user save];
    else {
        [prefs setObject:@"0" forKey:@"userid"];
        [prefs synchronize];
    }
}

-(BOOL)loggedIn {
    if(self.user != nil && self.user.loggedIn)
        return YES;
    return NO;
}

-(void)logOut {
    //if not logged in, leave
    if(![self loggedIn])
        return;
    
    self.user = nil;
    [self save];
}

-(NSString*)userName {
    if(self.user != nil && self.user.first_name > 0)
        return self.user.first_name;
    
    return @"";
}

@end
