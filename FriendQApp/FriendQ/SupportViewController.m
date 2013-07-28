//
//  SupportViewController.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "SupportViewController.h"

@interface SupportViewController ()

@end

@implementation SupportViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = BACKGROUND_COLOR;
    }
    return self;
}

-(void)setupForSupportType:(int)type {
    NSString *fileName = @"";
    switch (type) {
        case SUPPORT_SUPPORT:
            fileName = @"Support";
            self.title = @"Support";
            break;
        case SUPPORT_FEEDBACK:
            fileName = @"Feedback";
            self.title = @"Feedback";
            break;
        case SUPPORT_TERMS:
            fileName = @"Terms";
            self.title = @"Terms & Conditions";
            break;
        case SUPPORT_PRIVACY:
            fileName = @"Privacy";
            self.title = @"Privacy Policy";
            break;
    }
    
    //load HTML
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString* html = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:@"html"]
                                               encoding:NSUTF8StringEncoding
                                                  error:nil];
    
    [self.webView loadHTMLString:html baseURL:baseURL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
