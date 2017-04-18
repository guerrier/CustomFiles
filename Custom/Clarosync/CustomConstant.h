//
//  CCConstant.h
//  Nextcloud
//
//  Created by Marino Faggiana on 06/03/17.
//  Copyright © 2017 TWS. All rights reserved.
//
//  Author Marino Faggiana <m.faggiana@twsweb.it>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

// Brand
#define k_brand                         @"ClaroSync"
#define k_mailMe                        @"info@clarosync.com"
#define k_textCopyright                 @"ClaroSync %@ © 2017 T.W.S. Inc."
#define k_loginBaseUrl                  @"https://skylake.weasel.rocks/c/mexico/clarovideo"
#define k_pushNotificationServer        @"https://push-notifications.nextcloud.com"
#define k_loginButtonLabelLink          @"https://nextcloud.com/providers"
#define k_webLoginAutenticationProtocol @"amx://"

// Capabilities Group
#define k_capabilitiesGroups            @"group.it.twsweb.Clarosync"

/* Define option compiler */

/*
 #define OPTION_DISABLE_INTRO
 #define NO_REQUEST_LOGIN_URL
 #define LOGIN_WEB
 
 #define OPTION_FIREBASE_ENABLE

 #define OPTION_MULTIUSER_DISABLE
 #define OPTION_CRYPTO_CLOUD_SYSTEM_DISABLE
 #define OPTION_AUTOMATIC_UPLOAD_ENABLE
*/

#define OPTION_DISABLE_INTRO
#define LOGIN_WEB

#define OPTION_FIREBASE_ENABLE

#define OPTION_MULTIUSER_DISABLE
#define OPTION_CRYPTO_CLOUD_SYSTEM_DISABLE
#define OPTION_AUTOMATIC_UPLOAD_ENABLE

// -----------------------------------------------------------------------------------------------------------
// COLOR
// -----------------------------------------------------------------------------------------------------------

#define COLOR_BRAND                     [UIColor colorWithRed:30.0/255.0 green:39.0/255.0 blue:81.0/255.0 alpha:1.0]                    // DARK BLUE : #1E2751

#define COLOR_SELECT_BACKGROUND         [UIColor colorWithRed:30.0/255.0 green:39.0/255.0 blue:81.0/255.0 alpha:0.1]                    // DARK BLUE : #1E2751

#define COLOR_TRANSFER_BACKGROUND       [UIColor colorWithRed:178.0/255.0 green:244.0/255.0 blue:258.0/255.0 alpha:0.1]

#define COLOR_GROUPBY_BAR               [UIColor colorWithRed:30.0/255.0 green:39.0/255.0 blue:81.0/255.0 alpha:0.2]                    // DARK BLUE : #1E2751
#define COLOR_GROUPBY_BAR_NO_BLUR       [UIColor colorWithRed:30.0/255.0 green:39.0/255.0 blue:81.0/255.0 alpha:0.3]                    // DARK BLUE : #1E2751

#define COLOR_NAVIGATIONBAR_SHARE       [UIColor colorWithRed:30.0/255.0 green:39.0/255.0 blue:81.0/255.0 alpha:1.0]

#define COLOR_NAVIGATIONBAR             [UIColor colorWithRed:30.0/255.0 green:39.0/255.0 blue:81.0/255.0 alpha:1.0]                    // DARK BLUE : #1E2751
#define COLOR_NAVIGATIONBAR_TEXT        [UIColor whiteColor]
#define COLOR_NAVIGATIONBAR_PROGRESS    [UIColor whiteColor]

#define COLOR_TABBAR                    [UIColor whiteColor]
#define COLOR_TABBAR_TEXT               [UIColor colorWithRed:30.0/255.0 green:39.0/255.0 blue:81.0/255.0 alpha:1.0]                    // DARK BLUE : #1E2751

#define COLOR_BACKGROUND_MENU           [UIColor whiteColor]

#define COLOR_BACKGROUND_PAGECONTROL    [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]
#define COLOR_PAGECONTROL_INDICATOR     [UIColor colorWithRed:30.0/255.0 green:39.0/255.0 blue:81.0/255.0 alpha:1.0]                    // DARK BLUE : #1E2751

#define COLOR_CRYPTOCLOUD               [UIColor colorWithRed:241.0/255.0 green:90.0/255.0 blue:34.0/255.0 alpha:1.0]

#define COLOR_TEXT_ANTHRACITE           [UIColor colorWithRed:65.0/255.0 green:64.0/255.0 blue:66.0/255.0 alpha:1.0]                    // #414042

#define COLOR_TEXT_NO_CONNECTION        [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]

#define COLOR_SEPARATOR_TABLE           [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1.0]                 // iOS 7

#define COLOR_BACKGROUND_MESSAGE_INFO   [UIColor colorWithRed:30.0/255.0 green:39.0/255.0 blue:81.0/255.0 alpha:1.0]                    // DARK BLUE : #1E2751
#define COLOR_CONTROL_CENTER            [UIColor colorWithRed:30.0/255.0 green:39.0/255.0 blue:81.0/255.0 alpha:1.0]                    // DARK BLUE : #1E2751
#define COLOR_REFRESH_CONTROL           [UIColor colorWithRed:30.0/255.0 green:39.0/255.0 blue:81.0/255.0 alpha:1.0]                    // DARK BLUE : #1E2751
#define COLOR_WINDOW_TINTCOLOR          [UIColor colorWithRed:30.0/255.0 green:39.0/255.0 blue:81.0/255.0 alpha:1.0]                    // DARK BLUE : #1E2751

#define COLOR_TABLE_BACKGROUND          [UIColor whiteColor]
