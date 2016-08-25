//
//  NotificationManager.m
//  Nudger
//
//  Created by Komal Sharma on 12/07/16.
//  Copyright © 2016 Komal. All rights reserved.
//

/****************************************************
 1.	Only post a particular notification on one thread. Ideally that would be the main thread, but in any case, be consistent.
 2.	It is only safe to add and remove a notification observer on the same thread that posts the notification.
 3.	In a multi-threaded app, it's difficult to guarantee which thread will call dealloc.
 4.	Never remove an observer in dealloc.
 5.	This is what is sounds like when doves cry.
 ****************************************************/

#import "NotificationManager.h"

NSString *const _Nullable kReachablityStatus      = @"kReachabilityStausNotification"  ;
NSString *const _Nullable kImageDownloadingBegin  = @"kImageDownloadingBegin"          ;
NSString *const _Nullable kImageDownloadingStop   = @"kImageDownloadingStop"           ;

@implementation NotificationManager

+(NotificationManager *) notificationManager {
    static NotificationManager *notificationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notificationManager = [[NotificationManager alloc] init];
    });
    return notificationManager;
}

-(id)init {
    if(self == [super init]) {
        return self;
    }
    return nil;
}

#pragma mark - Method to add the notification observer
-(void)addObserver: (id)notifObserver
          selector: (nonnull SEL)selector
              name: (nullable NSString *) notifName {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] addObserver: notifObserver
                                                 selector: selector
                                                     name: notifName
                                                   object: nil];
    });
}

#pragma mark - Method to remove the notification observer
-(void)removeObserver:(id) observer notifName :(NSString *)notifName {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] removeObserver:observer name:notifName object:nil];
    });
}

/**Removes all the entries specifying a given observer from the receiver’s dispatch table.
 The observer to remove. Must not be nil.*/
-(void)removeObserverForAllNotificationOnMainThread:(id) observer{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] removeObserver: observer];
    });
}

/**Removes all the entries specifying a given observer from the receiver’s dispatch table.
 The observer to remove. Must not be nil. object select in which thread this method will execute. This method for VC, because dealloc method will always call in main thread.*/
-(void)removeObserverForAllNotification:(id) observer   {
    [[NSNotificationCenter defaultCenter] removeObserver: observer];
}

#pragma mark - Method to post notification.
-(void) postNotification: (nonnull NSNotification *)notifation   {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotification: notifation];
    });
}

-(void)postNotification: (NSString *)notifName withObject:(id)notifSender {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:notifName
                                                            object:notifSender];
    });
}

- (void)postNotificationName: (NSString *)notifName
                      object: (nullable id)notifSender
                    userInfo: (nullable NSDictionary *)userInfo {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName: notifName
                                                            object: notifSender
                                                          userInfo: userInfo];
    });
}
@end