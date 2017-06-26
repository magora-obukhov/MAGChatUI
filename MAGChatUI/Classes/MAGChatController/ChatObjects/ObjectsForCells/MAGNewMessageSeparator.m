//
//  MAGNewMessageSeparator.m
//  MAGChatUI
//
//  Created by user on 15.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGNewMessageSeparator.h"

@implementation MAGNewMessageSeparator

-(BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object{
    return YES;
}

- (id<NSObject>)diffIdentifier {
    return self;
}

@end
