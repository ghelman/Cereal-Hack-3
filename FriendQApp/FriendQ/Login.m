//
//  Login.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "Login.h"

@implementation Login
@synthesize userid, facebookid, first_name, last_name, email, gender, birthday, loggedIn;
@synthesize zipCode, location, useLocation;

-(id)init {
    self = [super init];
    return self;
}

-(id)initWithResume {
    self = [self init];
    if(self) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        //load date details
        self.userid = [[prefs objectForKey:@"userid"] intValue];
        if(self.userid <= 0)
            return nil;
        
        self.facebookid = [prefs objectForKey:@"facebookid"];
        self.first_name = [prefs objectForKey:@"first_name"];
        self.last_name = [prefs objectForKey:@"last_name"];
        self.email = [prefs objectForKey:@"email"];
        self.gender = [prefs objectForKey:@"gender"];
        self.birthday = [prefs objectForKey:@"birthday"];
        self.loggedIn = (self.userid > 0) ? YES : NO;
        
    }
    return self;
}

-(void)save {
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	[prefs setObject:[NSString stringWithFormat:@"%i", self.userid] forKey:@"userid"];
	[prefs setObject:self.facebookid forKey:@"facebookid"];
	[prefs setObject:self.first_name forKey:@"first_name"];
	[prefs setObject:self.last_name forKey:@"last_name"];
	[prefs setObject:self.email forKey:@"email"];
	[prefs setObject:self.gender forKey:@"gender"];
	[prefs setObject:self.birthday forKey:@"birthday"];
    
	[prefs synchronize];
}


-(NSString *)getBirthdateString {
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"M/dd/yyyy"];
	
	return [dateFormatter stringFromDate:self.birthday];
}

@end
