//
//  FQViewController.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "FQViewController.h"
#import "AccountsViewController.h"
#import "AccountFormViewController.h"
#import "MyQViewController.h"
#import "SendQViewController.h"

@interface FQViewController ()

@end

@implementation FQViewController
@synthesize curMenu, loginMenu, mainMenu;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:(IS_IPHONE_5)?@"Background-568h@2x.png":@"Background.png"]];
    background.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    //background.contentMode = UIViewContentModeBottom;
    [self.view addSubview:background];
    [background release];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self setupNavBar];
    
    self.curMenu = MENU_HOME;
    FQControls *controls = [FQControls currentControls];
    
    if(controls.user != nil && controls.user.loggedIn) {
        [self nextMenu];
    } else {
        self.loginMenu = [[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:[NSBundle mainBundle]] autorelease];
        [self presentModalViewController:self.loginMenu animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark - Menu functions

- (Menu*)createMenu:(int)menuType forceNew:(BOOL)forceNew {
    Menu *menu = nil;
    switch (menuType) {
        case MENU_HOME:
            
            break;
        case MENU_MAIN:
            if(self.mainMenu == nil || forceNew) {
                if(self.mainMenu != nil && forceNew) {
                    [self.mainMenu removeFromSuperview];
                    self.mainMenu = nil;
                }
                self.mainMenu = [[[MainMenu alloc] initWithFrame:menu_offset_frame] autorelease];
                [self.view addSubview:self.mainMenu];
            }
            menu = self.mainMenu;
            break;
        default:
            break;
    }
    
    return menu;
}

- (void)previousMenu {
    //FQControls *controls = [FQControls currentControls];
    
    //determine previous menu
    int prevMenu = self.curMenu-1;
    //if(controls.dateType == DATEMODE_RANDOM && prevMenu == MENU_OPTIONS)
    //    prevMenu = MENU_DARES; //skip options menu if random date
    
    Menu *menu1 = [self createMenu:(self.curMenu) forceNew:NO];
    Menu *menu2 = [self createMenu:(prevMenu) forceNew:NO];
    
    //animate the menu shift
    [Animator slideMenu:menu1 x:((prevMenu == MENU_HOME) ? 0 : 0) y:0];
    [Animator slideMenu:menu2 x:((prevMenu == MENU_HOME) ? 0 : (-1*menu_default_frame.size.width)) y:0];
    
    /*
     if(prevMenu == MENU_COMPILING) {
     [menu2 removeFromSuperview];
     menu2 = nil;
     }
     */
    
    //save the new menu
    self.curMenu = prevMenu;
    
}

- (void)nextMenu {
    //If currently on the home menu, handle separately
    //if(self.curMenu == MENU_HOME) {
    //    [self closeHome];
    //    return;
    //}
    
    //FQControls *controls = [FQControls currentControls];
    
    //determine next menu
    int nextMenu = self.curMenu+1;
    
    //if(controls.dateType == DATEMODE_RANDOM && nextMenu == MENU_OPTIONS)
    //    nextMenu = MENU_COMPILING; //skip options menu if random date
    
    Menu *menu1 = [self createMenu:(self.curMenu) forceNew:NO];
    Menu *menu2 = [self createMenu:(nextMenu) forceNew:YES];
    
    //animate the menu shift
    [Animator slideMenu:menu1 x:((self.curMenu == MENU_HOME)?-1:-2)*menu_default_frame.size.width y:0];
    [Animator slideMenu:menu2 x:(-1*menu_default_frame.size.width) y:0];
    
    //save the new menu
    self.curMenu = nextMenu;
    
    if(self.curMenu-1 == MENU_HOME) {
        NSLog(@"close home");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


-(void)closeHome {
    //display get started view overlay
    
    
    //show nav bar
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    //FQControls *controls = [FQControls currentControls];
    
    //determine next menu
    int nextMenu = self.curMenu+1;
    
    //if(controls.dateType == DATEMODE_RANDOM && nextMenu == MENU_OPTIONS)
    //    nextMenu = MENU_COMPILING; //skip options menu if random date
    
    Menu *menu1 = [self createMenu:(self.curMenu) forceNew:NO];
    Menu *menu2 = [self createMenu:(nextMenu) forceNew:YES];
    
    //animate the menu shift
    [Animator slideMenu:menu1 x:((self.curMenu == MENU_HOME)?-1:-2)*menu_default_frame.size.width y:0];
    [Animator slideMenu:menu2 x:(-1*menu_default_frame.size.width) y:0];
    
    //save the new menu
    self.curMenu = nextMenu;
    
}

- (void)reloadMenu {
    if(self.curMenu == MENU_HOME) {
        [self.loginMenu reload];
        return;
    }
    //create new menu view and display
    Menu *menu1 = [self createMenu:(self.curMenu) forceNew:YES];
    [menu1 removeFromSuperview];
    menu1.frame = menu_default_frame;
    [self.view addSubview:menu1];
    
    //dismiss modal view
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupNavBar {
    FQControls *controls = [FQControls currentControls];
    
    // Create Navigation Bar
    //self.navBar = [[[UINavigationBar alloc] init] autorelease];
    //self.navBar.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 40.0f);
    //self.navBar.tintColor = [UIColor blackColor];
    
    // Create Title Label
    /*
     UILabel * nav_title = [[UILabel alloc] initWithFrame:CGRectMake(50, 2, 220, 36)];
     nav_title.font = [UIFont fontWithName:@"Futura" size:24];
     nav_title.textColor = [UIColor whiteColor];
     nav_title.adjustsFontSizeToFitWidth = YES;
     nav_title.textAlignment = NSTextAlignmentCenter;
     nav_title.text = APP_NAME;
     nav_title.backgroundColor = [UIColor clearColor];
     self.navigationItem.titleView = nav_title;
     [nav_title release];
     */
    
    UIImageView *titleImage = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MenuTitle.png"]] autorelease];
    titleImage.frame = CGRectMake(0.0f, 0.0f, 144.0f, 35.0f);
    self.navigationItem.titleView = titleImage;
    
    // Create Account Button
    UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithTitle:([controls loggedIn]) ? @"Account" : @"Login" style:UIBarButtonItemStyleDone target:self action:@selector(displayAccount)] autorelease];
    
    self.navigationItem.rightBarButtonItem = item;
    
    [self.navigationController.navigationBar setAlpha:1.0f];
}


-(void)displayAccount {
    AccountsViewController *accountView = [[AccountsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:accountView];
    [controller.navigationBar setTintColor:[UIColor blackColor]];
    accountView.title = @"Account";
    
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeModal)] autorelease];
    accountView.navigationItem.rightBarButtonItem = cancelButton;
    
    if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
        if(self.loginMenu != nil && self.curMenu == MENU_HOME)
            [self.loginMenu presentModalViewController:controller animated:YES];
        else
            [self presentViewController:controller animated:YES completion:nil];
    } else {
        if(self.loginMenu != nil && self.curMenu == MENU_HOME)
            [self.loginMenu presentModalViewController:controller animated:YES];
        else
            [self presentModalViewController:controller animated:YES];
    }
    [accountView release];
}

