//
//  NSMutableArray+MAGMessagesArray.m
//  MAGChatUI
//
//  Created by Stanislav on 09.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "NSMutableArray+MAGMessagesArray.h"

@implementation NSMutableArray(MessagesArray)



- (void)addObjectWithSorting:(MAGChatMessage *)message {
        NSUInteger newIndex = [self indexOfObject:message
                                             inSortedRange:(NSRange){0, [self count]}
                                                   options:NSBinarySearchingInsertionIndex
                                           usingComparator:message.comparator];
        [self insertObject:message atIndex:newIndex];
}

@end
