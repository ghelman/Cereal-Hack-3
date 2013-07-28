//
//  AccountsViewController.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "AccountsViewController.h"
#import "AccountsTableCell.h"
#import "AccountFormViewController.h"
#import "SupportViewController.h"

@interface AccountsViewController ()

@end

@implementation AccountsViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = BACKGROUND_COLOR;
        self.tableView.backgroundColor = BACKGROUND_COLOR;
        self.tableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:(IS_IPHONE_5)?@"Background-568h@2x.png":@"Background.png"]] autorelease];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    FQControls *controls = [FQControls currentControls];
    int rows = 1;
    switch (section) {
        case 0: rows = ([controls loggedIn]) ? 5 : 1; break;
        case 1: rows = 4; break;
        default: rows = 1; break;
    }
    
    return rows;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = @"";
    switch (section) {
        case 0: title = @"Account Details"; break;
        case 1: title = @"Support"; break;
        default: break;
    }
    
    return title;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    // Create label with section title
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.frame = CGRectMake(10, 0, 284, 23);
    label.textColor = menuTitleColor;
    label.font = [UIFont fontWithName:@"Futura" size:18];
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    label.backgroundColor = [UIColor clearColor];
    
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    [view autorelease];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 55.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"Cell1";
    static NSString *CellIdentifier2 = @"Cell2";
    FQControls *controls = [FQControls currentControls];
    
    // Configure the cell...
    if(indexPath.section == 0) {
        NSLog(@"sec = %i, row = %i", indexPath.section, indexPath.row);
        AccountsTableCell *cell = (AccountsTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[[AccountsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
        }
        //if(controls.user != nil) {
        if([controls loggedIn]) {
            switch (indexPath.row) {
                case 0:
                    [cell setField:@"Name" value:(controls.user != nil) ? controls.user.first_name : @""];
                    break;
                case 1:
                    [cell setField:@"Email" value:(controls.user != nil) ? controls.user.email : @""];
                    break;
                case 2:
                    [cell setField:@"Birthday" value:(controls.user != nil) ? [controls.user getBirthdateString] : @""];
                    break;
                case 3:
                    [cell setField:@"Gender" value:(controls.user != nil) ? controls.user.gender : @""];
                    break;
                case 4:
                    [cell setField:@"" value:([controls loggedIn]) ? @"Log Out" : @"Login"];
                    break;
                    
                default:
                    break;
            }
        } else {
            [cell setField:@"Login" value:@""];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    } else if(indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2] autorelease];
        }
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Support";
                break;
            case 1:
                cell.textLabel.text = @"Feedback";
                break;
            case 2:
                cell.textLabel.text = @"Terms & Conditions";
                break;
            case 3:
                cell.textLabel.text = @"Privacy Policy";
                break;
                
            default:
                break;
        }
        cell.textLabel.font = [UIFont fontWithName:@"Futura" size:18.0f];
        return cell;
    }
    
    return nil;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FQControls *controls = [FQControls currentControls];
    if(indexPath.section == 0) {
        if(indexPath.row <= 3 && [controls loggedIn]) {
            AccountFormViewController *formView = [[AccountFormViewController alloc] initWithNibName:@"AccountFormViewController" bundle:[NSBundle mainBundle]];
            [formView loadWithLogin:controls.user field:(indexPath.row+1)];
            [self.navigationController pushViewController:formView animated:YES];
        }
        else if(indexPath.row == 4) {
            if([controls loggedIn])
                [controls logOut];
        }
        else if(![controls loggedIn]) {
            
        }
        [self.tableView reloadData];
    } else if(indexPath.section == 1) {
        SupportViewController *supportView = [[SupportViewController alloc] initWithNibName:@"SupportViewController" bundle:[NSBundle mainBundle]];
        [supportView setupForSupportType:indexPath.row];
        [self.navigationController pushViewController:supportView animated:YES];
    }
    
}


@end
