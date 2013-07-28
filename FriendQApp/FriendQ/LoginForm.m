//
//  LoginForm.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "LoginForm.h"

@implementation LoginForm
@synthesize emailField, passwordField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGFloat yPos = (IS_IPHONE_5) ? menuButtonYPos_iPhone5 : menuButtonYPos;
        CGFloat spacing = (IS_IPHONE_5) ? menuButtonSpacing_iPhone5 : menuButtonSpacing;
        
        // Create Title
        
        UILabel *title = [self createTitleLabelWithText:@"Sign In"];
        [self addSubview:title];
        yPos += menuLabelHeight;
        
        //Create Form
        
        UILabel *emailLabel = [self createFieldLabelWithText:@"Email:" y:yPos];
        [self addSubview:emailLabel];
        
        self.emailField = [self createTextFieldWithValue:@"" y:yPos];
        self.emailField.delegate = self;
        self.emailField.tag = 1;
        [self addSubview:self.emailField];
        yPos += menuFieldLabelHeight + spacing;
        
        UILabel *passwordLabel = [self createFieldLabelWithText:@"Password:" y:yPos];
        [self addSubview:passwordLabel];
        
        self.passwordField = [self createTextFieldWithValue:@"" y:yPos];
        self.passwordField.delegate = self;
        self.passwordField.tag = 2;
        [self addSubview:self.passwordField];
        yPos += menuFieldLabelHeight + spacing;
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

@end
