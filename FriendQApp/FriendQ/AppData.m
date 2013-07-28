//
//  AppData.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "AppData.h"
#import "JSON.h"

@implementation AppData
@synthesize nextURL, receivedData, results, queryDone;
@synthesize pageNumber, pageCount, totalResults;

-(id)init {
    self = [super init];
    if(self) {
        self.queryDone = NO;
    }
    return self;
}

-(void)queryWithUserID:(int)userid {
    self.results = [[[NSMutableArray alloc] init] autorelease];
    
    // Create the URL String for the query
    NSString *urlString = [@"http://friendq.alexrude.com/api/queue.php" stringByAppendingFormat:@"?userid=%i", userid];
    
    NSLog(@"load: %@", urlString);
	// Create NSURL string from formatted string
	NSURL *url = [NSURL URLWithString:urlString];
	
	// Setup and start async download
	self.receivedData = @"";
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection release];
	[request release];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	// Store incoming data into a string
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if(jsonString != nil)
        self.receivedData = [self.receivedData stringByAppendingString:jsonString];
	[jsonString release];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"data: %@", self.receivedData);
	// Create a dictionary from the JSON string
	NSDictionary *values = [receivedData JSONValue];
    
    // Get result info
    self.totalResults = [[values objectForKey:@"total_items"] intValue];
    self.pageNumber = [[values objectForKey:@"page_number"] intValue];
    self.pageCount = [[values objectForKey:@"page_count"] intValue];
    
	// Build an array from the dictionary for easy access to each entry
    NSArray *resultData = [values objectForKey:@"queue"];
        
    // Create array for new photos
    NSMutableArray *data = [[[NSMutableArray alloc] init] autorelease];
    
    // Loop through each entry in the dictionary...
    for (NSDictionary *event in resultData)
    {
        int recID = [[event objectForKey:@"recommendation_id"] intValue];
        int statusid = [[event objectForKey:@"status_id"] intValue];
        NSString *status = [event objectForKey:@"status"];
        int typeid = [[event objectForKey:@"media_type_id"] intValue];
        NSString *media_type = [event objectForKey:@"media_type"];
        
        NSString *title = [event objectForKey:@"title"];
        NSString *desc = [event objectForKey:@"description"];
        NSString *user_name = [event objectForKey:@"user_name"];
        NSString *sender_name = [event objectForKey:@"sender_name"];
        NSString *user_pic = [event objectForKey:@"user_picture_url"];
        NSString *sender_pic = [event objectForKey:@"sender_picture_url"];
        
        
        Recommendation *r = [[Recommendation alloc] init];
        r.rID = recID;
        r.statusid = statusid;
        r.status = ((NSNull*)status != [NSNull null]) ? status : @"";
        r.media_typeid = typeid;
        r.media_type = ((NSNull*)media_type != [NSNull null]) ? media_type : @"";
        
        r.title = ((NSNull*)title != [NSNull null]) ? title : @"";
        r.desc = ((NSNull*)desc != [NSNull null]) ? desc : @"";
        r.user_name = ((NSNull*)user_name != [NSNull null]) ? user_name : @"";
        r.sender_name = ((NSNull*)sender_name != [NSNull null]) ? sender_name : @"";
        r.user_pic = ((NSNull*)user_pic != [NSNull null]) ? user_pic : @"";
        r.sender_pic = ((NSNull*)sender_pic != [NSNull null]) ? sender_pic : @"";
        
        // Get the images
        /*
         NSDictionary *images = [photo objectForKey:@"image"];
         if((NSNull*)images != [NSNull null]) {
         NSString *stitle = [caption objectForKey:@"text"];
         NSString *created = [caption objectForKey:@"created_time"];
         // Save the title to the photo titles array
         [set setObject:(([stitle length] > 0) ? stitle : @"Untitled") forKey:@"title"];
         [set setObject:created forKey:@"time"];
         }
         */
        
        [data addObject:r];
        [r release];
    }
    
    NSLog(@"queryDone");
    self.results = data;
    self.queryDone = YES;
}

-(void)dealloc {
    if(nextURL != nil)
        [nextURL release];
    if(receivedData != nil)
        [receivedData release];
    if(results != nil)
        [results release];
    [super dealloc];
}

@end
