//
//  WebService.h
//  Nudger
//
//  Created by Komal Sharma on 07/07/16.
//  Copyright © 2016 Komal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseModel.h"

typedef void(^onCompletion)(NSString *error, ResponseModel *responseModel);

@interface WebService : NSObject
//Registration Webservices
-(void)registerMobileNumberInServer:(NSString*)mobileNumber withCC:(NSString*)countryCode completion:(onCompletion)iCompletion;
-(void)verifyMobileNumberInServer:(NSString*)mobileNumber withVerificationCode:(NSString*)verifyCode completion:(onCompletion)iCompletion;
-(void)resendVerificationCode:(NSString*)mobileNumber completion:(onCompletion)iCompletion;

//User Update Webservices
-(void)updateDeviceTokenInSever;

//Category Webservices
-(void)getCategoryListWithCompletion:(onCompletion)iCompletion;

@end
