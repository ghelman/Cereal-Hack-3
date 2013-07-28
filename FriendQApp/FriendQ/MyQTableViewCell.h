//
//  MyQTableViewCell.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface MyQTableViewCell : UITableViewCell {
    AsyncImageView *userImage;
    UILabel *thinkLabel;
    UILabel *titleLabel;
    UIImageView *iconView;
    UIImageView *background;
}

@property (nonatomic, retain) AsyncImageView *userImage;
@property (nonatomic, retain) UILabel *thinkLabel;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *iconView;
@property (nonatomic, retain) UIImageView *background;

-(void)setData:(Recommendation*)item;

-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

@end
