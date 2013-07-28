//
//  Login.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Login : NSObject {
    int userid;
    NSString *facebookid;
    NSString *first_name;
    NSString *last_name;
    NSString *email;
    NSString *gender;
    NSDate *birthday;
    
    int zipCode;
    CLLocation *location;
    BOOL useLocation;
    
    BOOL loggedIn;
}

@property (nonatomic) int userid;
@property (nonatomic, retain) NSString *facebookid;
@property (nonatomic, retain) NSString *first_name;
@property (nonatomic, retain) NSString *last_name;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSDate *birthday;

@property (nonatomic) int zipCode;
@property (nonatomic, retain) CLLocation *location;
@property (nonatomic) BOOL useLocation;

@property (nonatomic) BOOL loggedIn;

-(id)initWithResume;
-(void)save;

-(NSString *)getBirthdateString;

@end
