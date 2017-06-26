//
//  MAGDateSeparator.m
//  MAGChatUI
//
//  Created by user on 15.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGDateSeparator.h"

@implementation MAGDateSeparator

-(BOOL)isEqualToDiffableObject:(id<IGListDiffable,NSObject>)object{
    if (![object isKindOfClass:[MAGDateSeparator class]]) {
        return NO;
    }
    if (self.date == nil && ((MAGDateSeparator*)object).date == nil) {
        return YES;
    }
    return [self.date isEqualToDate:((MAGDateSeparator*)object).date];
}

- (id<NSObject>)diffIdentifier {
    if (self.date) {
        return self.date;
    }
    return self;
}

@end
