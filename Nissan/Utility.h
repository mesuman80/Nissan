//
//  Utility.h
//  Nudger
//
//  Created by Komal Sharma on 06/07/16.
//  Copyright © 2016 Komal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface Utility : NSObject

//Alerts
-(UIAlertView*)generateAlertWithTitle:(NSString *)title message:(NSString *)message andDelegate:(id)delegate;
-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message andDelegate:(id)delegate;

//Application
-(UIWindow *)getApplicationWindow;
-(void)showStatusBar;
-(void)hideStatusBar;
-(CGFloat)statusBarAndNavigationBarHeight:(UIView *)navigationBar;
-(void)configNudgerServerData;

//HUD
-(void)showHUD;
-(void)showHUDWithProgress:(float)progress;
-(void)hideHUD;

//Image
-(UIImage *)compressImage:(UIImage *)image;
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
-(void)saveImage:(NSData *)imagedata withUrl:(NSString *)imageStr;
-(NSData *)readFileFromPath:(NSString *)imageStr;

//Date and time
-(NSString *) currentTimeStamp;
-(NSString *)getDateString:(NSDate *)date;
-(NSDate *)getDate:(NSString *)dateString;
-(NSDate *)getDate:(NSString *)dateString fromFormat:(NSString *)format;
-(NSString *)getDateStringInServerFormat:(NSString *)dateString;

//String Utils
-(long)gettrimmedStringLength:(NSString *)dataToTrim;
-(BOOL)isValidEmail:(NSString *)emailString Strict:(BOOL)strictFilter;
- (BOOL)myMobileNumberValidate:(NSString*)number;
-(BOOL)passwordValidate:(NSString *)password;
-(NSString *)generateUniqueID;
-(NSString*)formatNumber:(NSString*)mobileNumber;
-(int)getLength:(NSString*)mobileNumber;

#pragma borderSpecificFunction
-(void)addBorderToTextField:(UITextField *)textField withCornerRadius:(float)cornerRadius BorderWidth:(float)borderWidth;
-(void)addBorderToButton:(UIButton *)button BorderWidth:(float)borderWidth Radius:(float)radius Color:(UIColor *)color;
-(void)addBorderToUiView:(UIView *)view withBorderWidth:(float)borderWidth cornerRadius:(float)cornerRadius Color:(UIColor *)color;
-(void)addBorderToUiSwitch:(UISwitch *)switchBar withBorderWidth:(float)borderWidth cornerRadius:(float)cornerRadius Color:(UIColor *)color;
-(void)addBorderToLabel:(UILabel *)label BorderWidth:(float)borderWidth Radius:(float)radius Color:(UIColor *)color;

//Color Specifications
-(UIColor*)colorWithHexString:(NSString*)hex withAlpha:(float)alphaVal;

//Country code
-(NSDictionary *)dictCountryCodes;
-(NSString *)countryCode;
@end
