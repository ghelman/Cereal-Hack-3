//
//  FQAppDelegate.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FQControls.h"
#import <FacebookSDK/FacebookSDK.h>

@class FQViewController;

@interface FQAppDelegate : UIResponder <UIApplicationDelegate> {
    FQControls *controls;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FQViewController *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;

@property (nonatomic, retain) FQControls *controls;

extern NSString *const FBSessionStateChangedNotification;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
- (void) closeSession;

@end
