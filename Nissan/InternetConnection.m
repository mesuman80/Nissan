//
//  InternetConnection.m
//  Nudger
//
//  Created by Komal Sharma on 12/07/16.
//  Copyright © 2016 Komal. All rights reserved.
//

#import "InternetConnection.h"
#import "Reachability.h"
#import "NotificationManager.h"

@interface InternetConnection ()
@property (nonatomic) Reachability *hostReachability    ;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability    ;
@end

@implementation InternetConnection {
    BOOL isConnected;
}

+(InternetConnection *)sharedInstance {
    static InternetConnection *connectionInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        connectionInstance=[[InternetConnection alloc]init];
    });
    return connectionInstance;
}

-(id)init {
    if(self=[super init]) {
        isConnected= NO;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        
        self.hostReachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
        [self.hostReachability startNotifier];
        
        
        self.internetReachability = [Reachability reachabilityForInternetConnection];
        [self.internetReachability startNotifier];
        
        
        self.wifiReachability = [Reachability reachabilityForLocalWiFi];
        [self.wifiReachability startNotifier];
        
    }
    return self;
}

-(void) reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self checkConnection:curReach];
}

-(void)checkConnection:(Reachability *)reachability {
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    isConnected = [reachability connectionRequired];
    switch (netStatus) {
        case NotReachable       :      isConnected = NO ;
             break;
        case ReachableViaWWAN   :      isConnected = YES;
            break;
        case ReachableViaWiFi   :      isConnected = YES;
           break;
    }
    [self sendStatus:isConnected];
}



-(void)sendStatus:(BOOL)isConnected1 {
    if(self.delegate && [[self delegate] respondsToSelector:@selector(isInternetConnection:)]) {
        [self.delegate isInternetConnection:isConnected1];
    }
    [[NotificationManager notificationManager] postNotification:kReachablityStatus
                                                     withObject:[NSNumber numberWithBool:isConnected1]];
}

-(BOOL)connectionStatus{ return  isConnected;}
-(void)removeObserver { [[NSNotificationCenter defaultCenter]removeObserver:self];  }
-(void)dealloc {  [self removeObserver];}





@end
