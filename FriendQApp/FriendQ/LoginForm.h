//
//  LoginForm.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "Menu.h"
#import <UIKit/UIKit.h>

@interface LoginForm : Menu <UITextFieldDelegate> {
    UITextField *emailField;
    UITextField *passwordField;
}

@property (nonatomic, retain) UITextField *emailField;
@property (nonatomic, retain) UITextField *passwordField;

@end
