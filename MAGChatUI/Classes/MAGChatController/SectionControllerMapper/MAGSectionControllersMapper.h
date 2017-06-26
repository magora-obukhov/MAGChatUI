//
//  MAGSectionControllersMapper.h
//  MAGChatUI
//
//  Created by Stanislav on 07.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAGSectionToMessageMapItem.h"

@interface MAGSectionControllersMapper : NSObject
@property (assign, nonatomic) Class dateSeparatorSectionControllerClass;
@property (assign, nonatomic) Class newMessagesSeparatorSectionControllerClass;
@property (assign, nonatomic) Class loadingSectionControllerClass;
@property (assign, nonatomic) Class isTypingSectionControllerClass;

- (Class)sectionControllerForMessageClass:(Class)messageClass;
- (void)mapSectionControllerClass:(Class)sectionControllerClass forMessageClass:(Class)messageClass;

@end
