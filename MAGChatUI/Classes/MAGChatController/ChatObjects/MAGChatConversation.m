//
//  MAGChatConversation.m
//  MAGChatUI
//
//  Created by Stanislav on 06.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGChatConversation.h"

@implementation MAGChatConversation

- (instancetype)init{
    self = [super init];
    if(self) {
        _messages = [[NSMutableArray alloc] init];
    }
    return self;

}

//- (id)initDemoConversation
//{
//    self = [super init];
//    if(self) {
//        MAGChatPerson *person1 = [[MAGChatPerson alloc] init];
//        MAGChatPerson *person2 = [[MAGChatPerson alloc] init];
//        person1.name = @"name1";
//        person2.name = @"name2";
//        MAGChatMessage *m1 = [[MAGChatMessage alloc] init];
//        MAGChatMessage *m2 = [[MAGChatMessage alloc] init];
//        m1.sender = person1;
//        m1.messageText = @"hi";
//        m1.identifier = @"1";
//        m2.sender = person2;
//        m2.messageText = @"hello";
//        m1.identifier = @"2";
//        //_messages = @[m1,m2];
//        [self.messages addObject:m1];
//        [self.messages addObject:m2];
//    }
//    return self;
//}



- (void)addMessages:(NSArray *)objects{
    [objects enumerateObjectsUsingBlock:^(MAGChatMessage *message, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.messages addObjectWithSorting:message];
    }];
    
}

- (void)updateMessage:(MAGChatMessage *)message{
    __block MAGChatMessage *messageToUpdate = nil;
    __block NSUInteger messageIndex = 0;
    [self.messages enumerateObjectsUsingBlock:^(MAGChatMessage *messageObj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([messageObj.identifier isEqualToString:message.identifier] ||
            [messageObj.localIdentifier isEqualToString:message.localIdentifier]) {
            messageToUpdate = messageObj;
            messageIndex = idx;
            *stop = YES;
        }
    }];
    if (messageToUpdate) {
        [self.messages replaceObjectAtIndex:messageIndex withObject:message];
    } else {
        [self.messages addObjectWithSorting:message];
    }
}

@end
