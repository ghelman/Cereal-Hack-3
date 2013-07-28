//
//  AccountsTableCell.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "AccountsTableCell.h"

@implementation AccountsTableCell
@synthesize fieldLabel, valueLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		UIView *myContentView = self.contentView;
        CGRect contentRect = self.contentView.bounds;
		CGFloat boundsX = contentRect.origin.x;
		
		self.fieldLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize:18.0 bold:YES];
		self.fieldLabel.textAlignment = NSTextAlignmentLeft;
		self.fieldLabel.adjustsFontSizeToFitWidth = YES;
		[myContentView addSubview:self.fieldLabel];
        self.fieldLabel.frame = CGRectMake(boundsX + 5, 5, 70, 45);
		[self.fieldLabel release];
		
		self.valueLabel = [self newLabelWithPrimaryColor:menuSubtitleColor selectedColor:[UIColor whiteColor] fontSize:16.0 bold:NO];
		self.valueLabel.textAlignment = NSTextAlignmentRight;
		self.valueLabel.adjustsFontSizeToFitWidth = YES;
        self.valueLabel.numberOfLines = 1;
		[myContentView addSubview:self.valueLabel];
        self.valueLabel.frame = CGRectMake(boundsX + 75, 5, 200, 45);
		[self.valueLabel release];
    }
    return self;
}

-(void)setField:(NSString*)field value:(NSString*)value {
	self.fieldLabel.text = field;
	self.valueLabel.text = value;
}

-(void)layoutSubviews {
	[super layoutSubviews];
	
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	UIFont *font;
	if(bold) {
		font = [UIFont fontWithName:@"Futura-Medium" size:fontSize];
	} else {
		font = [UIFont fontWithName:@"Futura" size:fontSize];
	}
	
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor clearColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	
	return newLabel;
}
- (void)dealloc {
	[valueLabel release];
	[fieldLabel release];
    [super dealloc];
}

@end
