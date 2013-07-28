//
//  DataSender.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "DataSender.h"

@implementation DataSender

+(BOOL)sendRecommendation:(Recommendation*)item {
    FQControls *controls = [FQControls currentControls];
    //create url string for submission
    NSString *urlString = [NSString stringWithFormat:@"http://friendq.alexrude.com/api/ios.php?type=recommendation&userid=%i&title=%@&url=%@&typeid=%i&desc=%@&targetid=%i", controls.user.userid, [item.title urlencode], [item.url urlencode], item.media_typeid, [item.desc urlencode], item.recepientid];
    NSLog(@"review url = %@", [urlString urlencode]);
    NSURL *url = [NSURL URLWithString:urlString];
    
    //submit review to server
    NSString *resultMsg = @"Test response";
    NSString *responseStr = @"";
    NSError *error = nil;
    BOOL hasError = NO;
    
    //send data and receive result
    resultMsg = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    //check for procedure error
    if(error) {
        NSLog(@"error: %@", [error localizedDescription]);
        resultMsg = [error localizedDescription];
        hasError = YES;
    }
    
    //check for error returned
    if([resultMsg length] >= 7) {
        responseStr = [resultMsg substringWithRange:NSMakeRange(0, 7)];
        if([responseStr isEqualToString:@"[ERROR]"]) {
            resultMsg = [resultMsg substringFromIndex:7];
            hasError = YES;
        }
    }
    
    //alert user of success
    if(hasError) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Push to Q" message:resultMsg
                                                    delegate:nil
                                           cancelButtonTitle:NSLocalizedString(@"Ok",nil)
                                           otherButtonTitles:nil] autorelease];
        alert.delegate = self;
        [alert show];
    }
    
    return !hasError;
}

+(int)sendUserRequest:(NSString*)request user:(Login*)user password:(NSString*)password {
    //create url string for submission
    NSString *urlString = [NSString stringWithFormat:@"http://friendq.alexrude.com/api/submit.php?type=%@&fname=%@&lname=%@&email=%@&birthday=%@&gender=%@&fid=%@&userid=%i", request, [user.first_name urlencode], [user.last_name urlencode], [user.email urlencode], [[user getBirthdateString] urlencode], [user.gender urlencode], [user.facebookid urlencode], user.userid];
    if([password length] > 0)
        urlString = [urlString stringByAppendingFormat:@"&password=%@", password];
    
    NSLog(@"review url = %@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
    //submit review to server
    NSString *resultMsg = @"Test response";
    NSString *responseStr = @"";
    NSError *error = nil;
    BOOL hasError = NO;
    
    //send data and receive result
    resultMsg = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    //check for procedure error
    if(error) {
        NSLog(@"error: %@", [error localizedDescription]);
        resultMsg = [error localizedDescription];
        hasError = YES;
    }
    
    //check for error returned
    int userid = 0;
    if([resultMsg length] >= 7) {
        responseStr = [resultMsg substringWithRange:NSMakeRange(0, 7)];
        if([responseStr isEqualToString:@"[ERROR]"]) {
            resultMsg = [resultMsg substringFromIndex:7];
            hasError = YES;
        } else if([responseStr isEqualToString:@"[FOUND]"]) {
            userid = [[resultMsg substringFromIndex:7] intValue];
        } else if([responseStr isEqualToString:@"[NWUSR]"]) {
            userid = [[resultMsg substringFromIndex:7] intValue];
        } else if([responseStr isEqualToString:@"[SAVED]"]) {
            userid = [[resultMsg substringFromIndex:7] intValue];
        }
    }
    
    //check for user returned
    if(!hasError && userid <= 0) {
        hasError = YES;
        responseStr = @"No User Account Found";
    } //no errors and user found, return userid
    else if(!hasError && userid > 0)
        return userid;
    
    //alert user of success
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"FriendQ Account" message:resultMsg
                                                    delegate:nil
                                           cancelButtonTitle:NSLocalizedString(@"Ok",nil)
                                           otherButtonTitles:nil] autorelease];
    alert.delegate = self;
    [alert show];
    
    return userid;
}

@end
