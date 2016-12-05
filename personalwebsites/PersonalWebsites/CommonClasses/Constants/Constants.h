//
//  Constants.h
//  SportInfo
//
//  Created by VectoScalar on 4/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


#endif /* Constants_h */


//Macros to disable logs on prod
#if QAInstance


#define DebugLog(...) NSLog(__VA_ARGS__)

#else

#define DebugLog(...) 

#endif


//Configurable Macros

//Controls the theme of the app19,103,233
#define kNavColor [UIColor colorWithRed:19.0/255.0f green:103.0/255.0f blue:233.0/255.0f alpha:1.0]
#define kInputFieldBGColor  [UIColor colorWithRed:242.0/255.0f green:242.0/255.0f blue:242.0/255.0f alpha:1.0]

#define kMenuSliderHeaderColor kNavColor

//ThirdParySDK Keys
#define kGAKey      @""
#define kFebricKey  @""
#define kEmptyStr   @""


typedef enum typeOfUser
{
     AdminUser,
     GuestUser
}TypeOfUser;


typedef enum selectedPageAction
{
   HomePage = 334,
   PropertyPage,
   IcalPage,
   ContactPage,
   ReviewPage,
   SocialLinkPage
}SelectedPageAction;


//Enum of ICal add/Edit Screen

typedef enum icalPageType
{
   AddIcalProperty,
    EditIcalProperty
}IcalPageType;

typedef enum propertyVCPage{
    AboutPropertyPage = 0,
    PropertyRatesPage,
    PropertyAmenityPage,
    PropertyGalleryPage,
    PropertyCalendarPage
}PropertyVCPage;


//Add Or Edit review
typedef enum reviewPageType
{
    AddReviewPage,
    EditReviewPage
}ReviewPageType;


#define kGMapAPIKey     @"AIzaSyDYixfnMVRd9Incv_skeIEL7N3Oabek24c"
#define kPhoneNumber    @"011-011-011"
#define kSportText      @"sport"

#define kScreenWidth    [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight   [[UIScreen mainScreen] bounds].size.height


//Manage the floating button icon size
#define kFloatingButtonSize 50

#define kFloatingBtnFrame   CGRectMake(kScreenWidth - kFloatingButtonSize - 15, kScreenHeight - kFloatingButtonSize - 15, kFloatingButtonSize, kFloatingButtonSize)

//NSUserDefaults Key Should Lies Here
#define kUserLoginKey   @"isUserLoggedIn"


#define kFontAwesomeFont(x) [UIFont fontWithName:@"FontAwesome" size:x]
#define kFontAwesomeText(x) [NSString fontAwesomeIconStringForIconIdentifier:x]

//Ical Constant
#define kSelectedListItemKey    @"selectedListItem"
#define kIcalHeadingKey         @"icalPropertyHeading"
#define kIcalLinkKey            @"icalPropertyLinkKey"
#define kIcalAddedDateKey       @"icalAddedDateKey"
#define kIcalPropertyIdkey      @"icalPropertyIdKey"

#define kPropertyScreenTitle    @"Property"
#define kAbtPropertyScreenTitle @"About Property"
#define kRatesScreenTitle       @"Rates"
#define kAmenityScreenTitle     @"Amenities"
#define kGalleryScreenTitle     @"Gallery"
#define KCalanderScreenTitle    @"Calendar"

#define kAlertDelBtnTitle       @"Delete"
#define kAlertCancelBtbTitle    @"Cancel"
#define kAlertTitle             @"Delete"
#define kAlertMsg               @"Are you sure, you want to delete this entry?"

//MadelData Entities
#define kIcalLinkEntiry         @"IcalLink"

//To find inner text of uiwebview
#define kDocElementInnerText    @"document.documentElement.innerText"

//To set font-family & font size to webview htmltext.
#define kFontFormatToWebViewText @"<span style=\"font-family:Helvetica; font-size: %i\">%@</span>"

#define kUrlRegEx               @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"

#define kEmailRegEx             @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define kSelfMatchFromat        @"SELF MATCHES %@"








//ThirdParySDK Keys
#define kGAKey @""
#define kFebricKey @""

#define kScreenSize [[UIScreen mainScreen] bounds].size

//Used to identify type of User action in registration
typedef enum typeOfScreen
{
    LoginScreen,
    SignUpScreen
    
    
}TypeOfScreen;

typedef enum typeOfSocialLogin
{
    Google,
    Facebook,
    Info,
    NormalLogin
    
    
}TypeOfSocialLogin;

typedef enum typeOfUserProfileCell
{
    ContactInfo,
    SocialInfo,
    HeaderTitle,
    PrivacyPolicy
}TypeOfUserProfileCell;


typedef enum typeOfUserInfo
{
    Email,
    Phone,
}TypeOfUserInfo;

#define kPrivacyPolicy @"Privacy Policy"

//API resopose code

