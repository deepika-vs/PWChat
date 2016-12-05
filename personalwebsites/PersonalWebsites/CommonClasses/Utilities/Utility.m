//
//  Utility.m
//  SportInfo
//
//  Created by VectoScalar on 4/11/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "Utility.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation Utility

+ (void)showProgressViewOnView:(UIView*)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"Loading";
    [hud showAnimated:YES];
}



+ (void)hideProgressViewOnView:(UIView*)view{
    
    [MBProgressHUD hideHUDForView:view animated:YES];
}



//Get JSON from Dictionary

+ (NSString *)getJSONStringFromDictionary:(NSDictionary *)dict
{
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
}


//Remove White Spaces and new line  for String
+ (NSString*)trimWhiteSpacesAndNewLinesFromString:(NSString*)string
{
    NSString* newString =  [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return newString;
}



+ (void)showAlerWithMessage:(NSString *)message onViewController:(UIViewController*)viewController{
    
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:kEmptyStr message:message  preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}



+(UINavigationController *)setTransparentNavBar:(UINavigationController *)navCtrl{
    navCtrl.navigationBar.barStyle=UIBarStyleDefault;
    
    
    [navCtrl.navigationBar setBackgroundImage:[UIImage new]
                                forBarMetrics:UIBarMetricsDefault];
    navCtrl.navigationBar.shadowImage = [UIImage new];
    navCtrl.navigationBar.translucent = YES;
    navCtrl.view.backgroundColor = [UIColor clearColor];
    return navCtrl;
}



+ (CGSize)getTheSizeForText:(NSString *)text andFont:(UIFont*)font toFitInWidth:(CGFloat)width
{
    
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(width, 999)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    
    return textRect.size;
}



+ (CGSize)getTheSizeForTextFixedHeight:(NSString *)text andFont:(UIFont*)font toFitInHeight:(CGFloat)height
{
    
    CGSize textRect = [text sizeWithAttributes:
                       @{NSFontAttributeName: font}];
    // Values are fractional -- you should take the ceilf to get equivalent values
    CGSize adjustedSize = CGSizeMake(ceilf(textRect.width), height);
    
    return adjustedSize;
}


+ (NSString *)getUUID{
    
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}



//+ (BOOL)isConnectedToInternet
//{
//    BOOL status;
//    NSString *hostName = [[NSURL URLWithString:@"http://www.google.com"] host];
//    Reachability *r = [Reachability reachabilityWithHostName:hostName];
//    if(NotReachable == [r currentReachabilityStatus]) {
//
//        //TODO: put correct message.
//
//        status =  NO;
//
//    }
//    else{
//        status=  YES;
//    }
//    return status;
//}



+ (void)showAlerWithMgs:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kEmptyStr message:message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];
}



+ (void)setStatusBarColor
{
    //  UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    // if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
    //  statusBar.backgroundColor = kNavbarColor;
    //   statusBar.alpha = 1.0f;
    // }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    // view.backgroundColor = kNavbarColor;
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
}


+ (void)clearStatusBarColor
{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        // statusBar.backgroundColor = kNavbarColor;
        
    }
}



