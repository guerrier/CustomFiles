#CustomFiles

INSTRUCTIONS FOR iOS Clarosync distribution V 1.3 - 17 April 2017

Clone or download the Nextcloud iOS app 

https://github.com/nextcloud/ios

Add on $(SRCROOT) :

Clarosync.xcodeproj 				Project Xcode Version 8.3 (8E162)

DevicePushKey-Info.plist			Plist content Keys "devicePublicKeyDevelopment" & "devicePublicKeyProduction" for Push Notification
GoogleService-Info.plist			Plist for Google Firebase (Statistic & Push Notification)

Note : this plist now are setup for it.twsweb.Nextcloud 

Add on $(SRCROOT)/Custom/Clarosync :

Constant.swift					Content Color constants for swift code
Custom.xcassets					Content image, logo etc. of Clarosync
CustomConstant.h				See below
CustomImages.h					Content constant name for images 
CustomSwift.h					Bridge Objc-Swift code : do not change it
CustomSwiftShare.h				Bridge Objc-Swift code : do not change it
iOSClient.entitlements				Now setup for : iCloud, Group : group.it.twsweb.Clarosync, Keychain : it.twsweb.Clarosync 
iOSClient.plist
LaunchScreenClarosync.xib			Launch Screen for Clarosync	
Picker.entitlements				Now setup for : Group : group.it.twsweb.Clarosync, Keychain : it.twsweb.Clarosync 
Picker.plist
PickerFileProvider.entitlements			Now setup for : Group : group.it.twsweb.Clarosync, Keychain : it.twsweb.Clarosync
PickerFileProvider.plist			Now setup for : Group : group.it.twsweb.Clarosync
Share.entitlements				Now setup for : Group : group.it.twsweb.Clarosync, Keychain : it.twsweb.Clarosync
Share.plist

-- CCConstant.h --

#define k_brand                         @"ClaroSync"						- Name of product
#define k_mailMe                        @"info@clarosync.com"					- Address mail for request information (see settings)
#define k_textCopyright                 @"ClaroSync %@ © 2017 T.W.S. Inc."			- Copyright (see settings)
#define k_loginBaseUrl                  @"https://skylake.weasel.rocks/c/mexico/clarovideo"	- Address html page for login 
#define k_pushNotificationServer        @"https://push-notifications.nextcloud.com"		- Push Notification Server address
#define k_loginButtonLabelLink          @"https://nextcloud.com/providers"			- Only used on Nextcloud provider select
#define k_webLoginAutenticationProtocol @"amx://"						- Protocol for authentication via web page html

// Capabilities Group
#define k_capabilitiesGroups            @"group.it.twsweb.Clarosync"				- Change it if change the group on entitlements

Option Compiler

#define OPTION_DISABLE_INTRO			Use this #define for disabling the normal Intro of Nextcloud standard
#define NO_REQUEST_LOGIN_URL			Use this #define for remove field Server address on Nextcloud standard (when #define used k_loginBaseUrl for login server) 
#define LOGIN_WEB				Use this #define for login via Web protocol (when #define used k_loginBaseUrl and k_webLoginAutenticationProtocol)
 
#define OPTION_FIREBASE_ENABLE			Use this #define for enabled service Firebase

#define OPTION_MULTIUSER_DISABLE		Use this #define for remove option multiuser on Settings
#define OPTION_CRYPTO_CLOUD_SYSTEM_DISABLE	Use this #define for remove option Crypto Cloud System on Settings
#define OPTION_AUTOMATIC_UPLOAD_ENABLE		Use this #define for enabled Automatic Upload on Settings

Following the Color constants for objc code

--- Build ---

Open Clarosync.xcodeproj and build for internal use (emulator and device connect on Mac) for TestFlight or Production change all file :

DevicePushKey-Info.plist
GoogleService-Info.plist
.entitlements
.plist
CCConstant.h



