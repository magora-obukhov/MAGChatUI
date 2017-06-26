//
//  MAGMessageSectionController.m
//  MAGChatUI
//
//  Created by Stanislav on 06.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGTextMessageSectionController.h"
#import "MAGTextMessageCell.h"

@implementation MAGTextMessageSectionController

- (NSInteger)numberOfItems {
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, [MAGTextMessageCell cellHeightForMessage:self.message]);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    MAGTextMessageCell *cell;
    if (self.message.selfMessage){
        NSBundle *bundle = [NSBundle bundleForClass:[MAGTextMessageCell class]];
        cell = [self.collectionContext dequeueReusableCellWithNibName:@"MAGTextMessageSelfCell"
                                                              bundle:bundle
                                                forSectionController:self
                                                             atIndex:index];
    } else {
        NSBundle *bundle = [NSBundle bundleForClass:[MAGTextMessageCell class]];
        cell = [self.collectionContext dequeueReusableCellWithNibName:@"MAGTextMessageCell"
                                                               bundle:bundle
                                                 forSectionController:self
                                                              atIndex:index];
    }
    
    cell.message = self.message;
    return cell;
}

- (void)didUpdateToObject:(id)object {
    self.message = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
}

@end
