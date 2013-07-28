//
//  AsyncImageView.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AsyncImageView : UIView {
	//could instead be a subclass of UIImageView instead of UIView, depending on what other features you want to
	// to build into this class?
    
	NSURLConnection* connection; //keep a reference to the connection so we can cancel download in dealloc
	NSMutableData* data; //keep reference to the data so we can collect it as it downloads
	//but where is the UIImage reference? We keep it in self.subviews - no need to re-code what we have in the parent class
	UIImage *asyncImage;
    
    UIActivityIndicatorView *loadingView;
    
    BOOL loaded;
}

@property (nonatomic, retain) UIImage *asyncImage;
@property (nonatomic) BOOL loaded;

@property (nonatomic, retain) UIActivityIndicatorView *loadingView;

@property (nonatomic, assign) id delegate;

- (void)loadImageFromURL:(NSURL*)url;
- (UIImage*) image;

@end
