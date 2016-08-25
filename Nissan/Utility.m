//
//  Utility.m
//  Nudger
//
//  Created by Komal Sharma on 06/07/16.
//  Copyright © 2016 Komal. All rights reserved.
//

#import "Utility.h"

@implementation Utility{
    NSDateFormatter *dateformatter;
}

-(id)init{
    dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"dd/MM/yy, HH:mm"];
    return self;
}

#pragma Alerts Method
-(UIAlertView*)generateAlertWithTitle:(NSString *)title message:(NSString *)message andDelegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil, nil];
    return alert;
}

-(void)showAlertWithTitle:(NSString *)title message:(NSString *)message andDelegate:(id)delegate{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil, nil];
    [alert show];
}


#pragma Application Method
-(UIWindow *)getApplicationWindow
{
    return [[[UIApplication sharedApplication] windows] firstObject];
}

-(void)showStatusBar
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

-(void)hideStatusBar
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

-(CGFloat)statusBarAndNavigationBarHeight:(UIView *)navigationBar
{
    CGFloat ststusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navigationBarHeight = navigationBar.frame.size.height;
    CGFloat totalHeight = ststusBarHeight + navigationBarHeight;
    return totalHeight;
}

-(void)configNudgerServerData{
    SharePreferenceUtil *sharePreferenceUtil = [SharePreferenceUtil getInstance];
    [sharePreferenceUtil saveString:@"http://54.183.197.171/" withKey:kN_ChatBaseIP];
    [sharePreferenceUtil saveString:@"http://54.183.197.171:2878/" withKey:kN_ChatBaseURL];
    [sharePreferenceUtil saveString:@"54.183.197.171" withKey:kN_Host];
    [sharePreferenceUtil saveString:@"swoop.yappyapps.com" withKey:kN_ServerDomain];
    [sharePreferenceUtil saveString:@"http://54.153.76.97/NudgerAPI/api/" withKey:kN_BaseURL];
    [sharePreferenceUtil saveString:@"http://54.153.76.97/" withKey:kN_BaseIP];
}

#pragma Hud Method
-(void)showHUD
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
}

-(void)showHUDWithProgress:(float)progress
{
    [SVProgressHUD showProgress:progress maskType:SVProgressHUDMaskTypeBlack];
}

-(void)hideHUD
{
    [SVProgressHUD dismiss];
}


#pragma Image Method
-(UIImage *)compressImage:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 600.0;
    float maxWidth = 400.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    //   float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth)
    {
        if(imgRatio < maxRatio)
        {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio)
        {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else
        {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    return img;
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void)saveImage:(NSData *)imagedata withUrl:(NSString *)imageStr
{
    imageStr = [imageStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
                   ^{
                       NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       UIImage *image=[UIImage imageWithData:imagedata];
                       NSString *pngFilePath = [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageStr]];
                       NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
                       [data1 writeToFile:pngFilePath atomically:YES];
                      
                       
                   });
}

-(NSData *)readFileFromPath:(NSString *)imageStr
{
    imageStr = [imageStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSString *documentsDirectory =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *localFilePath= [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageStr]];
    NSData *imgData = [NSData dataWithContentsOfFile:localFilePath];
    return imgData;
}

#pragma Date and Time Method
-(NSString *) currentTimeStamp {
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
}

-(NSString *)getDateString:(NSDate *)date
{
    return [dateformatter stringFromDate:date];
}

-(NSDate *)getDate:(NSString *)dateString
{
    return [dateformatter dateFromString:dateString];
}

-(NSDate *)getDate:(NSString *)dateString fromFormat:(NSString *)format
{
    NSString *dateFormat = [dateformatter dateFormat];
    
    [dateformatter setDateFormat:format];
    NSDate *date = [dateformatter dateFromString:dateString];
    
    [dateformatter setDateFormat:dateFormat];
    return date;
}

-(NSString *)getDateStringInServerFormat:(NSString *)dateString
{
    NSString *dateFormat = [dateformatter dateFormat];
    
    NSDate *date = [dateformatter dateFromString:dateString];
    [dateformatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    
    NSString *newDateString = [dateformatter stringFromDate:date];
    [dateformatter setDateFormat:dateFormat];
    
    return newDateString;
}

#pragma String Utils Method
-(long)gettrimmedStringLength:(NSString *)dataToTrim
{
    NSString* result = [dataToTrim stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return result.length;
}

-(BOOL)isValidEmail:(NSString *)emailString Strict:(BOOL)strictFilter
{
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = strictFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:emailString];
}

- (BOOL)myMobileNumberValidate:(NSString*)number
{
    NSString *numberRegEx = @"[0-9]{10}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    if ([numberTest evaluateWithObject:number] == YES)
        return TRUE;
    else
        return FALSE;
}

-(BOOL)passwordValidate:(NSString *)password
{
    if(password.length == 0)
    {
        return NO;
    }
    return YES;
}

-(NSString *)generateUniqueID
{
    return [NSString stringWithFormat:@"%i",arc4random_uniform(900000) + 100000];
}

-(NSString*)formatNumber:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSLog(@"%@", mobileNumber);
    int length = [mobileNumber length];
    if(length > 10){
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
    }
    return mobileNumber;
}

-(int)getLength:(NSString*)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    int length = [mobileNumber length];
    return length;
}

