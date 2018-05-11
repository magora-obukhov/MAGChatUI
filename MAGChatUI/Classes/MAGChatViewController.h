//
//  MAGChatViewController.h
//  MAGChatUI
//
//  Created by Stanislav on 08.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAGChatMessage.h"
#define __MAGScrollStickingDistance 300
#define __MAGScrollStartUpdateOffset -100
@protocol MAGSendMessageViewControllerProtocol;

@protocol MAGChatViewControllerDelegate <NSObject>
@required
- (void)needMessagesOffsetBy:(MAGChatMessage *)message;
- (void)messageDidCreate:(MAGChatMessage *)message;
@optional
- (void)messageDidEdit:(MAGChatMessage *)message;
- (void)messageDidDelete:(MAGChatMessage *)message;
@end

@interface MAGChatViewController : UIViewController
// Add new or update message
- (void)updateMessage:(MAGChatMessage *)message;
- (void)updateMessages:(NSArray<MAGChatMessage *> *)messages;

// Custom messages (required: sectionControllerClass, messageClass and UICollectionViewCell for each type of message)
- (void)registerMessageSectionControllerClass:(Class)sectionControllerClass forMessageClass:(Class)messageClass;

// Custom enter message ViewController
- (void)registerSendMsgViewControllerClass:(Class)sendMsgViewControllerClass;

// Custom separators
- (void)registerDateSeparatorSectionControllerClass:(Class)dateSeparatorSectionControllerClass;
- (void)registerNewMessagesSeparatorSectionControllerClass:(Class)newMessagesSeparatorSectionControllerClass;
- (void)loadSendMessageViewWith: (UIViewController<MAGSendMessageViewControllerProtocol> *) sendMsgViewController;

// Additional custom cells
- (void)registerLoadingSectionControllerClass:(Class)loadingSectionControllerClass;
- (void)registerIsTypingSectionControllerClass:(Class)isTypingSectionControllerClass;

@property (nonatomic) BOOL isLoading;
@property (nonatomic) BOOL isTyping;
@property (weak, nonatomic) IBOutlet UICollectionView *chatCollectionView;
@property (weak, nonatomic) id<MAGChatViewControllerDelegate> delegate;
@end
