//
//  MAGIsTypingObject.m
//  MAGChatUI
//
//  Created by user on 15.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGIsTypingObject.h"

@implementation MAGIsTypingObject

-(BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object{
    return [self isEqual:object];
}

- (id<NSObject>)diffIdentifier {
    return self;
}

@end
