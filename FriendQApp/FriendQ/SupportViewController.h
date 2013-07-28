//
//  SupportViewController.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupportViewController : UIViewController <UIWebViewDelegate> {
    IBOutlet UIWebView *webView;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;

-(void)setupForSupportType:(int)type;

@end