#pragma borderSpecificFunction
-(void)addBorderToTextField:(UITextField *)textField withCornerRadius:(float)cornerRadius BorderWidth:(float)borderWidth
{
    [textField.layer setBorderColor:[[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor]];
    [textField.layer setBorderWidth:borderWidth];
    textField.layer.cornerRadius = cornerRadius;
    textField.clipsToBounds = YES;
}
-(void)addBorderToButton:(UIButton *)button BorderWidth:(float)borderWidth Radius:(float)radius Color:(UIColor *)color
{
    [button.layer setBorderColor:[color CGColor]];
    [button.layer setBorderWidth:borderWidth];
    button.layer.cornerRadius =radius;
    button.clipsToBounds = YES;
}
-(void)addBorderToUiView:(UIView *)view withBorderWidth:(float)borderWidth cornerRadius:(float)cornerRadius Color:(UIColor *)color
{
    [view.layer setBorderColor:color.CGColor];//[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [view.layer setBorderWidth:borderWidth];
    view.layer.cornerRadius = cornerRadius;
    view.clipsToBounds = YES;
}
-(void)addBorderToUiSwitch:(UISwitch *)switchBar withBorderWidth:(float)borderWidth cornerRadius:(float)cornerRadius Color:(UIColor *)color
{
    [switchBar.layer setBorderColor:color.CGColor];//[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [switchBar.layer setBorderWidth:borderWidth];
    switchBar.layer.cornerRadius = cornerRadius;
    switchBar.clipsToBounds = YES;
}
-(void)addBorderToLabel:(UILabel *)label BorderWidth:(float)borderWidth Radius:(float)radius Color:(UIColor *)color
{
    [label.layer setBorderColor:[color CGColor]];
    [label.layer setBorderWidth:borderWidth];
    label.layer.cornerRadius =radius;
    label.clipsToBounds = YES;
}

#pragma colorSpecification
-(UIColor*)colorWithHexString:(NSString*)hex withAlpha:(float)alphaVal
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alphaVal];
}

