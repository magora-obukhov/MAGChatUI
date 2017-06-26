//
//  MAGChatMessage.m
//  MAGChatUI
//
//  Created by Stanislav on 06.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGChatMessage.h"

@implementation MAGChatMessage

- (BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object {
//    if (object_isClass(object)) {
//        <#statements#>
//    }
//    NSLog(@"%d",[self.identifier isEqual:object]);
    return [self isEqual:object];
}

- (id<NSObject>)diffIdentifier {
    return self;
}

- (NSComparator)comparator {
    if (! _comparator) {
        _comparator = ^NSComparisonResult(MAGChatMessage *a, MAGChatMessage *b) {
            NSDate *first = [(MAGChatMessage *)a serverTimeStamp];
            if (!first) {
                first = [(MAGChatMessage *)a senderTimeStamp];
            }
            NSDate *second = [(MAGChatMessage *)b serverTimeStamp];
            if (!second) {
                second = [(MAGChatMessage *)b senderTimeStamp];
            }
            return [first compare:second];
        };
    }
    return _comparator;
}
@end
