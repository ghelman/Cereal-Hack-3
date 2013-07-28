//
//  LoginMenu.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "LoginMenu.h"
#import "FQAppDelegate.h"
#import "FQViewController.h"

@implementation LoginMenu
@synthesize facebookButton, fqButton, isLogging;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"load menu");
        self.menuType = MENU_HOME;
        
        CGFloat yPos = 20.0f;
        CGFloat spacing = (IS_IPHONE_5) ? menuButtonSpacing_iPhone5 : menuButtonSpacing;
        
        // Create Title
        
        UIImageView *title = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friendQLogo.png"]] autorelease];
        title.frame = CGRectMake(0.0f, yPos, 320.0f, 118.0f);
        [self addSubview:title];
        yPos += menuLabelHeight;
        
        
        UIImageView *bottom = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Divider.png"]] autorelease];
        bottom.frame = CGRectMake(0.0f, 300.0f, 320.0f, 252.0f);
        [self addSubview:bottom];
        yPos += menuLabelHeight;
        
        //Create Buttons
        //yPos += 220.0f;
        
        FQControls *controls = [FQControls currentControls];
        if(![controls loggedIn]) {
            yPos = 220.0f;
            self.facebookButton = [self createMenuButtonWithImage:[UIImage imageNamed:@"fbLogin.png"] y:yPos action:@selector(facebookLogin:)];
            [self addSubview:self.facebookButton];
            //yPos += menuButtonHeight + spacing + spacing;
        
            yPos = 350.0f;
            self.fqButton = [self createMenuButtonWithImage:[UIImage imageNamed:@"friendqLogin.png"] y:yPos action:@selector(localLogin:)];
            [self addSubview:self.fqButton];
            yPos += menuButtonHeight + spacing;
            
            UIButton *createButton = [UIButton buttonWithType:UIButtonTypeCustom];
            createButton.frame = CGRectMake(menuButtonXPos, yPos, menuButtonWidth, menuButtonHeight);
            [createButton setTitle:@"New to FriendQ? Create Account" forState:UIControlStateNormal];
            [createButton addTarget:self action:@selector(createAccount:) forControlEvents:UIControlEventTouchUpInside];
            [createButton.titleLabel setFont:[UIFont fontWithName:@"Futura" size:16.0f]];
            createButton.titleLabel.textColor = [UIColor whiteColor];
            [self addSubview:createButton];
            yPos += menuButtonHeight + spacing;
        } else {
            //already logged in
            yPos = 160.0f;
            UILabel *subtitle = [[[UILabel alloc] initWithFrame:CGRectMake(menuLabelXPos, yPos, menuLabelWidth, menuLabelHeight)] autorelease];
            [subtitle setFont:[UIFont fontWithName:@"Futura" size:22.0f]];
            [subtitle setText:[NSString stringWithFormat:@"Welcome Back, %@", controls.user.first_name]];
            [subtitle setTextColor:menuSubtitleColor];
            [subtitle setBackgroundColor:[UIColor clearColor]];
            [subtitle setTextAlignment:NSTextAlignmentCenter];
            [subtitle setAdjustsFontSizeToFitWidth:YES];
            [self addSubview:subtitle];
            yPos += menuLabelHeight + spacing;
            
            yPos = 220.0f;
            UIButton *startButton = [self createMenuButtonWithText:@"Get Started" y:yPos color:BUTTON_COLOR_BLUE action:@selector(next:)];
            [self addSubview:startButton];
            //yPos += menuButtonHeight + spacing + spacing;
            
            yPos = 350.0f;
            UIButton *accountButton = [self createMenuButtonWithText:@"My Account" y:yPos color:BUTTON_COLOR_PINK action:@selector(viewAccount:)];
            [self addSubview:accountButton];
            //yPos += menuButtonHeight + spacing + spacing;
        }
        
        [self displayNavigation];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(IBAction)facebookLogin:(id)sender {
    if(isLogging) return;
    
    //show loading
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.facebookButton.frame.size.width/2 - 12.5, self.facebookButton.frame.size.height/2 - 12.5, 25.0, 25.0)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    activityIndicator.hidesWhenStopped = YES;
    
    [self.facebookButton setTitle:@"" forState:UIControlStateNormal];
    [self.facebookButton addSubview:activityIndicator];
    [activityIndicator startAnimating];
    [activityIndicator release];
    
    FQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    isLogging = YES;
    // If the person is authenticated, log out when the button is clicked.
    // If the person is not authenticated, log in when the button is clicked.
    if (FBSession.activeSession.isOpen) {
        [appDelegate closeSession];
    } else {
        // The person has initiated a login, so call the openSession method
        // and show the login UX if necessary.
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
}

-(IBAction)viewAccount:(id)sender {
    FQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	[(FQViewController*)appDelegate.viewController displayAccount];
}

-(IBAction)createAccount:(id)sender {
    FQAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	[(FQViewController*)appDelegate.viewController displayAccountForm];
}

@end
