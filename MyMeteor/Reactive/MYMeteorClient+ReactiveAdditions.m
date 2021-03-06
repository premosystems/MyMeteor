//
//  MYMeteorClient+ReactiveAdditions.m
//  Pods
//
//  Created by Vincil Bishop on 5/7/14.
//
//

#import "MYMeteorClient+ReactiveAdditions.h"
#import "BlocksKit.h"

@implementation MYMeteorClient (ReactiveAdditions)

- (void) authenticatedBlock:(MYCompletionBlock)block
{
    [[[RACObserve([MYMeteorClient sharedClient], userId) skipUntilBlock:^BOOL(NSString *userId) {
        
        return userId != nil;
        
    }] take:1] subscribeNext:^(NSString *userId) {
        
        if (userId != nil) {
            
            if (block) {
                
                block(self,YES,nil,userId);
                
            }        }
    }];
    
}

- (void) connectWithCompletion:(MYCompletionBlock)completion
{
    [self connectionReadyBlock:^(id sender, BOOL success, NSError *error, id result) {
        
        completion(sender,success,error,result);
    }];
    
    [self connect];
}

- (void) connectionReadyBlock:(MYCompletionBlock)block
{
    [[[RACObserve([MYMeteorClient sharedClient], connected) skipUntilBlock:^BOOL(NSNumber *connected) {
        
        return [connected boolValue] == YES;
        
    }] take:1] subscribeNext:^(NSNumber *connected) {
        
        if ([connected boolValue]) {
            
            if (block) {
                
                block(self,YES,nil,connected);
                
            }
            
            //[userId.rac_deallocDisposable dispose];
        }
    }];
}

- (void) webSocketReadyBlock:(MYCompletionBlock)block
{
    [[[RACObserve([MYMeteorClient sharedClient], websocketReady) skipUntilBlock:^BOOL(NSNumber *websocketReady) {
        
        return [websocketReady boolValue] == YES;
        
    }] take:1] subscribeNext:^(NSNumber *websocketReady) {
        
        if ([websocketReady boolValue]) {
            
            if (block) {
                
                block(self,YES,nil,websocketReady);
                
            }
        }
    }];

    /*
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        return [RACObserve([MYMeteorClient sharedClient], websocketReady) subscribeNext:^(NSNumber *websocketReady) {
            
            if ([websocketReady boolValue]) {
                [subscriber sendNext:@[subscriber,websocketReady]];
                
                [subscriber sendCompleted];
            }
        }];
    }];
    
    [signal subscribeNext:^(NSArray *result) {
        
        id<RACSubscriber> subscriber = result[0];
        NSNumber *websocketReady = result[1];
        if (block) {
            block(subscriber,YES,nil,websocketReady);
        }
    }];
    */
    
}

- (void) observeConnectionStateWithBlock:(MYCompletionBlock)block
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        return [RACObserve([MYMeteorClient sharedClient], connected) subscribeNext:^(NSNumber *connected) {
            
            [subscriber sendNext:@[subscriber,connected]];
        }];
    }];
    
    [signal subscribeNext:^(NSArray *result) {
        
        id<RACSubscriber> subscriber = result[0];
        NSNumber *connected = result[1];
        if (block) {
            block(subscriber,YES,nil,connected);
        }
    }];
    
}


- (void) observeWebSocketStateWithBlock:(MYCompletionBlock)block
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        return [RACObserve([MYMeteorClient sharedClient], websocketReady) subscribeNext:^(NSNumber *websocketReady) {
            
            [subscriber sendNext:@[subscriber,websocketReady]];
        }];
    }];
    
    [signal subscribeNext:^(NSArray *result) {
        
        id<RACSubscriber> subscriber = result[0];
        NSNumber *websocketReady = result[1];
        if (block) {
            block(subscriber,YES,nil,websocketReady);
        }
    }];
    
}

- (void) observeCollectionChangesWithBlock:(MYCompletionBlock)block
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        return [RACObserve([MYMeteorClient sharedClient], collections) subscribeNext:^(NSDictionary *collections) {
            
            [subscriber sendNext:@[subscriber,collections]];
        }];
    }];
    
    [signal subscribeNext:^(NSArray *result) {
        
        id<RACSubscriber> subscriber = result[0];
        NSDictionary *collections = result[1];
        if (block) {
            block(subscriber,YES,nil,collections);
        }
    }];
    
}

- (void) observeChangesForCollection:(NSString*)collection withBlock:(MYCompletionBlock)block
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        return [RACObserve([MYMeteorClient sharedClient], collections) subscribeNext:^(NSDictionary *collections) {
            
            
            
            
            [subscriber sendNext:@[subscriber,collections]];
        }];
    }];
    
    [signal subscribeNext:^(NSArray *result) {
        
        id<RACSubscriber> subscriber = result[0];
        NSDictionary *collections = result[1];
        if (block) {
            block(subscriber,YES,nil,collections);
        }
    }];
    
}


@end
