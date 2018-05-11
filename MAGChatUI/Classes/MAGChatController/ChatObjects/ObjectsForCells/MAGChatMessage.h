//
//  MAGChatMessage.h
//  MAGChatUI
//
//  Created by Stanislav on 06.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>
#import "MAGChatPerson.h"

@interface MAGChatMessage : NSObject <IGListDiffable>
@property (nonatomic) MAGChatPerson* sender;
@property (nonatomic) NSString* messageText;
@property (nonatomic) NSString* identifier;
@property (nonatomic) NSString* localIdentifier;
@property (nonatomic) NSDate* serverTimeStamp;
@property (nonatomic) NSDate* senderTimeStamp;
@property (nonatomic) NSDate* receivedTimeStamp;
@property (nonatomic) BOOL unRead;
@property (nonatomic) BOOL selfMessage;
@property (nonatomic) NSComparator comparator;
@end
