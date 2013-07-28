//
//  StringHelper.m
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#import "StringHelper.h"

@implementation NSString (StringHelper)

- (NSString *)cleanUpHTMLEntities {
	NSString *text = self;
	text = [text stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
	text = [text stringByReplacingOccurrencesOfString:@"&amp;"  withString:@"&"];
	text = [text stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
	text = [text stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
	text = [text stringByReplacingOccurrencesOfString:@"&#8216;" withString:@"'"];
	text = [text stringByReplacingOccurrencesOfString:@"&#8217;" withString:@"'"];
	text = [text stringByReplacingOccurrencesOfString:@"&lt;"   withString:@"<"];
	text = [text stringByReplacingOccurrencesOfString:@"&gt;"   withString:@">"];
	text = [text stringByReplacingOccurrencesOfString:@"&copy;" withString:@"©"];
	text = [text stringByReplacingOccurrencesOfString:@"&reg;"  withString:@"®"];
	text = [text stringByReplacingOccurrencesOfString:@"&#8230;" withString:@"..."];
	text = [text stringByReplacingOccurrencesOfString:@"&#8220;" withString:@"\""];
	text = [text stringByReplacingOccurrencesOfString:@"&#8221;" withString:@"\""];
	text = [text stringByReplacingOccurrencesOfString:@"&#8212;" withString:@"-"];
	text = [text stringByReplacingOccurrencesOfString:@"&#8211;" withString:@"-"];
	text = [text stringByReplacingOccurrencesOfString:@"&#160;" withString:@" "];
	text = [text stringByReplacingOccurrencesOfString:@"&#246;" withString:@"o"];
	text = [text stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
	text = [text stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
	
	return text;
}

- (CGFloat)textHeightForSystemFontSize:(CGFloat)size {
	//Calculate the expected size based on the font and linebreak mode of your label
	//CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 0;
	CGFloat maxWidth = 310.0f;
	CGFloat maxHeight = 99999;
	CGSize maximumLabelSize = CGSizeMake(maxWidth,maxHeight);
	//NSLog(@"(%f, %f)", maxWidth, maxHeight);
	CGSize expectedLabelSize = [self sizeWithFont:[UIFont fontWithName:@"Futura" size:size]
								constrainedToSize:maximumLabelSize
									lineBreakMode:NSLineBreakByWordWrapping];
	
	return expectedLabelSize.height;
}

- (CGRect)frameForCellLabelWithSystemFontSize:(CGFloat)size {
	CGFloat width = 320.0f - 10;
	CGFloat height = [self textHeightForSystemFontSize:size] + 10.0;
	return CGRectMake(0.0f, 0.0f, width, height);
}

- (CGRect)frameForCellTextViewWithSystemFontSize:(CGFloat)size {
	CGFloat width = 320.0f - 10;
	CGFloat height = [self textHeightForSystemFontSize:size] + 10.0;
	return CGRectMake(0.0f, 0.0f, width, height);
}

- (void)resizeLabel:(UILabel *)aLabel withSystemFontSize:(CGFloat)size {
	aLabel.frame = [self frameForCellLabelWithSystemFontSize:size];
	aLabel.text = self;
	[aLabel sizeToFit];
}

- (UILabel *)newSizedCellLabelWithSystemFontSize:(CGFloat)size {
	UILabel *cellLabel = [[UILabel alloc] initWithFrame:[self frameForCellLabelWithSystemFontSize:size]];
	cellLabel.textColor = [UIColor blackColor];
	cellLabel.backgroundColor = [UIColor clearColor];
	cellLabel.textAlignment = NSTextAlignmentLeft;
	cellLabel.font = [UIFont systemFontOfSize:size];
	
	cellLabel.text = self;
	cellLabel.numberOfLines = 0;
	[cellLabel sizeToFit];
	return cellLabel;
}

- (UITextView *)newSizedCellTextViewWithSystemFontSize:(CGFloat)size {
	UITextView *cellLabel = [[UITextView alloc] initWithFrame:[self frameForCellTextViewWithSystemFontSize:size]];
	cellLabel.textColor = [UIColor blackColor];
	cellLabel.backgroundColor = [UIColor clearColor];
	cellLabel.textAlignment = NSTextAlignmentLeft;
	cellLabel.font = [UIFont systemFontOfSize:size];
	cellLabel.scrollEnabled = NO;
	cellLabel.editable = NO;
	cellLabel.dataDetectorTypes = UIDataDetectorTypeAll;
	
	cellLabel.text = self;
	return cellLabel;
}


-(NSString*)stripHTMLTags
{
	NSScanner *scanner;
	NSString *text = nil;
	NSString *tag = nil;
	
	NSString *data = self;
	//set up the scanner
	scanner = [NSScanner scannerWithString:data];
	while([scanner isAtEnd] == NO) {
		//find start of tag
		[scanner scanUpToString:@"<" intoString:NULL];
		//find end
		[scanner scanUpToString:@">" intoString:&text];
		//get the tag
		if([text rangeOfString:@"</"].location != NSNotFound)
			tag = [text substringFromIndex:2];
		else {
			tag = [text substringFromIndex:1];
			//findout if there is a space in the tag
			if([tag rangeOfString:@" "].location != NSNotFound)
				//remove text after space
				tag = [tag substringToIndex:[tag rangeOfString:@" "].location];
		}
		text = [NSString stringWithFormat:@"%@>", text];
		data = [data stringByReplacingOccurrencesOfString:text withString:@""];
	}
	
	data = [data stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
	return data;
}

- (NSString *)urlencode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

-(NSString *)fixUpdateDate {
	NSString *date = self;
	NSDateFormatter *newDateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[newDateFormatter setTimeStyle:NSDateFormatterFullStyle];
	[newDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[newDateFormatter setDateFormat:@"M/d/yyyy h:mm:ss a"];
	
	NSDate *newDate = [newDateFormatter dateFromString:date];
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[dateFormatter setDateFormat:@"yyyy-MM-dd h:mm:ss"];
	
	return [dateFormatter stringFromDate:newDate];
}

- (BOOL) validateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}
- (BOOL)validatePassword {
    NSString *password = self;
    // 1. Upper case.
    if (!([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[password characterAtIndex:0]]
            || [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:[password characterAtIndex:0]]))
        return NO;
    
    // 2. Length.
    if ([password length] < 5)
        return NO;
    
    // 3. Special characters.
    // Change the specialCharacters string to whatever matches your requirements.
    //NSString *specialCharacters = @"!#€%&/()[]=?$§*'";
    //if ([[password componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:specialCharacters]] count] < 2)
    //    return NO;
    
    // 4. Numbers.
    if ([[password componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]] count] < 2)
        return NO;
    
    return YES;
}

@end
