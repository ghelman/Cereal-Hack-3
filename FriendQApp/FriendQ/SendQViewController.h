//
//  SendQViewController.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendQViewController : UIViewController <UIAlertViewDelegate, UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
    UITextField *titleField;
    UITextField *urlField;
    UITextField *typeField;
    UITextField *descField;
    UITextField *userField;
    
    int curType;
    int curUserid;
    
	UIActionSheet *menu;
	UIPickerView *role1Picker;
	UIPickerView *role2Picker;
}

@property (nonatomic, retain) IBOutlet UITextField *titleField;
@property (nonatomic, retain) IBOutlet UITextField *urlField;
@property (nonatomic, retain) IBOutlet UITextField *typeField;
@property (nonatomic, retain) IBOutlet UITextField *descField;
@property (nonatomic, retain) IBOutlet UITextField *userField;

@property (nonatomic) int curType;
@property (nonatomic) int curUserid;

@property (nonatomic, retain) UIActionSheet *menu;
@property (nonatomic, retain) UIPickerView *role1Picker;
@property (nonatomic, retain) UIPickerView *role2Picker;

-(IBAction)selectType:(id)sender;

@end
