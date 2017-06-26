//
//  MAGNewMessagesSeparatorSectionController.m
//  MAGChatUI
//
//  Created by user on 15.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGNewMessagesSeparatorSectionController.h"
#import "MAGNewMessagesSeparatorCell.h"

@implementation MAGNewMessagesSeparatorSectionController

- (NSInteger)numberOfItems {
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 20);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    NSBundle *bundle = [NSBundle bundleForClass:[MAGNewMessagesSeparatorCell class]];
    MAGNewMessagesSeparatorCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"MAGNewMessagesSeparatorCell" bundle:bundle forSectionController:self atIndex:index];
    return cell;
}


- (void)didSelectItemAtIndex:(NSInteger)index {
    
}
@end
