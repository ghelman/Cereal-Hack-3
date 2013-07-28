//
//  MyQRightTableViewCell.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "MyQRightTableViewCell.h"

@implementation MyQRightTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		UIView *myContentView = self.contentView;
		
		self.background = [[[UIImageView alloc] init] autorelease];
		[myContentView addSubview:self.background];
		//self.background.contentMode = UIViewContentModeScaleToFill;
        
		self.userImage = [[[AsyncImageView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 140.0f, 140.0f)] autorelease];
		[myContentView addSubview:self.userImage];
        
		self.iconView = [[[UIImageView alloc] init] autorelease];
		[myContentView addSubview:self.iconView];
        
		self.thinkLabel = [self newLabelWithPrimaryColor:[UIColor whiteColor] selectedColor:[UIColor lightGrayColor] fontSize:14.0 bold:YES];
        self.thinkLabel.adjustsFontSizeToFitWidth = YES;
		[myContentView addSubview:self.thinkLabel];
		[self.thinkLabel release];
        
		self.titleLabel = [self newLabelWithPrimaryColor:[UIColor darkGrayColor] selectedColor:[UIColor lightGrayColor] fontSize:22.0 bold:YES];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
		[myContentView addSubview:self.titleLabel];
		[self.titleLabel release];
		
    }
    return self;
}

-(void)setData:(Recommendation*)item {
    NSString *action = @"...";
    NSString *icon = @"DoIcon.png";
    switch (item.media_typeid) {
        case 1:
        case 2: action = @"watch"; icon = @"WatchIcon.png"; break;
        case 3: action = @"hear"; icon = @"HearIcon.png"; break;
        case 4: action = @"read"; icon = @"ReadIcon.png"; break;
        case 5: action = @"eat"; icon = @"EatIcon.png"; break;
        case 6: action = @"enjoy"; icon = @"EnjoyIcon.png"; break;
        case 7: action = @"play"; icon = @"PlayIcon.png"; break;
        case 8: action = @"do"; icon = @"DoIcon.png"; break;
        default:
            break;
    }
    self.thinkLabel.text = [NSString stringWithFormat:@"%@ thinks you should %@", item.sender_name, action];
    self.titleLabel.text = item.title;
    [self.userImage loadImageFromURL:[NSURL URLWithString:item.sender_pic]];
    self.background.image = [UIImage imageNamed:@"myQBubbleRight.png"];
    self.iconView.image = [UIImage imageNamed:icon];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)layoutSubviews {
	[super layoutSubviews];
	
	CGRect contentRect = self.contentView.bounds;
	
	if(!self.editing) {
		CGFloat boundsX = contentRect.origin.x;
		CGRect frame;
		
		frame = CGRectMake(boundsX + 245, 10, 60, 60);
		self.userImage.frame = frame;
		
		frame = CGRectMake(boundsX + 52, 10, contentRect.size.width - 160, 20);
		self.thinkLabel.frame = frame;
		
		frame = CGRectMake(boundsX + 52, 30, contentRect.size.width - 160, 30);
		self.titleLabel.frame = frame;
		
		frame = CGRectMake(boundsX + 20, 25, 30, 30);
		self.iconView.frame = frame;
		
		frame = CGRectMake(boundsX + 10, 6, 234, 70);
		self.background.frame = frame;
	}
}

-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	UIFont *font;
	if(bold) {
		font = [UIFont boldSystemFontOfSize:fontSize];
	} else {
		font = [UIFont systemFontOfSize:fontSize];
	}
	
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor clearColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	
	return newLabel;
}

@end
