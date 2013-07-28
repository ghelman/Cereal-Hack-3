//
//  AccountFormViewController.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountFormViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate> {
    UITextField *nameField;
    UITextField *emailField;
    UITextField *birthdateField;
    UISegmentedControl *genderField;
    UITextField *password1Field;
    UITextField *password2Field;
    
    UIDatePicker *datePicker;
    UIActionSheet *menu;
}

@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UITextField *birthdateField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *genderField;
@property (nonatomic, retain) IBOutlet UITextField *password1Field;
@property (nonatomic, retain) IBOutlet UITextField *password2Field;

@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) UIActionSheet *menu;

-(void)loadWithLogin:(Login*)user field:(int)field;

-(IBAction)selectDate:(id)sender;

-(BOOL)validateUser:(BOOL)reqPassword;

-(IBAction)saveUser:(id)sender;
-(IBAction)updateUser:(id)sender;

@end
