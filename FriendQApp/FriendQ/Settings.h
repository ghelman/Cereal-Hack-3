//
//  Settings.h
//  FriendQ
//
//  Created by Alex Rude on 7/28/13.
//  Copyright (c) 2013 Alex Rude. All rights reserved.
//

#ifndef FriendQ_Settings_h
#define FriendQ_Settings_h


#define APP_NAME @"FriendQ"
#define APP_VERSION 1.0

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
#define IS_IPHONE_SIM ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone Simulator" ] )
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )
#define IS_IPHONE_5 ( (IS_IPHONE || IS_IPHONE_SIM) && IS_WIDESCREEN )

#define BACKGROUND_COLOR [UIColor blackColor]
#define menuTitleColor [UIColor lightGrayColor]
#define menuSubtitleColor [UIColor lightGrayColor]

#define menu_default_frame CGRectMake(0.0f, 0.0f, 320.0f, 500.0f)
#define menu_offset_frame CGRectMake(320.0f, 0.0f, 320.0f, 500.0f)
#define menu_login_frame CGRectMake(0.0f, 0.0f, 320.0f, 500.0f)

#define menuButtonYPos 0.0f
#define menuButtonXPos 25.0f
#define menuButtonWidth 270.0f
#define menuButtonHeight 53.0f
#define menuButtonHeightS 24.0f
#define menuButtonSpacing 9.0f
#define menuDisplayTime 0.15f
#define menuLabelHeight 50.0f
#define menuLabelXPos 10.0f
#define menuLabelSpacing 4.0f
#define menuLabelWidth 300.0f
#define menuFieldLabelWidth 120.0f
#define menuFieldLabelHeight 30.0f
#define menuFieldXPos 140.0f
#define menuFieldWidth 170.0f
#define menuFieldHeight 30.0f

#define menuNavWidth 75.0f
#define menuNavHeight 35.0f
#define menuLeftNavXPos 25.0f
#define menuRightNavXPos 220.0f
#define menuNavButtonYPos 350.0f

#define menuButtonYPos_iPhone5 15.0f
#define menuButtonSpacing_iPhone5 15.0f

typedef enum {
    MENU_HOME,
    MENU_MAIN
} appMenus;

typedef enum {
    BUTTON_COLOR_BLUE,
    BUTTON_COLOR_PINK
} buttonColors;


typedef enum {
    SUPPORT_SUPPORT,
    SUPPORT_FEEDBACK,
    SUPPORT_TERMS,
	SUPPORT_PRIVACY
} supportTypes;

#endif
