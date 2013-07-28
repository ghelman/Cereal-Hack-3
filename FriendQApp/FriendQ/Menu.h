//
//  Menu.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Menu : UIView {
    int menuType;
}

@property (nonatomic) int menuType;

-(id)initDefault;
-(id)initOffset;

-(UILabel*)createTitleLabelWithText:(NSString*)text;
-(UILabel*)createSubtitleLabelWithText:(NSString*)text;

-(UIButton*)createMenuButtonWithText:(NSString*)text y:(CGFloat)yPos color:(int)color action:(SEL)action;
-(UIButton*)createMenuButtonWithImage:(UIImage*)image y:(CGFloat)yPos action:(SEL)action;

-(UILabel*)createFieldLabelWithText:(NSString*)text y:(CGFloat)yPos;
-(UITextField*)createTextFieldWithValue:(NSString*)value y:(CGFloat)yPos;
-(UITextField*)createNumberFieldWithValue:(NSString*)value y:(CGFloat)yPos;

-(UIButton*)createBackButton;
-(UIButton*)createNextButton;

-(void)displayNavigation;

@end
