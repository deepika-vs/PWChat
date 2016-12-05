//
//  Utility.h
//  SportInfo
//
//  Created by VectoScalar on 4/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "NavigationSubRows.h"
#import "NavigationWrapper.h"

@interface Utility : NSObject

//==========Validator methods.===========//
//To Check null or empty string
+ (BOOL)isEmptyOrNilForString:(NSString *)inputString;

+ (BOOL)isNumericValue:(NSString *)stringValue;

+ (BOOL)isVaildEmail:(NSString*)email;

+ (BOOL) validateUrl: (NSString *)urlString;

+ (BOOL) isValidPhoneNumber:(NSString *)phoneNumberString;

+ (BOOL) isStringDecimalNumber:(NSString *)stringValue;


+ (NSString *)getUUID;

+ (void)showProgressViewOnView:(UIView*)view;

+ (void)hideProgressViewOnView:(UIView*)view;

+ (void)makeACallWithPhoneNumber:(NSString*)mobileNumber;

+ (NSString *)getJSONStringFromDictionary:(NSDictionary *)dict;

+ (NSString*)trimWhiteSpacesAndNewLinesFromString:(NSString*)string;

//Get inner plan text of uiwebview.
+ (NSString *) getPlanTextFromHTMLText:(UIWebView *) webview;

+ (NSString *) setWebViewHTMLTextFont:(NSString *) HTMLText;

+ (NSDate *)createDateWithDay:(NSInteger) day andMonth: (NSInteger) month andYear:(NSInteger) year;

+ (NSComparisonResult) compareTwoDate:(NSDate *) date with: (NSDate *) todate;

//+ (BOOL)isConnectedToInternet;


+ (CGSize)getTheSizeForText:(NSString *)text andFont:(UIFont*)font toFitInWidth:(CGFloat)width;

+ (CGSize)getTheSizeForTextFixedHeight:(NSString *)text andFont:(UIFont*)font toFitInHeight:(CGFloat)height;


//Set button title, bgcolor with font awesome.
+ (void) addFAUIOnButton:(UIButton *) button andFATitle:(NSString *) title andColor:(UIColor*) color andFont:(NSUInteger) size;

+ (UINavigationController *)setTransparentNavBar:(UINavigationController *)navCtrl;

+ (NSArray*)getNavigationMenuForAdmin;

+ (NSArray*)getNavigationMenuForGuest;

+ (void)changePlaceholderTextColor:(UITextField *)textField withColor:(UIColor*)color containsPlaceholderText:(NSString*)placeholderText;

+ (void)makeRoundedBorderOnView:(UIView*)view;

+ (void)addShadowToView:(UIView*)view;

+ (void)addShadowToFloatingButton:(UIButton *) sender;

+ (void)showAlerWithMgs:(NSString *)message;

+ (UIImage *)resizeImgWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (void)showAlerWithMessage:(NSString *)message onViewController:(UIViewController*)viewController;

+ (NSString *)prepareDateComponent:(NSInteger)dateComponent;

// the difference between two dates
+(NSString*)remaningTime:(NSDate*)startDate endDate:(NSDate*)endDate;
+ (void)hideProgressView;
+ (void)showProgressView;
//get date from milisecs
+ (NSString *)getDateStrFromDate:(NSDate *)date;

//To Show alert Controller
+ (void)showAlerWithMessage:(NSString *)message;

+ (void)showHudOnView:(UIView*)view;
+ (void)hideHudFromView:(UIView*)view;

+(NSString *)getImgURLOfSizeStr:(NSString *)sizeStr andImgURL:(NSString *)imgLink;
//TO Get the size of text


+ (NSString *)getTimeByTimestamp:(NSString*)timestampString;

+ (NSString *)getDateTimestamp:(NSString*)timestampString;

+(NSString *)getDateStrFrom:(double)dd;


+ (BOOL)isConnectedToInternet;
+ (BOOL)isNetworkConnectionLost;

+ (void)playNotification;
+ (void)scheduleLocalNotificationForChat:(NSString*)message;
+ (NSString *)getTimeInTwelveHourFormatWithTimeStamp:(NSString*)timestampString;
+(NSAttributedString *)getAttributedStrFrom:(NSString *)str1 andString2:(NSString *)str2;

+ (void)setStatusBarColor;

@end
