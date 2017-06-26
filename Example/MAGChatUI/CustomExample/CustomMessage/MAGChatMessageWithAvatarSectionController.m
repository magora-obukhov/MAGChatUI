//
//  MAGChatMessageWithAvatarSectionController.m
//  MAGChatUI
//
//  Created by user on 19.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGChatMessageWithAvatarSectionController.h"

@implementation MAGChatMessageWithAvatarSectionController

- (NSInteger)numberOfItems {
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, [MAGMessageWithAvatarCell cellHeightForMessage:self.message]);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell *cell;
    if (self.message.selfMessage){
    NSBundle *bundle = [NSBundle bundleForClass:[MAGMessageWithAvatarCell class]];
    cell = [self.collectionContext dequeueReusableCellWithNibName:@"MAGMessageWithAvatarSelfCell"
                                                                                 bundle:bundle
                                                                   forSectionController:self
                                                                                atIndex:index];
    } else {
    NSBundle *bundle = [NSBundle bundleForClass:[MAGMessageWithAvatarCell class]];
    cell = [self.collectionContext dequeueReusableCellWithNibName:@"MAGMessageWithAvatarCell"
                                                                                 bundle:bundle
                                                                   forSectionController:self
                                                                                atIndex:index];
    
    }
    ((MAGMessageWithAvatarCell *)cell).message = self.message;
    return cell;
}

- (void)didUpdateToObject:(id)object {
    self.message = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
}

@end
