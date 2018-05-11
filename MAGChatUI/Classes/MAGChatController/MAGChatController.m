//
//  MAGChatController.m
//  MAGChatUI
//
//  Created by Stanislav on 06.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGChatController.h"
#import "MAGTextMessageSectionController.h"
#import "MAGNewMessageSeparator.h"
#import "MAGDateSeparator.h"

@interface MAGChatController() <IGListAdapterDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) IGListAdapter *adapter;
@property (nonatomic, weak) UIViewController *viewController;
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic) MAGChatConversation *conversation;
@end

@implementation MAGChatController
{
    MAGSectionControllersMapper* sectionClassMapper;
    MAGLoadingObject* loadingSection;
    MAGIsTypingObject* isTypingSection;
    MAGNewMessageSeparator *newMessageSeparator;
    BOOL stickedToBottom;
}

- (id)initWithCollectionView:(UICollectionView*)collectionView viewController:(UIViewController*)viewController {
    self = [super init];
    if(self) {
        stickedToBottom = YES;
        sectionClassMapper = [[MAGSectionControllersMapper alloc]init];
        newMessageSeparator = [[MAGNewMessageSeparator alloc] init];
        [self registerDefaultSectionControllers];
        self.viewController = viewController;
        self.adapter.collectionView = collectionView;
    }
    return self;
}

- (IGListAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init]
                                           viewController:self.viewController
                                         workingRangeSize:0];
    }
    return _adapter;
}

#pragma mark - IGListAdapterDataSource

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    NSMutableArray *items = [self messagesWithSeparators:[self.conversation.messages mutableCopy]];
    
    if (self.isLoading) {
        loadingSection = [[MAGLoadingObject alloc]init];
        [items insertObject:loadingSection atIndex:0];
    } else {
        [items removeObject:loadingSection];
    }
    
    if (self.isTyping){
        isTypingSection = [[MAGIsTypingObject alloc]init];
        [items addObject:isTypingSection];
    } else {
        [items removeObject:isTypingSection];
    }
    return items;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    if ([object isKindOfClass:[MAGLoadingObject class]]) {
        return [[[sectionClassMapper loadingSectionControllerClass] alloc]init];
    }
    if ([object isKindOfClass:[MAGIsTypingObject class]]) {
        return [[[sectionClassMapper isTypingSectionControllerClass] alloc]init];
    }
    if ([object isKindOfClass:[MAGDateSeparator class]]) {
        return [[[sectionClassMapper dateSeparatorSectionControllerClass] alloc]init];
    }
    if ([object isKindOfClass:[MAGNewMessageSeparator class]]) {
        return [[[sectionClassMapper newMessagesSeparatorSectionControllerClass] alloc]init];
    }
    Class sectionControllerClass = [sectionClassMapper sectionControllerForMessageClass:[object class]];
    if (sectionControllerClass != Nil) {
        return [[sectionControllerClass alloc]init];
    }
    return [[MAGTextMessageSectionController alloc] init];
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

- (NSMutableArray*)messagesWithSeparators:(NSMutableArray<MAGChatMessage *> *)messages{
    NSMutableArray *messagesWithSeparators = [[NSMutableArray alloc]init];
    NSDate *previousDate = [NSDate dateWithTimeIntervalSince1970:0];
    BOOL newMessagesSeparatorWasSet = NO;
    for (MAGChatMessage* message in messages){
        NSDate* messageDate;
        if (message.serverTimeStamp) {
            messageDate = message.serverTimeStamp;
        } else {
            messageDate = message.senderTimeStamp;
        }
        if (messageDate) {
            if (![[NSCalendar currentCalendar] isDate:previousDate inSameDayAsDate:messageDate]) {
                previousDate = messageDate;
                MAGDateSeparator *dateSeparator = [[MAGDateSeparator alloc] init];
                dateSeparator.date = messageDate;
                [messagesWithSeparators addObject:dateSeparator];
            }
            if (message.unRead && !newMessagesSeparatorWasSet) {
                newMessagesSeparatorWasSet = YES;
                [messagesWithSeparators addObject:newMessageSeparator];
            }
        }
        [messagesWithSeparators addObject:message];
    }
    return messagesWithSeparators;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView.contentOffset.y < __MAGScrollStartUpdateOffset) {
        if (!self.isLoading){
            self.loading = YES;
            [self performCollectionUpdates];
        }
        [self requestSourceForMoreMessages];
    }
}

