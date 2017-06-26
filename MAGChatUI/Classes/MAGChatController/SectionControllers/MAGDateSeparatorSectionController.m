//
//  MAGDateSeparatorSectionController.m
//  MAGChatUI
//
//  Created by user on 15.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGDateSeparatorSectionController.h"
#import "MAGDateSeparatorCell.h"
#import "MAGDateSeparator.h"

@implementation MAGDateSeparatorSectionController

- (NSInteger)numberOfItems {
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 20);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    NSBundle *bundle = [NSBundle bundleForClass:[MAGDateSeparatorCell class]];
    MAGDateSeparatorCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"MAGDateSeparatorCell" bundle:bundle forSectionController:self atIndex:index];
    cell.date = self.date;
    return cell;
}

- (void)didUpdateToObject:(id)object {
    self.date = ((MAGDateSeparator*)object).date;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
}

@end
