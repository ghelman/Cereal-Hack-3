//
//  FQAppDelegate.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "FQAppDelegate.h"

#import "FQViewController.h"
#import <FacebookSDK/FBSessionTokenCachingStrategy.h>

NSString *const FBSessionStateChangedNotification = @"com.rudedev.friendq.Login:FBSessionStateChangedNotification";

@implementation FQAppDelegate
@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize controls;

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[FQViewController alloc] initWithNibName:@"FQViewController" bundle:nil] autorelease];
    
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:self.viewController] autorelease];
    self.window.rootViewController = self.navigationController;
    
    //self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
	// Set up the game controls
	self.controls = [[FQControls alloc] initWithResume];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


/*
 * Callback for session changes.
 */
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            if (!error) {
                // We have a valid session
                NSLog(@"User session found");
            }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:FBSessionStateChangedNotification
     object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if (FBSession.activeSession.isOpen) {
        [FBRequestConnection
         startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                           id<FBGraphUser> user,
                                           NSError *error) {
             if (!error) {
                 //get user details
                 NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
                 [dateFormatter setDateFormat:@"MM/dd/yyyy"];
                 
                 Login *login = [[Login alloc] init];
                 login.facebookid = [user objectForKey:@"id"];
                 login.first_name = user.first_name;
                 login.last_name = user.last_name;
                 login.email = [user objectForKey:@"email"];
                 login.gender = [user objectForKey:@"gender"];
                 login.birthday = [dateFormatter dateFromString:user.birthday];
                 
                 //int userid = [DataSender sendUserRequest:@"facebookuser" user:login password:@""];
                 int userid = 1;
                 if(userid > 0) {
                     //save login
                     login.userid = userid;
                     login.loggedIn = YES;
                     self.controls.user = login;
                     [self.controls save];
                     
                     if([self.navigationController.topViewController isKindOfClass:[FQViewController class]]) {
                         [(FQViewController*)self.navigationController.topViewController nextMenu];
                     }
                 }
             }
         }];
    }
    
}

/*
 * Opens a Facebook session and optionally shows the login UX.
 */
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            @"email",
                            nil];
    if (![FBSession defaultAppID]) {
        [FBSession setDefaultAppID:@"216570035168676"];
    }
    return [FBSession openActiveSessionWithReadPermissions:permissions
                                              allowLoginUI:allowLoginUI
                                         completionHandler:^(FBSession *session,
                                                             FBSessionState state,
                                                             NSError *error) {
                                             [self sessionStateChanged:session
                                                                 state:state
                                                                 error:error];
                                         }];
}

/*
 * If we have a valid session at the time of openURL call, we handle
 * Facebook transitions by passing the url argument to handleOpenURL
 */
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBSession.activeSession handleOpenURL:url];
}

- (void) closeSession {
    [FBSession.activeSession closeAndClearTokenInformation];
}

@end