#define kAPISuccessCode @"200"
#define kAPIErrorCode @"500"
#define kAPILoginErrCode @"401"


//Field Name from server to detect error in field
#define kFieldEmail @"email"
#define kFieldMobile @"mobile"
#define kFieldPassword @"password"
#define kFieldConfirmPassword @"confirmPassword"

//Error MEssages
#define kUnknownError @"Some thing went wrong"



typedef enum voucherType
{
    ActivityVoucher,
    HotelVoucher,
    FlightVoucher,
    TransferVoucher,
    MiscVoucher,
    AdditionalVoucher
    
}VoucherType;

typedef enum typeOfFlightCell
{
    
    SummaryCell,
    FromCell,
    LayOverCell,
    ToCell,
    FistPaxInfoCell,
    SecondPaxInfoCell,
    SupplierDetailCell,
    ETicketCell,
    RedemptionProcedureCell
    
}TypeOfFlightCell;

typedef enum typeOfTransferCell
{
    TransferAddressCell,
    TransferTimingDataCell,
    TransferDetailCell,
    TransferBookingCell,
    TransferSupplierCell,
    TransferRedemptionCell
    
}TypeOfTransferCell;

typedef enum typeOfHotelCell
{
    
    HotelAddressCell,
    HotelPhoneCell,
    HotelDetailCell,
    HotelSummaryTypeCell,
    HotelCustomerCell,
    HotelSupplierCell,
    HotelRedemptionCell
    
}TypeOfHotelCell;

//VoucherScreen Constants
#define kVoucherHeaderHeight 70
#define kExtendedVoucherHeight 85

//Hotel Voucher Constants

#define kHotelVoucherThemeColor [UIColor colorWithRed:255.0/255.0f green:150.0/255.0f blue:0.0/255.0f alpha:1.0]
#define kHotelVoucherFooterColor [UIColor colorWithRed:255.0/255.0f green:244.0/255.0f blue:229.0/255.0f alpha:1.0]


#define kFlightVoucherThemeColor [UIColor colorWithRed:74.0/255.0f green:99.0/255.0f blue:226.0/255.0f alpha:1.0]
#define kFlightVoucherFooterColor [UIColor colorWithRed:237.0/255.0f green:240.0/255.0f blue:253.0/255.0f alpha:1.0]



#define kActivityVoucherThemeColor [UIColor colorWithRed:137.0/255.0f green:113.0/255.0f blue:213.0/255.0f alpha:1.0]
#define kActivityVoucherFooterColor [UIColor colorWithRed:238.0/255.0f green:233.0/255.0f blue:253.0/255.0f alpha:1.0]


#define kHotelSepartaorColor [UIColor colorWithRed:255.0/255.0f green:244.0/255.0f blue:229.0/255.0f alpha:1.0]

#define kActivitySepartaorColor [UIColor colorWithRed:238.0/255.0f green:233.0/255.0f blue:253.0/255.0f alpha:1.0]

#define kCommonSepartaorColor [UIColor colorWithRed:237.0/255.0f green:240.0/255.0f blue:253.0/255.0f alpha:1.0]




#define kFontSize10 10
#define kFontSize11 11
#define kFontSize12 12
#define kFontSize13 13
#define kFontSize14 14
#define kFontSize15 15
#define kFontSize16 16
#define kFontSize17 17
#define kFontSize18 18
#define kFontSize19 19
#define kFontSize20 20
#define kFontSize21 21
#define kFontSize22 22


//Table View Cells Name

//Hotel Cells Name
#define kHotelSummaryCell @"HotelSummaryCell"
#define kHotelDurationCell @"HotelDurationCell"
#define kHotelCustDetailsCell @"HotelCustDetails"

//Activity Cells name
#define kActivitySummary @"ActivitySummaryCell"
#define kActivityDurationCell @"ActivityDurationCell"
#define kActivityCustInfoCell @"ActivityCustInfoCell"

//Flight Cells Name
#define kFlightHeaderCell @"FlightHeaderCell"
#define kFlightDetailCell @"FlightDetailCell"
#define kFlightDurationCell @"FlightDurationCell"
#define kFlightPaxCell @"FlightPaxInfoCell"


//CommonCells
#define kBookingInfoCell @"BookingInfoCell"

#define kTransferCategory @"AIRPORT_PICKUP"
#define kTransferRoute @"Airport to Hotel Transfer"
#define kThingsToDo @"THINGS.TO.DO"


//Colors
#define kNavbarColor [UIColor colorWithRed:87.0/255.0f green:92.0/255.0f blue:172.0/255.0f alpha:1.0]


//Chat Constants

#define kChatId @"GoFroOneToOneChat"
#define kTimeStamp [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000]


typedef enum {
    ConnectionStatusUnknown,
    ConnectionStatusConnected,
    ConnectionStatusDisconnected,
    ConnectionStatusFailure
} ConnectionStatus;


