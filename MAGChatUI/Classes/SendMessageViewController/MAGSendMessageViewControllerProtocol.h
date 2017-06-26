//
//  MAGSendMessageViewControllerProtocol.h
//  MAGChatUI
//
//  Created by Stanislav on 08.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAGChatMessage.h"

@protocol MAGSendMessageViewControllerDelegate <NSObject>
- (void)sendMessage:(MAGChatMessage *)messageText;
@end

@protocol MAGSendMessageViewControllerProtocol <NSObject>
@property (weak, nonatomic) id<MAGSendMessageViewControllerDelegate> delegate;
@end
