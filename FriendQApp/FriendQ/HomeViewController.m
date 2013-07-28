//
//  HomeViewController.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize menu;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = BACKGROUND_COLOR;
        UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:(IS_IPHONE_5)?@"Background-568h@2x.png":@"Background.png"]];
        background.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        //background.contentMode = UIViewContentModeBottom;
        [self.view addSubview:background];
        [background release];
        
        // Add Login Menu
        self.menu = [[[LoginMenu alloc] initWithFrame:menu_default_frame] autorelease];
        [self.view addSubview:self.menu];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)reload {
    if(self.menu != nil) {
        [self.menu removeFromSuperview];
        self.menu = nil;
    }
    self.menu = [[[LoginMenu alloc] initWithFrame:menu_default_frame] autorelease];
    [self.view addSubview:self.menu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
