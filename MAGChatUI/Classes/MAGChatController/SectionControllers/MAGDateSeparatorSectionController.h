//
//  MAGDateSeparatorSectionController.h
//  MAGChatUI
//
//  Created by user on 15.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import "MAGDateSeparator.h"
#import <UIKit/UIKit.h>

@interface MAGDateSeparatorSectionController : IGListSectionController
@property (nonatomic,weak) NSDate *date;
@end