typedef enum {
    PresenceStatusUnknown,
    PresenceStatusIdle,
    PresenceStatusOffline,
    PresenceStatusOnline
} PresenceStatus;


//typedef NS_ENUM(NSInteger, MessageStatus)
//{
//    MessageStatusSending,
//    MessageStatusSent,
//    MessageStatusReceived,
//    MessageStatusRead,
//    MessageStatusFailed,
//    MessageStatusOnline,
//    MessageStatusOffline,
//    MessageStatusUserLeft
//};
//
//typedef NS_ENUM(NSInteger, MessageSender)
//{
//    MessageSenderMyself,
//    MessageSenderSomeone,
//    MessageSenderBot
//};

#define kTimeOutForChat 60
#define kReconnectInterval 5
#define kChatSoundPath @"/System/Library/Audio/UISounds/Modern/sms_alert_note.caf"


#define kChatConnectionErrorMessage @"Unable to connect to chat server."
#define kNoInternetMessage @"No active internet connection is available."

#define kLastTimeForUpdateCheck @"LastTimeToCheckUpdateVersion"
#define kNeedToUpdateApp @"UserNeedToUpdateApp"
#define kMinimumSupportedVersion @"1.0.1"

#define kUnreadCountKey @"NumberOfUnreadMessages"


#define kNotificaionForUnreadCount @"MessageReceivedInInactiveState"


#define kOrderKey @"orderCode"
#define kTripTitleKey @"TripsTitle"

#define kDeliveredColor [UIColor colorWithRed:52.0/255.0f green:188.0/255.0f blue:77.0/255.0f alpha:1.0]
#define kFailedColor [UIColor colorWithRed:213.0/255.0f green:0.0/255.0f blue:0.0/0.0f alpha:1.0]
#define kSentColor [UIColor colorWithRed:169.0/255.0f green:169.0/255.0f blue:0.0/169.0f alpha:1.0]
#define kSendingColor [UIColor colorWithRed:59.0/255.0f green:89.0/255.0f blue:0.0/152.0f alpha:1.0]


#define kactivityDate @"activityDate"
#define kPickupPoint @"PickupPoint"
#define kPickupTime @"PickupTime"
#define kCheckInTime @"checkInTime"
#define kCheckOutTime @"checkOutTime"
#define kHotelName @"HotelName"
#define kComponentType @"componentType"
#define kDayIndex @"DayIndex"
#define kComponentId @"componentId"
#define kActivityStartTime @"ActivityStartTime"
#define kEventOccuringDate @"EventDate"
#define kActivityName @"activityName"

#define kExpertOnline @"Destination Expert is online";
#define kExpertOffline @"Destination Expert is offline";
#define kUserOffline @"You left the chat"


#define kNAText @"N/A"


//--------------------------------------------Core data error handler
#define FT_SAVE_MOC(_ft_moc) \
do { \
NSError* _ft_save_error; \
if(![_ft_moc save:&_ft_save_error]) { \
NSLog(@"Failed to save to data store: %@", [_ft_save_error localizedDescription]); \
NSArray* _ft_detailedErrors = [[_ft_save_error userInfo] objectForKey:NSDetailedErrorsKey]; \
if(_ft_detailedErrors != nil && [_ft_detailedErrors count] > 0) { \
for(NSError* _ft_detailedError in _ft_detailedErrors) { \
NSLog(@"DetailedError: %@", [_ft_detailedError userInfo]); \
} \
} \
else { \
NSLog(@"%@", [_ft_save_error userInfo]); \
} \
} \
} while(0);
//--------------------------------------------


#define kAthTheRateImage @"atTheRate.png"
#define kCallImage @"CallUserProfile.png"


//constants for Chat Logs Levels

typedef enum {
    ALL,
    // DEBUG,
    INFO,
    ERROR,
    WARNING
    
}LogLevel;


#define kLogLevelAll @"ALL"
#define kLogLevelDebug @"DEBUG"
#define kLogLevelInfo @"INFO"
#define kLogLevelError @"ERROR"
#define kLogLevelWarning @"WARNING"

//Parameters key used in Chat Log API
#define kChatLogMessageKey @"message"
#define kChatLogModuleKey @"module"
#define kChatLogLevelKey  @"logLevel"
#define kChatLogDataKey  @"logData"


#define kChatLogMessage @"chat events"
#define kChatLogModule @"chat"

#define kCacheTimeLimit 60*60

#define kConfigAPIChatURLKey @"ConfigAPIChatURLKey"
#define kConfigAPIChatIDForConnectionKey @"ConfigAPIChatIDForConnectionKey"
#define kConfigAPIChatWorkgroupKey @"ConfigAPIChatWorkgroupKey"
#define kVoucherNotificationReceivedLocalKey @"VoucherNotificationReceivedLocalKey"

#define kItineraryTitle  @"ITINERARY"

