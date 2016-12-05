//
//  APIConstants.h
//  SportInfo
//
//  Created by VectoScalar on 4/21/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#ifndef APIConstants_h
#define APIConstants_h


#endif /* APIConstants_h */





#if QAInstance


//Chat URL
#define kChatUrl @"chat-integration.gofro.com"

//Privacy URL
#define kPrivacyBaseURL @"http://www.gofro.com/"

//Base URL
#define kBaseUrl @"http://IntegrationBuyerapi-297546203.us-east-1.elb.amazonaws.com/"

#define kTempBaseUrl  @"http://IntegrationBuyerapi-297546203.us-east-1.elb.amazonaws.com/"

#else

//Chat URL
#define kChatUrl [[DataManager sharedDataManager] getChatURL]

//Base URL
#define kTempBaseUrl  @"http://buyerapi.gofro.com/"

#define kBaseUrl [[DataManager sharedDataManager] getBaseUrl]

//Privacy Policy URL
#define kPrivacyBaseURL [[DataManager sharedDataManager] getBaseUrl]

#endif

#define kImageUrl @"http://i3.bonavitatech.com/"
#define kImageTripRect @"-335X140"
#define kImageTripThumbnail @"-140X150"
#define kImageItineraryCity @"-506X119"
#define kImageItineraryActivity @"-120X90"
#define kImageItineraryHotel @"-140X150"

#define kAPIBodyKey @"body"
#define kHeaderKey @"headerKey"

//Registration
#define kRegstrationAPI @"api/user/register"
//Login API
#define kLoginAPI @"api/login"
//Forgot Password to get OTP
#define kForgotPassowordAPI @"api/user/gvt"
//Google Login API
#define kGoogleLoginAPI @"api/googlelogin"
//Facebook Login API
#define kFacebookLoginAPI @"api/fblogin"
//User Profile API
#define kUserProfileAPI @"api/user/profile"
//Chat Tocken
#define kChatTockenAPI @"api/user/gat"
//Force Update API
#define kForceUpdateAPI @"api/admin/config"

#define kLogoutAPI @"api/logout"

#define kVoucherAPI @"api/account/trips/vouchers"
//Trip API
#define kTripsAPI @"api/account/trips"
//Itinerary API
#define kItineraryAPI @"api/account/trips/itinerary"

//Chat Log API

#define kChatLogAPI @"api/admin/log"

//Headers
#define kLoginHeaderKey @"X-Requested-With"
#define kLoginHeaderValue @"XMLHttpRequest"

#define kEmailHeaderKey @"User_Email"






/////Parameters

#define kEmailParam @"email"
#define kMobileParam @"mobile"
#define kPasswordParam @"password"
#define kConfirmPasswordParam @"confirmPassword"
#define kUserNameParam @"name"
#define kGenderParam @"gender"
#define kLocationParam @"location"
#define kNewLetterSubscriptionParam @"newletterSubscription"
#define kTokenParam @"token"


//LoginParams
#define loginUserNameParam kUserNameParam

#define kLogLevelKey @"LogLevelKeyForChat"






