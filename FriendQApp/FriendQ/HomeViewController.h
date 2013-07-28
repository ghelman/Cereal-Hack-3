//
//  HomeViewController.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginMenu.h"

@interface HomeViewController : UIViewController {
    LoginMenu *menu;
}

@property (nonatomic, retain) LoginMenu *menu;

- (void)reload;

@end
