//
//  StringHelper.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringHelper)

- (NSString *)cleanUpHTMLEntities;
- (CGFloat)textHeightForSystemFontSize:(CGFloat)size;
- (CGRect)frameForCellLabelWithSystemFontSize:(CGFloat)size;
- (CGRect)frameForCellTextViewWithSystemFontSize:(CGFloat)size;
- (UILabel *)newSizedCellLabelWithSystemFontSize:(CGFloat)size;
- (UITextView *)newSizedCellTextViewWithSystemFontSize:(CGFloat)size;
- (void)resizeLabel:(UILabel *)aLabel withSystemFontSize:(CGFloat)size;

-(NSString*)stripHTMLTags;
- (NSString *)urlencode;

-(NSString *)fixUpdateDate;

- (BOOL) validateEmail;
- (BOOL) validatePassword;

@end
