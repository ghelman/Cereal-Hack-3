//
//  Animator.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "Animator.h"

@implementation Animator

+(void)shiftMenu:(UIView*)view withPosition:(CGFloat)yPos {
    [UIView beginAnimations:@"shiftMenu" context:NULL];
    [UIView setAnimationDuration:1.0];
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0.0f, yPos);
    view.transform = transform;
    [UIView commitAnimations];
}

+(void)slideMenu:(UIView*)view x:(CGFloat)xPos y:(CGFloat)yPos {
    [UIView beginAnimations:@"slideMenu" context:NULL];
    [UIView setAnimationDuration:0.5];
    CGAffineTransform transform = CGAffineTransformMakeTranslation(xPos, yPos);
    view.transform = transform;
    [UIView commitAnimations];
}

+(void)toggleAlpha:(UIView*)view withAlpha:(CGFloat)alpha {
    [UIView beginAnimations:@"toggleMenuAlpha" context:NULL];
    [UIView setAnimationDuration:0.5];
    [view setAlpha:alpha];
    [UIView commitAnimations];
}

+(void)displayView:(UIView*)view duration:(CGFloat)duration delay:(CGFloat)delay {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelay:delay];
    [view setAlpha:1.0];
    [UIView commitAnimations];
}


@end