-(void)displayAccountForm {
    AccountFormViewController *accountView = [[AccountFormViewController alloc] initWithNibName:@"AccountFormViewController" bundle:[NSBundle mainBundle]];
    
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:accountView];
    [controller.navigationBar setTintColor:[UIColor blackColor]];
    accountView.title = @"Create Account";
    
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(closeModal)] autorelease];
    accountView.navigationItem.rightBarButtonItem = cancelButton;
    
    if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
        if(self.loginMenu != nil && self.curMenu == MENU_HOME)
            [self.loginMenu presentModalViewController:controller animated:YES];
        else
            [self presentViewController:controller animated:YES completion:nil];
    } else {
        if(self.loginMenu != nil && self.curMenu == MENU_HOME)
            [self.loginMenu presentModalViewController:controller animated:YES];
        else
            [self presentModalViewController:controller animated:YES];
    }
    [accountView release];
}

-(void)viewMyQ {
    MyQViewController *myQView = [[MyQViewController alloc] initWithNibName:@"MyQViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:myQView animated:YES];
}

-(void)viewSendQ {
    SendQViewController *sendQView = [[SendQViewController alloc] initWithNibName:@"SendQViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:sendQView animated:YES];
}

-(void)closeModal {
    NSLog(@"close modal1");
    switch (self.curMenu) {
        case MENU_HOME:
            [self reloadMenu];
            if(self.loginMenu != nil)
                [self.loginMenu dismissViewControllerAnimated:YES completion:nil];
            break;
        default:
            //dismiss modal view
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
    }
}


@end
