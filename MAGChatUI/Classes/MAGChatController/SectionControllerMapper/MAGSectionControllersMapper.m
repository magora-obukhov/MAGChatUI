//
//  MAGSectionControllersMapper.m
//  MAGChatUI
//
//  Created by Stanislav on 07.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGSectionControllersMapper.h"
#import "MAGDateSeparatorSectionController.h"
#import "MAGNewMessagesSeparatorSectionController.h"
#import "MAGLoadingSectionController.h"
#import "MAGIsTypingSectionController.h"


@implementation MAGSectionControllersMapper

{
    NSMutableArray<MAGSectionToMessageMapItem *> *mappingArray;
}

- (id)init{
    self = [super init];
    if(self) {
        mappingArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (Class)sectionControllerForMessageClass:(Class)messageClass{
    for (MAGSectionToMessageMapItem *mapItem in mappingArray) {
        if (mapItem.messageClass == messageClass) {
            return mapItem.sectionControllerClass;
        }
    }
    return nil;
}

- (void)mapSectionControllerClass:(Class)sectionController forMessageClass:(Class)messageClass{
    MAGSectionToMessageMapItem *mapItem = [[MAGSectionToMessageMapItem alloc]initWithSectionControllerClass:sectionController forMessageClass:messageClass];
    if (mapItem) {
        MAGSectionToMessageMapItem *messageClassPrevMapping;
        for (MAGSectionToMessageMapItem *item in mappingArray) {
            if (item.messageClass == messageClass) {
                messageClassPrevMapping = item;
            }
        }
        if (messageClassPrevMapping) {
            [mappingArray removeObject:messageClassPrevMapping];
        }
        [mappingArray addObject:mapItem];
    }
}

- (Class)dateSeparatorSectionControllerClass {
    if (_dateSeparatorSectionControllerClass) {
        return _dateSeparatorSectionControllerClass;
    } else {
        return [MAGDateSeparatorSectionController class];
    }
}

- (Class)newMessagesSeparatorSectionControllerClass{
    if (_newMessagesSeparatorSectionControllerClass) {
        return _newMessagesSeparatorSectionControllerClass;
    } else {
        return [MAGNewMessagesSeparatorSectionController class];
    }
}

- (Class)loadingSectionControllerClass{
    if (_loadingSectionControllerClass != Nil) {
        return _loadingSectionControllerClass;
    } else {
        return [MAGLoadingSectionController class];
    }
}

- (Class)isTypingSectionControllerClass{
    if (_isTypingSectionControllerClass != Nil) {
        return _isTypingSectionControllerClass;
    }
    return [MAGIsTypingSectionController class];
}

@end