+ (void)makeACallWithPhoneNumber:(NSString*)mobileNumber
{
    DebugLog(@"Phone calling...");
    
    UIDevice *device = [UIDevice currentDevice];
    
    
    if ([[device model] isEqualToString:@"iPhone"] ) {
        
        NSString *phoneNumber = [@"telprompt://" stringByAppendingString:mobileNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
        
    } else {
        
        UIAlertView *warning =[[UIAlertView alloc] initWithTitle:@"Note" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [warning show];
    }
}



+ (NSArray*)getNavigationMenuForAdmin
{
    
    NSMutableArray *sectionArray = [[NSMutableArray alloc] init];
    
    //Dashboard
    NavigationWrapper *dashboard = [[NavigationWrapper alloc] init];
    dashboard.title = @"Dashboard";
    dashboard.iconName = kDashboardFA;
    dashboard.isOpen = NO;
    dashboard.rows = nil;
    [sectionArray addObject:dashboard]; //First Item
    
    //Dashboard
    NavigationWrapper *editPage = [[NavigationWrapper alloc] init];
    editPage.title = @"Update Conent";
    editPage.iconName = kUpdateContentFA;
    editPage.isOpen = NO;
    
    //Make Sub Menus
    NavigationSubRows *home = [[NavigationSubRows alloc] init];
    home.title = @"Home";
    home.iconName = kHomeFA;
    
    ////Property
    NavigationSubRows *property = [[NavigationSubRows alloc] init];
    property.title = kPropertyScreenTitle;
    property.iconName = kPropertyFA;
    
    ////Ical Link
    NavigationSubRows *ical = [[NavigationSubRows alloc] init];
    ical.title = @"Ical Link";
    ical.iconName = kICalFA;
    
    ////Contact
    NavigationSubRows *contact = [[NavigationSubRows alloc] init];
    contact.title = @"Contact";
    contact.iconName = @"contact";
    
    ////reviews
    NavigationSubRows *reviews = [[NavigationSubRows alloc] init];
    reviews.title = @"Reviews";
    reviews.iconName = kReviewFA;
    
    ////reviews
    NavigationSubRows *socialLinks = [[NavigationSubRows alloc] init];
    socialLinks.title = @"Soical Links";
    socialLinks.iconName = kSocialLinkFA;
    
    NSArray <NavigationSubRows*> *subMenus = [NSArray arrayWithObjects:home,property,ical,contact,reviews,socialLinks, nil];
    
    
    editPage.rows = subMenus;
    [sectionArray addObject:editPage]; //Second Item
    
    
    //Contact US
    NavigationWrapper *contactUS = [[NavigationWrapper alloc] init];
    
    contactUS.title = @"Contact us";
    contactUS.isOpen = NO;
    contactUS.iconName = kContactUsFA;
    
    NavigationSubRows *call = [[NavigationSubRows alloc] init];
    call.title = @"Call us";
    call.iconName =  kFloatingCallIcon;
    NavigationSubRows *mail = [[NavigationSubRows alloc] init];
    mail.title = @"Mail us";
    mail.iconName = kMailFA;
    NavigationSubRows *caht = [[NavigationSubRows alloc] init];
    caht.title = @"Chat";
    caht.iconName = kChatFA;
    NSArray <NavigationSubRows*> *subMenu = [NSArray arrayWithObjects:call,mail,caht, nil];
    
    contactUS.rows = subMenu;
    [sectionArray addObject:contactUS]; // Third Item
    
    //LogOut
    NavigationWrapper *logout = [[NavigationWrapper alloc] init];
    
    logout.title = @"Logout";
    logout.isOpen = NO;
    logout.iconName = kLogoutFA;
    [sectionArray addObject:logout];
    
    return sectionArray;
}


+ (NSArray *)getNavigationMenuForGuest
{
    NSMutableArray *sectionArray = [[NSMutableArray alloc] init];
    
    //Home
    NavigationWrapper *home = [[NavigationWrapper alloc] init];
    home.title = @"Home";
    home.iconName = kHomeFA;
    home.isOpen = NO;
    home.rows = nil;
    [sectionArray addObject:home]; //First Item
    
    //Login
    NavigationWrapper *login = [[NavigationWrapper alloc] init];
    login.title = @"Login";
    login.iconName = kLogoutFA;
    login.isOpen = NO;
    login.rows = nil;
    [sectionArray addObject:login]; //First Item
    
    return sectionArray;
}


+ (void)changePlaceholderTextColor:(UITextField *)textField withColor:(UIColor*)color containsPlaceholderText:(NSString*)placeholderText
{
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderText attributes:@{NSForegroundColorAttributeName: color}];
}


+ (void)makeRoundedBorderOnView:(UIView*)view
{
    view.layer.cornerRadius = 4.0f;
    view.backgroundColor = kInputFieldBGColor;
}


+ (void)addShadowToView:(UIView*)view
{
    [view.layer setShadowColor:[UIColor grayColor].CGColor];
    [view.layer setShadowOpacity:0.6];
    [view.layer setShadowRadius:3.0];
    [view.layer setShadowOffset:CGSizeMake(0.0, 1.0)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 3.0;
}


//Add button with font awesome.
+ (void) addFAUIOnButton:(UIButton *) button andFATitle:(NSString *) title andColor:(UIColor*) color andFont:(NSUInteger) size {
    button.titleLabel.font = kFontAwesomeFont(size);
    [button setTitle:kFontAwesomeText(title) forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
}



+ (UIImage *)resizeImgWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //here is the scaled image which has been changed to the size specified
    UIGraphicsEndImageContext();
    return newImage;
}


+ (BOOL)isEmptyOrNilForString:(NSString *)inputString
{
    if(inputString == nil || ![inputString isKindOfClass:[NSString class]])
    {
        return true;
    }
    
    BOOL isEmptyOrNil = NO;
    
    if(inputString == nil || [[inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:kEmptyStr])
    {
        isEmptyOrNil = YES;
    }
    
    return isEmptyOrNil;
}



+ (BOOL)isNumericValue:(NSString *)stringValue {
    NSString *phoneRegex = @"\\d";
    
    if(stringValue.length>1)
        phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:kSelfMatchFromat, phoneRegex];
    
    BOOL isNumeric = [phoneTest evaluateWithObject:stringValue];
    return isNumeric;
}



+ (BOOL) isValidPhoneNumber:(NSString *) phoneNumberString{
    NSString *phoneRegex = @"[0-9][0-9]{6}([0-9]{3})?";
    NSPredicate *phoneNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL isValid = [phoneNumber evaluateWithObject:phoneNumberString];
    
    return isValid;
}


+ (BOOL)isVaildEmail:(NSString*)email
{
    NSString *emailRegex = kEmailRegEx;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:kSelfMatchFromat, emailRegex];
    return [emailTest evaluateWithObject:email];
}



+ (BOOL) validateUrl: (NSString *) urlString {
    NSString *urlRegEx = kUrlRegEx;
    
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:kSelfMatchFromat, urlRegEx];
    return [urlTest evaluateWithObject:urlString];
}


