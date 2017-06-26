//
//  NSMutableArray+MAGMessagesArray.h
//  MAGChatUI
//
//  Created by Stanislav on 09.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAGChatMessage.h"

@interface NSMutableArray(MessagesArray)
- (void)addObjectWithSorting:(MAGChatMessage *)message;
@end
