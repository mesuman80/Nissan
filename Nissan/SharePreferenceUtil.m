//
//  SharePreferenceUtil.m
//  Nudger
//
//  Created by Komal Sharma on 06/07/16.
//  Copyright © 2016 Komal. All rights reserved.
//

#import "SharePreferenceUtil.h"

static SharePreferenceUtil *sharedInstance;
@implementation SharePreferenceUtil

+(SharePreferenceUtil *)getInstance {
    if(sharedInstance == nil){
        sharedInstance = [[SharePreferenceUtil alloc] init];
    }
    return sharedInstance;
}

-(id)init {
    if(self = [super init]) {
        defaults = [NSUserDefaults standardUserDefaults];
        return self;
    }
    return nil;
}

-(void)saveString:(NSString*)string withKey:(NSString *)key{
    [defaults setObject:string forKey:key];
    [defaults synchronize];
}

-(NSString*)getStringWithKey:(NSString *)key{
    NSData *savedData = [defaults objectForKey:key];
    if (savedData != nil) {
        return [defaults objectForKey:key];
    }
    return nil;
}

-(void)saveBool:(BOOL)value withKey:(NSString *)key{
    [defaults setBool:value forKey:key];
    [defaults synchronize];
}

-(BOOL)getBoolWithKey:(NSString *)key{
   return [defaults boolForKey:key];
}

-(void)saveInteger:(int)value withKey:(NSString *)key{
    [defaults setInteger:value forKey:key];
    [defaults synchronize];
}

-(int)getIntegerWithKey:(NSString *)key{
    return (int)[defaults integerForKey:key];
}

-(void)saveFloat:(float)value withKey:(NSString *)key{
    [defaults setFloat:value forKey:key];
    [defaults synchronize];
}

-(float)getFloatWithKey:(NSString *)key{
    return [defaults floatForKey:key];
}

-(void)saveDouble:(double)value withKey:(NSString *)key{
    [defaults setDouble:value forKey:key];
    [defaults synchronize];
}

-(double)getDoubleWithKey:(NSString *)key{
    return [defaults doubleForKey:key];
}

-(void)saveCustomObjectInDefaults:(id)object withKey:(NSString *)key
{
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:object] forKey:key];
    [defaults synchronize];
}

-(id)getCustomObjectFromDefaultsWithKey:(NSString *)key
{
    NSData *savedData = [defaults objectForKey:key];
    if (savedData != nil) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:savedData];
    }
    return nil;
}

-(void)resetUserDefaults {
    NSDictionary * dict = [defaults dictionaryRepresentation];
    for (id key in dict) {
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
}

@end
