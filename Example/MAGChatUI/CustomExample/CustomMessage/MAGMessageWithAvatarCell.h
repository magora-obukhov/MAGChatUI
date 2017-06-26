//
//  MAGMessageWithAvatarCell.h
//  MAGChatUI
//
//  Created by user on 19.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAGChatMessageWithAvatar.h"

@interface MAGMessageWithAvatarCell : UICollectionViewCell
@property (nonatomic, weak) MAGChatMessageWithAvatar* message;
+ (CGFloat)cellHeightForMessage:(MAGChatMessageWithAvatar*) message;
@end
