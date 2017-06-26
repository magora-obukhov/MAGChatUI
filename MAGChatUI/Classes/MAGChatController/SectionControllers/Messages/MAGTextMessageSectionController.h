//
//  MAGTextMessageSectionController.h
//  MAGChatUI
//
//  Created by Stanislav on 06.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import "MAGChatMessage.h"
#import <UIKit/UIKit.h>


@interface MAGTextMessageSectionController : IGListSectionController
@property (nonatomic,weak) MAGChatMessage *message;
@end
