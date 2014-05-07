//
//  MYMeteorClient+ReactiveAdditions.m
//  Pods
//
//  Created by Vincil Bishop on 5/7/14.
//
//

#import "MYMeteorClient+ReactiveAdditions.h"

@implementation MYMeteorClient (ReactiveAdditions)

- (void) webSocketReadyBlock:(MYCompletionBlock)block
{
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

@end
