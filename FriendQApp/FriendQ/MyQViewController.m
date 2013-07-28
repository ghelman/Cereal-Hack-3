//
//  MyQViewController.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "MyQViewController.h"
#import "MyQTableViewCell.h"
#import "MyQLeftTableViewCell.h"
#import "MyQRightTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface MyQViewController ()

@end

@implementation MyQViewController
@synthesize dataQuery, queueTable, viewCells;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"My Q";
        
        UIImageView *userImage = [[[UIImageView alloc] initWithFrame:CGRectMake(25.0f, 7.0f, 70.0f, 70.0f)] autorelease];
        [userImage setImage:[UIImage imageNamed:@"Melody.png"]];
        
        userImage.layer.cornerRadius = 10.0f;
        userImage.clipsToBounds = YES;
        userImage.layer.borderColor = [[UIColor grayColor] CGColor];
        userImage.layer.borderWidth = 5.0f;
        
        [self.view addSubview:userImage];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    FQControls *controls = [FQControls currentControls];
    
    self.viewCells = [[[NSMutableDictionary alloc] init] autorelease];
    
    self.dataQuery = [[[AppData alloc] init] autorelease];
    [self.dataQuery addObserver:self forKeyPath:@"queryDone" options:NSKeyValueObservingOptionNew context:nil];
    [self.dataQuery queryWithUserID:(controls.user != nil) ? controls.user.userid : 0];
}



#pragma mark Observer Handling

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    FQControls *controls = [FQControls currentControls];
    NSMutableArray *data = self.dataQuery.results;
    [self.dataQuery removeObserver:self forKeyPath:@"queryDone"];
    
    controls.queue = data;
    
    
    
    //refresh table
    [self.queueTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    FQControls *controls = [FQControls currentControls];
    return (([controls.queue count] > 0) ? [controls.queue count] : 0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FQControls *controls = [FQControls currentControls];
    Recommendation *item = (Recommendation*)[controls.queue objectAtIndex:indexPath.row];
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%i", indexPath.row];
    if([viewCells objectForKey:CellIdentifier] != nil) {
        if(indexPath.row % 2 == 1)
            return (MyQLeftTableViewCell*)[viewCells objectForKey:CellIdentifier];
        else
            return (MyQRightTableViewCell*)[viewCells objectForKey:CellIdentifier];
    }
    
    MyQTableViewCell *cell = (MyQTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if(indexPath.row % 2 == 1)
            cell = [[[MyQLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
        else
            cell = [[[MyQRightTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [cell setData:item];
    
    //save cell
    [viewCells setObject:cell forKey:CellIdentifier];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    FQControls *controls = [FQControls currentControls];
    if([controls.queue count] == 0) return NO;
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


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

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    //if([self.data count] == 0 && indexPath.section == 1)
    //    return NO;
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
