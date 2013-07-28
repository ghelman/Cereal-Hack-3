//
//  Menu.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "Menu.h"
#import "FQAppDelegate.h"
#import "FQViewController.h"

@implementation Menu
@synthesize menuType;

-(id)initDefault {
    self = [self initWithFrame:menu_default_frame];
    return self;
}

-(id)initOffset {
    self = [self initWithFrame:menu_offset_frame];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


-(UILabel*)createTitleLabelWithText:(NSString*)text {
    CGFloat yPos = (IS_IPHONE_5) ? menuButtonYPos_iPhone5 : menuButtonYPos;
    
    UILabel *title = [[[UILabel alloc] initWithFrame:CGRectMake(menuLabelXPos, yPos, menuLabelWidth, menuLabelHeight)] autorelease];
    [title setFont:[UIFont fontWithName:@"Futura" size:32.0f]];
    [title setText:text];
    [title setTextColor:menuTitleColor];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setAdjustsFontSizeToFitWidth:YES];
    
    return title;
}

-(UILabel*)createSubtitleLabelWithText:(NSString*)text {
    CGFloat yPos = (IS_IPHONE_5) ? menuButtonYPos_iPhone5 : menuButtonYPos;
    yPos += menuLabelHeight;
    
    UILabel *subtitle = [[[UILabel alloc] initWithFrame:CGRectMake(menuLabelXPos, yPos, menuLabelWidth, menuLabelHeight)] autorelease];
    [subtitle setFont:[UIFont fontWithName:@"Futura" size:22.0f]];
    [subtitle setText:text];
    [subtitle setTextColor:menuSubtitleColor];
    [subtitle setBackgroundColor:[UIColor clearColor]];
    [subtitle setTextAlignment:NSTextAlignmentCenter];
    [subtitle setAdjustsFontSizeToFitWidth:YES];
    
    return subtitle;
}

-(UIButton*)createMenuButtonWithText:(NSString*)text y:(CGFloat)yPos color:(int)color action:(SEL)action {
    // Create Button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(menuButtonXPos, yPos, menuButtonWidth, menuButtonHeight);
    [button setTitle:text forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:(color == BUTTON_COLOR_BLUE)?@"BlueButton270x45.png":@"PinkButton270x45.png"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button.titleLabel setFont:[UIFont fontWithName:@"Futura" size:21.0f]];

    return button;
}

-(UIButton*)createMenuButtonWithImage:(UIImage*)image y:(CGFloat)yPos action:(SEL)action {
    // Create Button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(menuButtonXPos, yPos, menuButtonWidth, menuButtonHeight);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

-(UILabel*)createFieldLabelWithText:(NSString*)text y:(CGFloat)yPos {
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(menuLabelXPos, yPos, menuFieldLabelWidth, menuFieldLabelHeight)] autorelease];
    [label setFont:[UIFont fontWithName:@"Futura" size:16.0f]];
    [label setText:text];
    [label setTextColor:menuSubtitleColor];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setAdjustsFontSizeToFitWidth:YES];
    
    return label;
}

-(UITextField*)createTextFieldWithValue:(NSString*)value y:(CGFloat)yPos {
    
    UITextField *field = [[[UITextField alloc] initWithFrame:CGRectMake(menuFieldXPos, yPos, menuFieldWidth, menuFieldHeight)] autorelease];
    field.text = value;
    field.borderStyle = UITextBorderStyleRoundedRect;
    field.clearButtonMode = UITextFieldViewModeAlways;
    field.font = [UIFont fontWithName:@"Futura" size:16.0f];
    field.textColor = [UIColor darkGrayColor];
    field.adjustsFontSizeToFitWidth = YES;
    field.spellCheckingType = UITextSpellCheckingTypeNo; // No spell checking!
    field.autocorrectionType = UITextAutocorrectionTypeNo;
    field.autocapitalizationType = UITextAutocapitalizationTypeWords;
    field.returnKeyType = UIReturnKeyNext;

    return field;
}

-(UITextField*)createNumberFieldWithValue:(NSString*)value y:(CGFloat)yPos {
    UITextField *field = [[[UITextField alloc] initWithFrame:CGRectMake(menuFieldXPos, yPos, 2.0f*menuFieldWidth/3.0f, menuFieldHeight)] autorelease];
    field.text = value;
    field.borderStyle = UITextBorderStyleRoundedRect;
    field.clearButtonMode = UITextFieldViewModeAlways;
    field.font = [UIFont fontWithName:@"Futura" size:16.0f];
    field.textColor = [UIColor darkGrayColor];
    field.adjustsFontSizeToFitWidth = YES;
    field.spellCheckingType = UITextSpellCheckingTypeNo; // No spell checking!
    field.autocorrectionType = UITextAutocorrectionTypeNo;
    field.autocapitalizationType = UITextAutocapitalizationTypeNone;
    field.keyboardType = UIKeyboardTypeNumberPad;
    field.returnKeyType = UIReturnKeyNext;
    
    return field;
}

-(UIButton*)createBackButton {
    // Create Button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(menuLeftNavXPos, self.frame.size.height - menuNavHeight, menuNavWidth, menuNavHeight);
    [button setTitle:@"< Back" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"PinkButton75x35.png"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [button.titleLabel setFont:[UIFont fontWithName:@"Futura" size:16.0f]];
    
    return button;
}

-(UIButton*)createNextButton {
    // Create Button
    NSString *title = (self.menuType == MENU_HOME) ? @"Skip" : @"Next >";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(menuRightNavXPos, self.frame.size.height - menuNavHeight, menuNavWidth, menuNavHeight);
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"BlueButton75x35.png"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [button.titleLabel setFont:[UIFont fontWithName:@"Futura" size:16.0f]];
    
    return button;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)displayNavigation {
    FQControls *controls = [FQControls currentControls];
    /*
    if(self.menuType > MENU_CHOOSE && self.menuType < MENU_COMPILING) {
        UIButton *back = [self createBackButton];
        [self addSubview:back];
    }
    
    if(self.menuType < MENU_DATE_END && self.menuType != MENU_COMPILING && !(self.menuType == MENU_HOME && [controls loggedIn])) {
        UIButton *next = [self createNextButton];
        [self addSubview:next];
    }
    
    if(self.menuType == MENU_COMPILING) {
        // Create Button
        NSString *title = @"Get Started!";
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(80.0f, self.frame.size.height - menuNavHeight, 160.0f, menuNavHeight);
        [button setTitle:title forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"BlueButton270x45.png"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont fontWithName:@"Futura" size:18.0f]];
        [self addSubview:button];
    }
    
    if(self.menuType == MENU_DATE_END) {
        // Create Button
        NSString *title = @"Finish";
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(80.0f, self.frame.size.height - menuNavHeight, 160.0f, menuNavHeight);
        [button setTitle:title forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"PinkButton270x45.png"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont fontWithName:@"Futura" size:18.0f]];
        [self addSubview:button];
    }
     */
}

-(IBAction)back:(id)sender {
	FQAppDelegate *appDelegate = (FQAppDelegate *)[[UIApplication sharedApplication] delegate];
	[(FQViewController*)appDelegate.viewController previousMenu];
}

-(IBAction)next:(id)sender {
	FQAppDelegate *appDelegate = (FQAppDelegate *)[[UIApplication sharedApplication] delegate];
	[(FQViewController*)appDelegate.viewController nextMenu];
}

-(IBAction)finish:(id)sender {
	FQAppDelegate *appDelegate = (FQAppDelegate *)[[UIApplication sharedApplication] delegate];
	[(FQViewController*)appDelegate.viewController finishDate];
}

@end
