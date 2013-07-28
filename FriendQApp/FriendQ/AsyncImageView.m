//
//  AsyncImageView.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "AsyncImageView.h"

#import <QuartzCore/QuartzCore.h>

@implementation AsyncImageView
@synthesize asyncImage, loaded, loadingView;

- (void)dealloc {
	[connection cancel]; //in case the URL is still downloading
	[connection release];
	[data release];
	[asyncImage release];
    if(loadingView != nil)
        [loadingView release];
    [super dealloc];
}


- (void)loadImageFromURL:(NSURL*)url {
	if (connection!=nil) { [connection release]; } //in case we are downloading a 2nd image
	if (data!=nil) { [data release]; }
	if (asyncImage!=nil) { [asyncImage release]; }
    
	loaded = NO;
    
	NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; //notice how delegate set to self object
	//TODO error handling, what if connection is nil?
}


//the URL connection calls this repeatedly as data arrives
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	if (data==nil) { data = [[NSMutableData alloc] initWithCapacity:2048]; }
	[data appendData:incrementalData];
}

//the URL connection calls this once all the data has downloaded
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	//NSLog(@"image loaded");
	//so self data now has the complete image
	[connection release];
	connection=nil;
	if ([[self subviews] count]>0) {
		//then this must be another image, the old one is still in subviews
		[[[self subviews] objectAtIndex:0] removeFromSuperview]; //so remove it (releases it also)
	}
    
    if(self.loadingView != nil) {
        [self.loadingView stopAnimating];
        [self.loadingView removeFromSuperview];
    }
    
	//save the image
	//self.asyncImage = [UIImage imageWithData:data];
    
	//start resizing the image
    UIImage *scaledImage = [UIImage imageWithData:data];
    UIImageView *scaledImageView = [[UIImageView alloc] initWithImage:scaledImage];
    CGSize loadedImageSize = scaledImageView.frame.size;
    [scaledImageView release];
    
    float scale = (scaledImage.size.width > scaledImage.size.height) ? self.frame.size.width / scaledImage.size.width : self.frame.size.height / scaledImage.size.height;
    
    CGSize imgSize;
    UIGraphicsBeginImageContext(self.frame.size);
    [scaledImage drawInRect:CGRectMake(0, 0, loadedImageSize.width * scale, loadedImageSize.height * scale)];
    scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imgSize = CGSizeMake(loadedImageSize.width * scale, loadedImageSize.height * scale);
    
    self.asyncImage = scaledImage;
	
	//reload the flickr view
    loaded = YES;
	
    //make an image view for the image
        
    UIImageView* imgView = [[[UIImageView alloc] initWithImage:asyncImage] autorelease];
    //make sizing choices based on your needs, experiment with these. maybe not all the calls below are needed.
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
    //if(delegate == nil)
    imgView.frame = self.bounds;
    
    imgView.layer.cornerRadius = 10.0f;
    imgView.clipsToBounds = YES;
    imgView.layer.borderColor = [[UIColor grayColor] CGColor];
    imgView.layer.borderWidth = 5.0f;
    //else {
    //    imgView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, asyncImage.size.width, asyncImage.size.height);
    //}
    
    [self addSubview:imgView];
    [imgView setNeedsLayout];
    [self setNeedsLayout];
    
	[data release]; //don't need this any more, its in the UIImageView now
	data=nil;
}

//just in case you want to get the image directly, here it is in subviews
- (UIImage*) image {
	UIImageView* iv = [[self subviews] objectAtIndex:0];
	return [iv image];
}
@end
