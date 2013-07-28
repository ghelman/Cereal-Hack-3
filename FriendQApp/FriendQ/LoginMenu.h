//
//  LoginMenu.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "Menu.h"

@interface LoginMenu : Menu {
    UIButton *facebookButton;
    UIButton *fqButton;
    
    BOOL isLogging;
}

@property (nonatomic, retain) UIButton *facebookButton;
@property (nonatomic, retain) UIButton *fqButton;

@property (nonatomic) BOOL isLogging;

@end
