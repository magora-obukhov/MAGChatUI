//
//  MAGSectionToMessageMapItem.h
//  MAGChatUI
//
//  Created by Stanislav on 07.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MAGChatMessage.h"


@interface MAGSectionToMessageMapItem : NSObject
- (id)initWithSectionControllerClass:(Class)sectionControllerClass forMessageClass:(Class)messageClass;
@property (readonly,nonatomic) Class sectionControllerClass;
@property (readonly,nonatomic) Class messageClass;
@end