- (void)scrollToBottomIfSticked {
    CGFloat scrollHeight = self.adapter.collectionView.contentSize.height + self.adapter.collectionView.contentInset.top;
    if (scrollHeight > self.adapter.collectionView.bounds.size.height) {
        if (stickedToBottom) {
            CGFloat bottomOffsetY = self.adapter.collectionView.contentSize.height - self.adapter.collectionView.bounds.size.height;// + self.adapter.collectionView.contentInset.top;
            if (bottomOffsetY > self.adapter.collectionView.contentOffset.y) {
                [self.adapter.collectionView setContentOffset:CGPointMake(self.adapter.collectionView.contentOffset.x, bottomOffsetY) animated:YES];
            }
        }
    }
}

- (void)stickedStateUpdate {
    NSArray* visibleObjects = [self.adapter visibleObjects];
    if ([visibleObjects containsObject:[self.conversation.messages lastObject]]) {
        stickedToBottom = YES;
    } else {
        stickedToBottom = NO;
    }
}



- (void)registerDefaultSectionControllers{
    [self registerMessageSectionControllerClass:[MAGTextMessageSectionController class] forMessageClass:[MAGChatMessage class]];
}

#pragma mark - registering custom classes

- (void)registerMessageSectionControllerClass:(Class)sectionControllerClass forMessageClass:(Class)messageClass{
    [sectionClassMapper mapSectionControllerClass:sectionControllerClass forMessageClass:messageClass];
}

- (void)registerDateSeparatorSectionControllerClass:(Class)dateSeparatorSectionControllerClass{
    [sectionClassMapper setDateSeparatorSectionControllerClass:dateSeparatorSectionControllerClass];
}

- (void)registerNewMessagesSeparatorSectionControllerClass:(Class)newMessagesSeparatorSectionControllerClass{
    [sectionClassMapper setNewMessagesSeparatorSectionControllerClass:newMessagesSeparatorSectionControllerClass];
}

- (void)registerLoadingSectionControllerClass:(Class)loadingSectionControllerClass{
    [sectionClassMapper setLoadingSectionControllerClass:loadingSectionControllerClass];
}

- (void)registerIsTypingSectionControllerClass:(Class)isTypingSectionControllerClass{
    [sectionClassMapper setIsTypingSectionControllerClass:isTypingSectionControllerClass];
}

- (void)updateMessage:(MAGChatMessage *)message {
    [self stickedStateUpdate];
    [self.conversation updateMessage:message];
    [self performCollectionUpdates];
}

- (void)updateMessages:(NSArray<MAGChatMessage *> *)messages {
    [self stickedStateUpdate];
    [messages enumerateObjectsUsingBlock:^(MAGChatMessage *messageObj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.conversation updateMessage:messageObj];
    }];
        [self performCollectionUpdates];
}

- (void)requestSourceForMoreMessages {
    if ([self.delegate respondsToSelector:@selector(needMessagesOffsetBy:)]){
        [self.delegate needMessagesOffsetBy:[self.conversation.messages firstObject]];
    }
}

- (void)setDelegate:(id<MAGChatControllerDelegate>)delegate{
    _delegate = delegate;
    self.adapter.dataSource = self;
    self.adapter.scrollViewDelegate = self;
}

- (MAGChatConversation *)conversation {
    if (!_conversation) {
        _conversation = [[MAGChatConversation alloc]init];
        [self requestSourceForMoreMessages];
    }
    return _conversation;
}

- (void)performCollectionUpdates {
    dispatch_async(dispatch_get_main_queue(), ^{
         [self.adapter performUpdatesAnimated:YES completion:^(BOOL finished) {
             [self scrollToBottomIfSticked];
         }];
    });
}

- (void)setLoading:(BOOL)loading {
    _loading = loading;
    [self performCollectionUpdates];
}

- (void)setIsTyping:(BOOL)isTyping {
    _isTyping = isTyping;
    [self performCollectionUpdates];
}

@end
