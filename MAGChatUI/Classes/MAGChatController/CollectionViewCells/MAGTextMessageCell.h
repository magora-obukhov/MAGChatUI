//
//  MAGTextMessageCell.h
//  MAGChatUI
//
//  Created by Stanislav on 06.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAGChatMessage.h"

@interface MAGTextMessageCell : UICollectionViewCell

@property (nonatomic, weak) MAGChatMessage* message;
+ (CGFloat)cellHeightForMessage:(MAGChatMessage*) message;

@end
