//
//  DataSender.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Login.h"
#import "Recommendation.h"

@interface DataSender : NSObject

+(BOOL)sendRecommendation:(Recommendation*)item;

+(int)sendUserRequest:(NSString*)request user:(Login*)user password:(NSString*)password;

@end