+ (NSString *) getPlanTextFromHTMLText:(UIWebView *) webview{
    NSString *plainText = [webview stringByEvaluatingJavaScriptFromString:kDocElementInnerText];
    
    return plainText;
}



+ (NSString *) setWebViewHTMLTextFont:(NSString *) HTMLText{
    UIFont *font = [UIFont systemFontOfSize:14];
    
    NSString *htmlString = [NSString stringWithFormat:kFontFormatToWebViewText,
                            (int) font.pointSize,
                            HTMLText];
    
    return htmlString;
}


//Validate id string decimal format.
+ (BOOL) isStringDecimalNumber:(NSString *) stringValue{
    
    bool result = false;
    
    NSString *decimalRegex = @"^(?:|-)(?:|0|[1-9]\\d*)(?:\\.\\d*)?$";
    NSPredicate *regexPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    
    if ([regexPredicate evaluateWithObject: stringValue]){
        //Matches
        result = true;
    }
    
    return result;
}



+ (NSDate *)createDateWithDay:(NSInteger) day andMonth: (NSInteger) month andYear:(NSInteger) year{
    
    if(day == 0 || month == 0){
        return nil;
    }
    
    //Create a new date with components.
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    
    [comp setDay:day];
    [comp setMonth:month];
    [comp setYear:year];
    [comp setHour:12];
    [comp setMinute:0];
    [comp setSecond:0];
    
    //NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    return date;
}



+ (NSComparisonResult) compareTwoDate:(NSDate *) date with: (NSDate *) todate{
    NSDateComponents *compo = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    NSDateComponents *toCompo = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:todate];
    
    
    NSString *sDateDay = [Utility prepareDateComponent: [compo day]];
    
    NSString *sDateMonth = [Utility prepareDateComponent: [compo month]];
    
    NSString *toDay = [Utility prepareDateComponent:[toCompo day]];
    
    NSString *toMonth = [Utility prepareDateComponent: [toCompo month]];
    
    
    NSString *dateStr = [NSString stringWithFormat:@"%d%@%@", [compo year], sDateMonth, sDateDay];
    
    NSString *toDateStr = [NSString stringWithFormat:@"%d%@%@", [toCompo year], toMonth, toDay];

    NSComparisonResult result = [dateStr compare:toDateStr];
    return result;
}


+ (NSString *)prepareDateComponent:(NSInteger)dateComponent{
    
    NSString *strValue;
    
    if(dateComponent < 10){
        strValue = [NSString stringWithFormat:@"0%d", dateComponent];
        return strValue;
    }
    
    return [NSString stringWithFormat:@"%d", dateComponent];
}


+ (void) addShadowToFloatingButton:(UIButton *) sender{
    sender.layer.cornerRadius = sender.frame.size.height/2;
    //Add shadow
    sender.layer.shadowColor = [[UIColor blackColor] CGColor];
    sender.layer.shadowOffset = CGSizeMake(0, 2.0f);
    sender.layer.shadowOpacity = 0.6f;
    sender.layer.shadowRadius = 3.0f;
    sender.layer.masksToBounds = NO;
}


//get date from milisecs
+ (NSString *)getDateStrFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"EEE, dd MMMM yyyy, HH:mm";
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

// the difference between two dates
+(NSString*)remaningTime:(NSDate*)startDate endDate:(NSDate*)endDate{
    
    NSString *durationString=@"";
    
    BOOL past = NO;
    if([startDate compare:endDate] == NSOrderedDescending){
        //Past
        NSDate *tempDate = startDate;
        startDate = endDate;
        endDate = tempDate;
        past = YES;
    }
    else{
        //Future/current
    }
    
    NSDateComponents *components;
    NSInteger days;
    NSInteger hour;
    NSInteger minutes;
    
    components = [[NSCalendar currentCalendar] components: NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate: startDate toDate: endDate options: 0];
    days = [components day];
    hour=[components hour];
    minutes=[components minute];
    
    if(days>0){
        durationString=[NSString stringWithFormat:@"%ld days",(long)days];
    }
    
    if(hour>0){
        durationString=[NSString stringWithFormat:@"%@ %ld hrs",durationString,(long)hour];
    }
    
    if(minutes>0){
        durationString=[NSString stringWithFormat:@"%@ %ld mins",durationString,(long)minutes];
    }
    if (past) {
        durationString = [NSString stringWithFormat:@"%@ ago",durationString];
    }
    return durationString;
}




