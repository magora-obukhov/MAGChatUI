//
//  MAGIsTypingSectionController.m
//  MAGChatUI
//
//  Created by user on 15.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGIsTypingSectionController.h"

@implementation MAGIsTypingSectionController

- (NSInteger)numberOfItems {
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 18);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    NSBundle *bundle = [NSBundle bundleForClass:[MAGIsTypingCell class]];
    MAGIsTypingCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"MAGIsTypingCell" bundle:bundle forSectionController:self atIndex:index];
    return cell;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
}

@end
