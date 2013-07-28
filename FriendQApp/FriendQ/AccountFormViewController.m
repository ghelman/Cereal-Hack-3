//
//  AccountFormViewController.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "AccountFormViewController.h"
#import "FQAppDelegate.h"
#import "FQViewController.h"

@interface AccountFormViewController ()

@end

@implementation AccountFormViewController
@synthesize nameField, emailField, birthdateField, genderField, password1Field, password2Field;
@synthesize menu, datePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Account";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Populate data of logged in user
    FQControls *controls = [FQControls currentControls];
    if([controls loggedIn]) {
        [self loadWithLogin:controls.user field:0];
    }
}

-(void)loadWithLogin:(Login*)user field:(int)field {
    self.nameField.text = user.first_name;
    self.emailField.text = user.email;
    self.birthdateField.text = [user getBirthdateString];
    self.genderField.selectedSegmentIndex = ([user.gender isEqualToString:@"male"]) ? 0 : 1;
    
    if(field <= 3) {
        UIResponder* responder = [self.view viewWithTag:field];
        if (responder) {
            // Found next responder, so set it.
            [responder becomeFirstResponder];
        }
    }
}

-(IBAction)selectDate:(id)sender {
    
    self.datePicker = [[[UIDatePicker alloc] init] autorelease];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.frame = CGRectMake(0.0f, 172.0f, 320.0f, 216.0f);
    
    if([self.birthdateField.text length] > 0) {
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        NSDate *date = [dateFormatter dateFromString:self.birthdateField.text];
        [self.datePicker setDate:date animated:NO];
    }
    
    //create the action sheet
    self.menu = [[[UIActionSheet alloc] initWithTitle:@"Birthdate"
                                             delegate:self
                                    cancelButtonTitle:@"Cancel"
                               destructiveButtonTitle:@"Save Date"
                                    otherButtonTitles:nil] autorelease];
    [menu addSubview:datePicker];
	
	//display the actionsheet
	[self.menu showInView:self.view];
    [menu setBounds:CGRectMake(0, 0, 320, 600)];
}

-(BOOL)validateUser:(BOOL)reqPassword {
    
    //Validate
    NSMutableArray *errors = [[NSMutableArray alloc] init];
    //make sure a name value is set
    if([self.nameField.text length] == 0)
        [errors addObject:@"You must enter your Name"];
    //email
    if([self.emailField.text length] == 0)
        [errors addObject:@"You must enter an Email"];
    else if(![self.emailField.text validateEmail])
        [errors addObject:@"You must enter a valid Email"];
    //birthdate
    //if([self.birthdateField.text length] == 0)
    //    [errors addObject:@"You must enter a Zip Code"];
    
    //password1
    if([self.password1Field.text length] == 0 && reqPassword)
        [errors addObject:@"You must enter a Password"];
    else if([self.password1Field.text length] > 0 && ![self.password1Field.text validatePassword])
        [errors addObject:@"Passwords must be at least 6 characters and contain alphabetic and numeric values"];
    
    //password2
    if([self.password2Field.text length] == 0 && (reqPassword || [self.password1Field.text length] > 0))
        [errors addObject:@"You must re-enter a Password"];
    else if([self.password1Field.text length] > 0 && ![self.password1Field.text isEqualToString:self.password2Field.text])
        [errors addObject:@"Passwords do not match"];
    
    if([errors count] > 0) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Create Account" message:[errors componentsJoinedByString:@"\n"]
                                                        delegate:nil
                                               cancelButtonTitle:NSLocalizedString(@"Ok",nil)
                                               otherButtonTitles:nil] autorelease];
        [alert show];
        return NO;
    }
    
    return YES;
}

-(IBAction)saveUser:(id)sender {
    FQControls *controls = [FQControls currentControls];
    
    BOOL newUser = ![controls loggedIn] ? YES : NO;
    
    if(![self validateUser:newUser])
        return;
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    //Save data
    Login *login = [[Login alloc] init];
    login.first_name = self.nameField.text;
    login.email = self.emailField.text;
    login.birthday  = [dateFormatter dateFromString:self.birthdateField.text];
    login.gender = (self.genderField.selectedSegmentIndex == 0) ? @"male" : @"female";
    login.userid = (!newUser) ? controls.user.userid : 0;
    
    //get password
    NSString *password = password1Field.text;
    //encrypt password
    
    //send user data to server
    int userid = [DataSender sendUserRequest:((newUser)?@"createuser":@"updateuser") user:login password:password];
    if(userid <= 0) return;
    
    //save login
    login.userid = userid;
    login.loggedIn = YES;
    controls.user = login;
    [controls save];
    
    //alert user of success
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"FriendQ Account"
                                                     message:@"Your FriendQ account has been saved."
                                                    delegate:nil
                                           cancelButtonTitle:NSLocalizedString(@"Ok",nil)
                                           otherButtonTitles:nil] autorelease];
    [alert show];
    
    //Close modal view
    FQAppDelegate *appDelegate = (FQAppDelegate *)[[UIApplication sharedApplication] delegate];
    [(FQViewController*)appDelegate.navigationController.topViewController closeModal];
}

-(IBAction)updateUser:(id)sender {
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSLog(@"clicked");
	if(buttonIndex == 0) {
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        
        NSDate *date = self.datePicker.date;
        self.birthdateField.text = [dateFormatter stringFromDate:date];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == 2) return NO;
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
