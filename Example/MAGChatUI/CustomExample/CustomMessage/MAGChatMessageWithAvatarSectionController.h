//
//  MAGChatMessageWithAvatarSectionController.h
//  MAGChatUI
//
//  Created by user on 19.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import "MAGChatMessageWithAvatar.h"
#import "MAGMessageWithAvatarCell.h"

@interface MAGChatMessageWithAvatarSectionController : IGListSectionController
@property (nonatomic,weak) MAGChatMessageWithAvatar *message;
@end
