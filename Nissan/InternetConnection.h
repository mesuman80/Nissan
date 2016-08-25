//
//  InternetConnection.h
//  Nudger
//
//  Created by Komal Sharma on 12/07/16.
//  Copyright © 2016 Komal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@protocol InternetConnectionDelegate <NSObject>
-(void)isInternetConnection:(BOOL)connection;

@end


@interface InternetConnection : NSObject
@property id<InternetConnectionDelegate>delegate;
-(void)removeObserver;
-(BOOL)connectionStatus;
+(InternetConnection *)sharedInstance;


@end

