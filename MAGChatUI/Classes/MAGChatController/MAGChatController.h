//
//  MAGChatController.h
//  MAGChatUI
//
//  Created by Stanislav on 06.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>
#import "MAGChatConversation.h"
#import "MAGLoadingObject.h"
#import "MAGLoadingSectionController.h"
#import "MAGChatMessage.h"
#import "MAGChatPerson.h"
#import "MAGIsTypingObject.h"
#import "MAGIsTypingSectionController.h"
#import "MAGSectionControllersMapper.h"
#import "MAGChatViewController.h"

@protocol MAGChatControllerDelegate <NSObject>
- (void)needMessagesOffsetBy:(MAGChatMessage *)message;
@end

@interface MAGChatController : NSObject
- (id)initWithCollectionView:(UICollectionView *)collectionView viewController:(UIViewController *)viewController;
- (void)updateMessage:(MAGChatMessage *)message;
- (void)updateMessages:(NSArray<MAGChatMessage *> *)messages;
- (void)registerMessageSectionControllerClass:(Class)sectionControllerClass forMessageClass:(Class)messageClass;

// Custom separators
- (void)registerDateSeparatorSectionControllerClass:(Class)dateSeparatorSectionControllerClass;
- (void)registerNewMessagesSeparatorSectionControllerClass:(Class)newMessagesSeparatorSectionControllerClass;

// Additional custom cells
- (void)registerLoadingSectionControllerClass:(Class)loadingSectionControllerClass;
- (void)registerIsTypingSectionControllerClass:(Class)isTypingSectionControllerClass;

@property (nonatomic, assign, getter=isLoading) BOOL loading;
@property (nonatomic, assign) BOOL isTyping;
@property (weak, nonatomic) id<MAGChatControllerDelegate> delegate;
@end
