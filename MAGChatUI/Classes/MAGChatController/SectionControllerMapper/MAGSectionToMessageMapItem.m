//
//  MAGSectionToMessageMapItem.m
//  MAGChatUI
//
//  Created by Stanislav on 07.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGSectionToMessageMapItem.h"

@implementation MAGSectionToMessageMapItem

- (id)initWithSectionControllerClass:(Class)sectionControllerClass forMessageClass:(Class)messageClass
{
    self = [super init];
    if(self) {
        if([sectionControllerClass isSubclassOfClass:[IGListSectionController class]] &&
           [messageClass isSubclassOfClass:[MAGChatMessage class]]){
            _messageClass = messageClass;
            _sectionControllerClass = sectionControllerClass;
        } else {
           return nil;
        }
    }
    return self;
}

@end
