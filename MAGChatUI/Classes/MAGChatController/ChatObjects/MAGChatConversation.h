//
//  MAGChatConversation.h
//  MAGChatUI
//
//  Created by Stanislav on 06.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAGChatMessage.h"
#import "NSMutableArray+MAGMessagesArray.h"

@interface MAGChatConversation : NSObject
@property (nonatomic) NSString* name;
@property (nonatomic,readonly) NSMutableArray* messages;

//- (id)initDemoConversation;
- (void)addMessages:(NSArray *)objects;
- (void)updateMessage:(MAGChatMessage *)message;
@end

