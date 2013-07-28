//
//  AccountsTableCell.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountsTableCell : UITableViewCell {
    UILabel *fieldLabel;
    UILabel *valueLabel;
}

@property (nonatomic, retain) UILabel *fieldLabel;
@property (nonatomic, retain) UILabel *valueLabel;

-(void)setField:(NSString*)field value:(NSString*)value;

-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

@end