#pragma Country Code Selection
-(NSDictionary *)dictCountryCodes
{
    NSDictionary *dictCodes = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"93", @"AF",@"20",@"EG", @"355", @"AL", @"213", @"DZ", @"1", @"AS",
                               @"376", @"AD", @"244", @"AO", @"1", @"AI", @"1", @"AG",
                               @"54", @"AR", @"374", @"AM", @"297", @"AW", @"61", @"AU",
                               @"43", @"AT", @"994", @"AZ", @"1", @"BS", @"973", @"BH",
                               @"880", @"BD", @"1", @"BB", @"375", @"BY", @"32", @"BE",
                               @"501", @"BZ", @"229", @"BJ", @"1", @"BM", @"975", @"BT",
                               @"387", @"BA", @"267", @"BW", @"55", @"BR", @"246", @"IO",
                               @"359", @"BG", @"226", @"BF", @"257", @"BI", @"855", @"KH",
                               @"237", @"CM", @"1", @"CA", @"238", @"CV", @"345", @"KY",
                               @"236", @"CF", @"235", @"TD", @"56", @"CL", @"86", @"CN",
                               @"61", @"CX", @"57", @"CO", @"269", @"KM", @"242", @"CG",
                               @"682", @"CK", @"506", @"CR", @"385", @"HR", @"53", @"CU",
                               @"537", @"CY", @"420", @"CZ", @"45", @"DK", @"253", @"DJ",
                               @"1", @"DM", @"1", @"DO", @"593", @"EC", @"20", @"EG",
                               @"503", @"SV", @"240", @"GQ", @"291", @"ER", @"372", @"EE",
                               @"251", @"ET", @"298", @"FO", @"679", @"FJ", @"358", @"FI",
                               @"33", @"FR", @"594", @"GF", @"689", @"PF", @"241", @"GA",
                               @"220", @"GM", @"995", @"GE", @"49", @"DE", @"233", @"GH",
                               @"350", @"GI", @"30", @"GR", @"299", @"GL", @"1", @"GD",
                               @"590", @"GP", @"1", @"GU", @"502", @"GT", @"224", @"GN",
                               @"245", @"GW", @"595", @"GY", @"509", @"HT", @"504", @"HN",
                               @"36", @"HU", @"354", @"IS", @"91", @"IN", @"62", @"ID",
                               @"964", @"IQ", @"353", @"IE", @"972", @"IL", @"39", @"IT",
                               @"1", @"JM", @"81", @"JP", @"962", @"JO", @"77", @"KZ",
                               @"254", @"KE", @"686", @"KI", @"965", @"KW", @"996", @"KG",
                               @"371", @"LV", @"961", @"LB", @"266", @"LS", @"231", @"LR",
                               @"423", @"LI", @"370", @"LT", @"352", @"LU", @"261", @"MG",
                               @"265", @"MW", @"60", @"MY", @"960", @"MV", @"223", @"ML",
                               @"356", @"MT", @"692", @"MH", @"596", @"MQ", @"222", @"MR",
                               @"230", @"MU", @"262", @"YT", @"52", @"MX", @"377", @"MC",
                               @"976", @"MN", @"382", @"ME", @"1", @"MS", @"212", @"MA",
                               @"95", @"MM", @"264", @"NA", @"674", @"NR", @"977", @"NP",
                               @"31", @"NL", @"599", @"AN", @"687", @"NC", @"64", @"NZ",
                               @"505", @"NI", @"227", @"NE", @"234", @"NG", @"683", @"NU",
                               @"672", @"NF", @"1", @"MP", @"47", @"NO", @"968", @"OM",
                               @"92", @"PK", @"680", @"PW", @"507", @"PA", @"675", @"PG",
                               @"595", @"PY", @"51", @"PE", @"63", @"PH", @"48", @"PL",
                               @"351", @"PT", @"1", @"PR", @"974", @"QA", @"40", @"RO",
                               @"250", @"RW", @"685", @"WS", @"378", @"SM", @"966", @"SA",
                               @"221", @"SN", @"381", @"RS", @"248", @"SC", @"232", @"SL",
                               @"65", @"SG", @"421", @"SK", @"386", @"SI", @"677", @"SB",
                               @"27", @"ZA", @"500", @"GS", @"34", @"ES", @"94", @"LK",
                               @"249", @"SD", @"597", @"SR", @"268", @"SZ", @"46", @"SE",
                               @"41", @"CH", @"992", @"TJ", @"66", @"TH", @"228", @"TG",
                               @"690", @"TK", @"676", @"TO", @"1", @"TT", @"216", @"TN",
                               @"90", @"TR", @"993", @"TM", @"1", @"TC", @"688", @"TV",
                               @"256", @"UG", @"380", @"UA", @"971", @"AE", @"44", @"GB",
                               @"1", @"US", @"598", @"UY", @"998", @"UZ", @"678", @"VU",
                               @"681", @"WF", @"967", @"YE", @"260", @"ZM", @"263", @"ZW",
                               @"591", @"BO", @"673", @"BN", @"61", @"CC", @"243", @"CD",
                               @"225", @"CI", @"500", @"FK", @"44", @"GG", @"379", @"VA",
                               @"852", @"HK", @"98", @"IR", @"44", @"IM", @"44", @"JE",
                               @"850", @"KP", @"82", @"KR", @"856", @"LA", @"218", @"LY",
                               @"853", @"MO", @"389", @"MK", @"691", @"FM", @"373", @"MD",
                               @"258", @"MZ", @"970", @"PS", @"872", @"PN", @"262", @"RE",
                               @"7", @"RU", @"590", @"BL", @"290", @"SH", @"1", @"KN",
                               @"1", @"LC", @"590", @"MF", @"508", @"PM", @"1", @"VC",
                               @"239", @"ST", @"252", @"SO", @"47", @"SJ", @"963", @"SY",
                               @"886", @"TW", @"255", @"TZ", @"670", @"TL", @"58", @"VE",
                               @"84", @"VN", @"1", @"VG", @"1", @"VI", nil];
    
    return dictCodes;
}

-(NSString *)countryCode
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
    NSDictionary *dict = [self dictCountryCodes];
    NSString *numberString = [NSString stringWithFormat:@"+%@",[dict objectForKey:countryCode]];
    return numberString;
}


@end
