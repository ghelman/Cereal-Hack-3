//
//  Animator.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animator : NSObject

+(void)shiftMenu:(UIView*)view withPosition:(CGFloat)yPos;
+(void)slideMenu:(UIView*)view x:(CGFloat)xPos y:(CGFloat)yPos;

+(void)toggleAlpha:(UIView*)view withAlpha:(CGFloat)alpha;

+(void)displayView:(UIView*)view duration:(CGFloat)duration delay:(CGFloat)delay;

@end
