//
//  SendQViewController.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "SendQViewController.h"

@interface SendQViewController ()

@end

@implementation SendQViewController
@synthesize titleField, urlField, typeField, descField, userField;
@synthesize role1Picker, role2Picker, menu;
@synthesize curType, curUserid;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Send Q";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)selectType:(id)sender {
    
    UITextField *field = (UITextField*)sender;
    NSLog(@"select role");
    
    if(field.tag == 1) {
        //set up the stage picker for later
        if(!self.role1Picker) {
            self.role1Picker = [[[UIPickerView alloc] init] autorelease];
            self.role1Picker.frame = CGRectMake(0.0f, 0.0f, 320.0f, 216.0f);
            self.role1Picker.delegate = self;
            self.role1Picker.showsSelectionIndicator = YES;
            self.role1Picker.tag = 1;
            [self.role1Picker selectRow:(curType > 0) ? curType-1 : 0 inComponent:0 animated:NO];
        }
        
        //add the category picker to the actionsheet
        [menu addSubview:role1Picker];
    } else if (field.tag == 2) {
        //set up the stage picker for later
        if(!self.role2Picker) {
            self.role2Picker = [[[UIPickerView alloc] init] autorelease];
            self.role2Picker.frame = CGRectMake(0.0f, 0.0f, 320.0f, 216.0f);
            self.role2Picker.delegate = self;
            self.role2Picker.showsSelectionIndicator = YES;
            self.role2Picker.tag = 2;
            [self.role2Picker selectRow:(curUserid > 0) ? curUserid-1 : 0 inComponent:0 animated:NO];
        }
    }
    
	//create the action sheet
        self.menu = [[UIActionSheet alloc] initWithTitle:@""
                                                delegate:self
                                           cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                           otherButtonTitles:nil];
    
        
    //add the category picker to the actionsheet
    if(field.tag == 1)
        [self.menu addSubview:self.role1Picker];
    else
        [self.menu addSubview:self.role2Picker];
	
	//display the actionsheet
	[self.menu showInView:self.view];
    [self.menu setBounds:CGRectMake(0, 0, 320.0f, 400)];
}


#pragma mark - Role Picker Functions

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return (pickerView.tag == 1) ? 7: 4;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    NSString *title = @"";
    if(pickerView.tag == 1) {
        switch(row) {
            case 0: title = @"Enjoy"; break;
            case 1: title = @"Watch"; break;
            case 2: title = @"Hear"; break;
            case 3: title = @"Read"; break;
            case 4: title = @"Eat"; break;
            case 5: title = @"Play"; break;
            case 6: title = @"Do"; break;
        }
        
    } else {
        switch(row) {
            case 0: title = @"forevermelody"; break;
            case 1: title = @"alexrude"; break;
            case 2: title = @"seanksutter"; break;
            case 3: title = @"gabehelman"; break;
        }
    }
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *title = @"";
    if(pickerView.tag == 1) {
        switch(row) {
            case 0: title = @"Enjoy"; break;
            case 1: title = @"Watch"; break;
            case 2: title = @"Hear"; break;
            case 3: title = @"Read"; break;
            case 4: title = @"Eat"; break;
            case 5: title = @"Play"; break;
            case 6: title = @"Do"; break;
        }
        self.curType = row+1;
        self.typeField.text = title;
    } else if(pickerView.tag == 2) {
        switch(row) {
            case 0: title = @"forevermelody"; break;
            case 1: title = @"alexrude"; break;
            case 2: title = @"seanksutter"; break;
            case 3: title = @"gabehelman"; break;
        }
        self.curUserid = row+1;
        self.userField.text = title;
    }
	
	//close the action sheet
    if(self.menu)
        [self.menu dismissWithClickedButtonIndex:0 animated:YES];
}

-(IBAction)saveRecommendation:(id)sender {
    Recommendation *rec = [[Recommendation alloc] init];
    rec.title = titleField.text;
    rec.url = urlField.text;
    rec.media_typeid = curType;
    rec.recepientid = curUserid;
    rec.desc = descField.text;
    
    BOOL valid = [DataSender sendRecommendation:rec];
    
    if(valid) {
        UIAlertView *alert = [[UIAlertView alloc] init];
        [alert setTitle:@"Push to Q"];
        [alert setMessage:@"Your Recommendation has been sent!"];
        [alert setDelegate:self];
        [alert addButtonWithTitle:@"OK"];
        [alert show];
        [alert release];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
