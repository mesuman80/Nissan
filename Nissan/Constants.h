//
//  Constants.h
//  Nudger
//
//  Created by Komal Sharma on 06/07/16.
//  Copyright © 2016 Komal. All rights reserved.
//

#ifndef Nudger_Constants_h
#define Nudger_Constants_h

//Color Codes
#define WhiteColor @"ffffff"
#define BASELIGHT @"BCC8D7"
#define BASEDARK @"416c80"
#define REVERSE_DARK @"0066cc"
#define REVERSE_LIGHT @"213640"
#define DARK_GREY @"999999"
#define LIGHT_GREY @"cccccc"
#define TableColor @"ffffff"
//#define TableTextColor @"424242"
#define GOLDEN @"0066cc"
#define viewCornerRadius 10
#define ColorAlphaVal 0.70
#define ReceiverColorAlphaVal 0.80

#define CANCEL_TIMER 3

#define screenHeight [[UIScreen mainScreen]bounds].size.height
#define screenWidth  [[UIScreen mainScreen]bounds].size.width

#define titleFont          @"HelveticaNeue-Roman"
#define subTitleFont       @"HelveticaNeue-Light"
#define buttonBackgroundColor [UIColor colorWithRed:0 green:155.0f/255 blue:187.0f/255 alpha:1]
#define mapGeofenceColor [UIColor colorWithRed:250.0f/255 green:220.0f/255 blue:220.0f/255 alpha:1.0]
#define TableTextColor [UIColor colorWithRed:66.0f/255 green:66.0f/255 blue:66.0f/255 alpha:1.0]

#pragma Map variables
#define kLatitudinalMeters 1000.0 //1km
#define kLongitudinalMeters 1000.0 //1km
#define kRefreshTime 10.0

#define MAXLENGTH 3
#define CRITERIA_CATEGORY 1
#define CRITERIA_LOCATION 2
#define CRITERIA_NUDGE_MESSAGE 3

#define GoogleiOSPlacesKey   @"AIzaSyBb1oJRrBY_O_9qpVs3yjppitudZtSio2M"
#define GoogleiOSMapKeyScheme @"AIzaSyBDavXsSPaDZyfcKS9l6TFYVYm6i8sZ4R8"

//PlaceHolder Strings
#define PlaceholderTitleString  @" Title"

//Alerts
#define ApplicationInternetConnectionErrorMessage   @"Please check your internet connection."


//Networking
#define kN_BaseURL                       @"kN_BaseURL"
#define kN_BaseIP                        @"kN_BaseIP"

//Nudger Chat User Registration
#define kN_ChatBaseIP                     @"kN_ChatBaseIP"
#define kN_ChatBaseURL                    @"kN_ChatBaseURL"
#define kN_Host                           @"Host"
#define kN_ServerDomain                   @"ServerDomain"

#define NudgerSQLFile                      @"Nudger.sqlite"
#define NudgerAllNumber                    @"AllNumbers"
#define NudgerDriversNumber                @"NudgerNumber"

//Webservices URL
#define W_UserSignup                       @"signup"
#define W_UserVerify                       @"verifyMobile"
#define W_UserResendVerification           @"resendVerificationCode"
#define W_UserUpdate                       @"updateUser"
#define W_GetUserById                      @"user/"
#define W_GetUsers                         @"users"
#define W_GetAllCategories                 @"categories"


//Chat core Data entity Name
#define ReadStatusNotification  @"ReadNotification"
#define ConversationDataEntity @"ConversationData"
#define MessageDataEntity @"MessageData"
#define SwoopAppendId @"Recv"

//Message Type Keys
#define TTMMessageTypeText @"1"
#define TTMMessageTypeImage @"2"
#define TTMMessageTypeAudio @"6"
#define TTMMessageTypeVideo @"3"

//Registration Key Values
#define kN_DeviceToken                     @"DeviceToken"
#define kN_UserData                        @"kN_UserData"
#define kN_isUserMobileRegistered          @"kN_isUserMobileRegistered"
#define kN_isNewNudgeSkiped                @"kN_isNewNudgeSkiped"

//User Key Values
#define kIphoneDeviceType                 @"0"//For iPhone
#define U_UserID                          @"userId"
#define U_UserName                        @"userName"
#define U_FirstName                       @"firstName"
#define U_LastName                        @"lastName"
#define U_PhoneNumber                     @"phoneNumber"
#define U_IsVerifiedPhoneNumber           @"isVerifiedPhoneNumber"
#define U_Latitude                        @"latitude"
#define U_Longitude                       @"longitude"
#define U_Image                           @"image"
#define U_Token                           @"token"
#define U_VerificationCode                @"verificationCode"
#define U_DeviceType                      @"deviceType"
#define U_DeviceToken                     @"deviceToken"
#define U_TimeZone                        @"timeZone"
#define U_IsActive                        @"isActive"
#define U_CreatedOn                       @"createdOn"
#define U_ModifiedOn                      @"modifiedOn"
#define U_CountryCode                     @"cc"
#define U_PhoneNumberWithCC               @"PhoneNumberWithCC"
#define U_Password                        @"password"


//Category Key values
#define CategoryIcon                      @"categoryIcon"
#define CategoryId                        @"categoryId"
#define CategoryName                      @"categoryName"



typedef enum {
    SliderMenuHome          = 1,
    SliderMenuMyProfile     = 2,
    SliderMenuMessages      = 3,
    SliderMenuMyRequests    = 4,
    SliderMenuMyDeliveries  = 5,
    SliderMenuPayment       = 6,
    SliderMenuInvite        = 7,
    SliderMenuLogout        = 8
}SliderMenuItems;

typedef enum {
    TypeNone          = 0,
    TypeProfilePic    = 1,
    TypeAudio         = 2,
    TypeText          = 3,
    TypeImage         = 4,
    TypeVideo         = 5,
    TypeDisplayImage  = 6
} TextViewType;

#endif


