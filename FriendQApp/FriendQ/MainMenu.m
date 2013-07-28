//
//  MainMenu.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "MainMenu.h"
#import "FQAppDelegate.h"
#import "FQViewController.h"

@implementation MainMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"load menu");
        self.menuType = MENU_MAIN;
        
        CGFloat yPos = 20.0f;
        //CGFloat spacing = (IS_IPHONE_5) ? menuButtonSpacing_iPhone5 : menuButtonSpacing;
        
        // Create Title
        
        //UIImageView *title = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friendQLogo.png"]] autorelease];
        //title.frame = CGRectMake(0.0f, yPos, 320.0f, 118.0f);
        //[self addSubview:title];
        
        UIImageView *bottom = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Divider.png"]] autorelease];
        bottom.frame = CGRectMake(0.0f, 260.0f, 320.0f, 252.0f);
        [self addSubview:bottom];
        yPos += menuLabelHeight;
        
        yPos = 40.0f;
        UIButton *startButton = [self createMenuButtonWithImage:[UIImage imageNamed:@"SendQButton.png"] y:yPos action:@selector(viewSendQ:)];
        startButton.frame = CGRectMake(startButton.frame.origin.x, startButton.frame.origin.y, 270.0f, 171.0f);
        [self addSubview:startButton];
        //yPos += menuButtonHeight + spacing + spacing;
        
        yPos = 300.0f;
        UIButton *accountButton = [self createMenuButtonWithImage:[UIImage imageNamed:@"MyQButton.png"]  y:yPos action:@selector(viewMyQ:)];
        accountButton.frame = CGRectMake(accountButton.frame.origin.x, accountButton.frame.origin.y, 270.0f, 171.0f);
        [self addSubview:accountButton];
        //yPos += menuButtonHeight + spacing + spacing;
    }
    return self;
}


-(IBAction)viewMyQ:(id)sender {
    FQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	[(FQViewController*)appDelegate.viewController viewMyQ];
}

-(IBAction)viewSendQ:(id)sender {
    FQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	[(FQViewController*)appDelegate.viewController viewSendQ];}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
