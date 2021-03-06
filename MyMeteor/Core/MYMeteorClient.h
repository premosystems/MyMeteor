//
//  MYMeteorClient.h
//  HereByApp
//
//  Created by Vincil Bishop on 3/5/14.
//  Copyright (c) 2014 Premier Mobile Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ObjectiveDDP.h"
#import "MeteorClient.h"
#import "NSDictionary+MYMeteorAdditions.h"
#import "NSError+MYMeteorAdditions.h"
#import "MyiOSLogicBlocks.h"

#define kMyMeteor_LogonSuccess_Notification @"kMyMeteor_LogonSuccess_Notification"
#define kMyMeteor_LogonFailure_Notification @"kMyMeteor_LogonFailure_Notification"

@interface MYMeteorClient : MeteorClient

+ (void) setMeteorURLString:(NSString*)urlString;
+ (void) setDDPVersion:(NSString*)ddpVersion;
+ (MYMeteorClient*) sharedClient;

- (void) logonWithFacebookData:(NSDictionary*)fbData accessToken:(NSString*)accessToken completion:(MYCompletionBlock)completionBlock;

- (void) connect;
- (void) connectWithQueue:(NSOperationQueue*)queue;

@end
