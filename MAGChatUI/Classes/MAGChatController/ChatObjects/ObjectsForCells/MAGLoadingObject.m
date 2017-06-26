//
//  MAGLoadingObject.m
//  MAGChatUI
//
//  Created by Stanislav on 06.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGLoadingObject.h"

@implementation MAGLoadingObject
-(BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object{
    return [self isEqual:object];
}

-(id<NSObject>)diffIdentifier{
    return self;
}
@end
