//
//  NotificationManager.h
//  Nudger
//
//  Created by Komal Sharma on 12/07/16.
//  Copyright © 2016 Komal. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const _Nullable kReachablityStatus      ;
extern NSString *const _Nullable kImageDownloadingBegin  ;
extern NSString *const _Nullable kImageDownloadingStop   ;


#define kGoesInternet                           @"kGoesInternet"
#define kUserGoesOffline                        @"kUserGoesOffline"
#define kUserComeOnline                         @"kUserGoesOnline"
#define kSyncFriendsVcard                       @"kSyncFriendsVcard"
/**
 Notification Manager provide the way to send notification at main thread and and process it on main thread. This also add observer at main thread.
 */
@interface NotificationManager : NSObject

/**Go get access for notification Manager singleton object*/
+(nonnull NotificationManager *) notificationManager;
/**Method to add the notification observer*/
-(void)addObserver: (nonnull id)notifObserver
          selector: (nonnull SEL)selector
              name: (nullable NSString *) notifName;
/**Method to remove the notification observer*/
-(void)removeObserver:(nonnull id) observer notifName :(nonnull NSString *)notifName;
/**Removes all the entries specifying a given observer from the receiver’s dispatch table.
 The observer to remove. Must not be nil. This will always execute in main thread*/
-(void)removeObserverForAllNotificationOnMainThread:(nonnull id) observer;
/**Removes all the entries specifying a given observer from the receiver’s dispatch table.
 The observer to remove. Must not be nil. object select in which thread this method will execute. This method for VC, because dealloc method will always call in main thread.*/
-(void)removeObserverForAllNotification:(nonnull id) observer;
/**Method to post notification with notification objectx.*/
-(void) postNotification: (nonnull NSNotification *)notifation;
/**Post notification to observer with optional object and notification name*/
-(void)postNotification: (nonnull NSString *)notifName withObject:(nullable id)notifSender;
/**Post notification to observer with optional object and notification name and sender*/
- (void)postNotificationName: (nonnull NSString *)notifName
                      object: (nullable id)notifSender
                    userInfo: (nullable NSDictionary *)userInfo;
@end
