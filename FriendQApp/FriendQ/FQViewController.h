//
//  FQViewController.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Menu.h"
#import "HomeViewController.h"
#import "MainMenu.h"

@interface FQViewController : UIViewController {
    int curMenu;
    HomeViewController *loginMenu;
    MainMenu *mainMenu;
}

@property (nonatomic) int curMenu;
@property (nonatomic, retain) HomeViewController *loginMenu;
@property (nonatomic, retain) MainMenu *mainMenu;

- (Menu*)createMenu:(int)menuType forceNew:(BOOL)forceNew;

-(void)previousMenu;
-(void)nextMenu;
-(void)reloadMenu;

- (void)setupNavBar;

-(void)displayAccount;
-(void)displayAccountForm;

-(void)viewMyQ;
-(void)viewSendQ;

-(void)closeModal;

@end
