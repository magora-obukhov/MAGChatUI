//
//  MAGLoadingSectionController.m
//  MAGChatUI
//
//  Created by Stanislav on 06.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGLoadingSectionController.h"

@implementation MAGLoadingSectionController

- (NSInteger)numberOfItems {
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 55);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    NSBundle *bundle = [NSBundle bundleForClass:[MAGLoadingCell class]];
    MAGLoadingCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"MAGLoadingCell" bundle:bundle forSectionController:self atIndex:index];
    return cell;
}

//- (void)didUpdateToObject:(id)object {
//}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
}

@end