+ (void)showHudOnView:(UIView*)view
{
    // [MBProgressHUD showHUDAddedTo:view animated:YES];
}


+(void)hideHudFromView:(UIView *)view
{
    // [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (NSString *)getTimeByTimestamp:(NSString*)timestampString
{
    double timestamp = [timestampString doubleValue]/1000;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSString *dateNmonth =  [[dateFormatter stringFromDate:date]uppercaseString];
    
    return dateNmonth;
}


+ (NSString *)getTimeInTwelveHourFormatWithTimeStamp:(NSString*)timestampString
{
    double timestamp = [timestampString doubleValue]/1000;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    
    [dateFormatter setDateFormat:@"hh:mm a"];
    
    NSString *dateNmonth =  [[dateFormatter stringFromDate:date]uppercaseString];
    
    return dateNmonth;
}


+ (NSString *)getDateTimestamp:(NSString*)timestampString
{
    double timestamp = [timestampString doubleValue];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    
    [dateFormatter setDateFormat:@"EEE, dd MMM"];
    
    NSString *dateNmonth =  [[dateFormatter stringFromDate:date]uppercaseString];
    
    return dateNmonth;
}

+(NSString *)getDateStrFrom:(double)dd{
    NSString *dateStr;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dd/1000.0];
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"dd MMM, YY"]; // Date formater
    
    dateStr = [dateformate stringFromDate:date];
    
    return dateStr;
}

+(NSString *)getImgURLOfSizeStr:(NSString *)sizeStr andImgURL:(NSString *)imgLink{
    //    imgLink = [NSString stringWithFormat:@"%@%@",kImageUrl,imgLink];
    //    NSArray *strArr;
    //    NSString *formatStr;
    //    if ([imgLink containsString:@".png"]) {
    //        strArr = [imgLink componentsSeparatedByString:@".png"];
    //        formatStr = @".png";
    //    }
    //    if ([imgLink containsString:@".jpg"]) {
    //        strArr = [imgLink componentsSeparatedByString:@".jpg"];
    //        formatStr = @".jpg";
    //    }
    //    if ([imgLink containsString:@".jpeg"]) {
    //        strArr = [imgLink componentsSeparatedByString:@".jpeg"];
    //        formatStr = @".jpeg";
    //    }
    //    NSString *firstPartStr = [strArr firstObject];
    //    firstPartStr = [NSString stringWithFormat:@"%@%@",firstPartStr,sizeStr];
    //    imgLink = [NSString stringWithFormat:@"%@%@",firstPartStr,formatStr];
    return imgLink;
}


+ (BOOL)isConnectedToInternet
{
    BOOL status;
    //    NSString *hostName = [[NSURL URLWithString:@"http://www.google.com"] host];
    //    Reachability *r = [Reachability reachabilityWithHostName:hostName];
    //    if(NotReachable == [r currentReachabilityStatus]) {
    //
    //        //TODO: put correct message.
    //
    //        status =  NO;
    //
    //    }
    //    else{
    //        status=  YES;
    //    }
    return status;
}



+ (void)playNotification
{
    NSURL *fileURL = [NSURL URLWithString:kChatSoundPath];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)fileURL,&soundID);
    AudioServicesPlaySystemSound(soundID);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1* NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        AudioServicesDisposeSystemSoundID(soundID);
        
    });
    
    
}


+ (void)scheduleLocalNotificationForChat:(NSString *)message
{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    
    double interval = 2;
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:interval];
    localNotification.alertBody = [NSString stringWithFormat:@"GoFro LiveChat:%@",message];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}


+ (void)showAlerWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"GoFro" message:message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];
}


+(NSAttributedString *)getAttributedStrFrom:(NSString *)str1 andString2:(NSString *)str2{
    
    NSString *text = [NSString stringWithFormat:@"%@%@",str1,str2];
    
    // Define general attributes for the entire text
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName:[UIColor lightGrayColor],
                              NSFontAttributeName: kRobotoRegular(kFontSize14)
                              };
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:attribs];
    
    NSRange range = [text rangeOfString:str2];
    [attributedText setAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor],
                                    NSFontAttributeName:kRobotoRegular(kFontSize14)} range:range];
    return attributedText;
}



@end
