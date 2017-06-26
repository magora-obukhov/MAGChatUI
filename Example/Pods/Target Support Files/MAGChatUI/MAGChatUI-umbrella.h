#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MAGChatConversation.h"
#import "NSMutableArray+MAGMessagesArray.h"
#import "MAGChatImageMessage.h"
#import "MAGChatMessage.h"
#import "MAGChatPerson.h"
#import "MAGDateSeparator.h"
#import "MAGIsTypingObject.h"
#import "MAGLoadingObject.h"
#import "MAGNewMessageSeparator.h"
#import "MAGDateSeparatorCell.h"
#import "MAGIsTypingCell.h"
#import "MAGLoadingCell.h"
#import "MAGNewMessagesSeparatorCell.h"
#import "MAGTextMessageCell.h"
#import "MAGChatController.h"
#import "MAGSectionControllersMapper.h"
#import "MAGSectionToMessageMapItem.h"
#import "MAGDateSeparatorSectionController.h"
#import "MAGIsTypingSectionController.h"
#import "MAGLoadingSectionController.h"
#import "MAGNewMessagesSeparatorSectionController.h"
#import "MAGImageMessageSectionController.h"
#import "MAGTextMessageSectionController.h"
#import "MAGChatViewController.h"
#import "MAGSendMessageViewController.h"
#import "MAGSendMessageViewControllerProtocol.h"

FOUNDATION_EXPORT double MAGChatUIVersionNumber;
FOUNDATION_EXPORT const unsigned char MAGChatUIVersionString[];

