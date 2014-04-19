//
//  MYMeteorModelControllerBase.m
//  Pods
//
//  Created by Vincil Bishop on 4/18/14.
//
//

#import "MYMeteorModelControllerBase.h"
#import "MYMeteorModelObjectBase.h"
#import "MYMeteorClient+ModelAdditions.h"
#import "MYMeteorableModelObject.h"

@implementation MYMeteorModelControllerBase

- (id) initWithClass:(Class<MYMeteorableModelObject>)modelClass
{
    self = [super init];
    
    if (self) {
 
        self.collectionName = [[MYMeteorClient sharedClient] collectionStringForClass:modelClass];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCollectionUpdated:) name:[NSString stringWithFormat:@"%@_added",self.collectionName] object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCollectionUpdated:) name:[NSString stringWithFormat:@"%@_updated",self.collectionName] object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCollectionUpdatedd:) name:[NSString stringWithFormat:@"%@_removed",self.collectionName] object:nil];
        
    }
    
    return self;
}

- (void) handleCollectionUpdated:(NSNotification*)notification
{
    DDLogVerbose(@"Collection:%@ Updated:%@:%@",self.collectionName,notification.object,notification.userInfo);
}

@end
