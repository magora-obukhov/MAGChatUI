//
//  MAGDateSeparator.h
//  MAGChatUI
//
//  Created by user on 15.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>

@interface MAGDateSeparator : NSObject <IGListDiffable>
@property (nonatomic) NSDate *date;
@end
