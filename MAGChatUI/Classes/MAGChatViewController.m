//
//  MAGChatViewController.m
//  MAGChatUI
//
//  Created by Stanislav on 08.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGChatViewController.h"
#import "MAGChatController.h"
#import "MAGSendMessageViewController.h"
#import "MAGSendMessageViewControllerProtocol.h"

@interface MAGChatViewController () <UITextViewDelegate,MAGChatControllerDelegate,MAGSendMessageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *sendMessageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendMessageConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendMessageConstraintHeightEqual;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendMessageBottomConstraint;

@end

@implementation MAGChatViewController
{
    Class sendMessageViewClass;
    MAGChatController *chatController;
    UIViewController<MAGSendMessageViewControllerProtocol> *sendMessageViewController;
}

//- (instancetype)init {
//    
//    self = [super initWithNibName:@"MAGChatViewController" bundle:NSBundle.mainBundle];
//    if (self) {
//        
//    }
//    return self;
//}

//-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    NSLog(@"");
//    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSendMessageViewWithClass:sendMessageViewClass];
    [self loadChatController];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (sendMessageViewController == nil) {
        [self registerSendMsgViewControllerClass:[MAGSendMessageViewController class]];
    }
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"viewWillLayoutSubviews ChatVC");
}

- (void)loadSendMessageViewWithClass:(Class)sendMsgViewControllerClass{
    if (sendMsgViewControllerClass != Nil) {
        [sendMessageViewController.view removeFromSuperview];
        [sendMessageViewController removeFromParentViewController];
        NSBundle *bundle = [NSBundle bundleForClass:sendMsgViewControllerClass];
        sendMessageViewController = [[sendMsgViewControllerClass alloc]initWithNibName:NSStringFromClass(sendMsgViewControllerClass) bundle:bundle];
        [self addChildViewController:sendMessageViewController];
        [_sendMessageView addSubview:sendMessageViewController.view];
        [sendMessageViewController didMoveToParentViewController:self];
        
        NSArray *horzConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[sendMsgView]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"sendMsgView" : sendMessageViewController.view}];

        NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[sendMsgView]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:@{@"sendMsgView" : sendMessageViewController.view}];
        
        [self.sendMessageView removeConstraint:self.sendMessageConstraintHeightEqual];
        [self.sendMessageView addConstraints:verticalConstraints];
        [self.sendMessageView addConstraints:horzConstraints];
        sendMessageViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        if ([sendMessageViewController respondsToSelector:@selector(setDelegate:)]){
            sendMessageViewController.delegate = self;
        }
    }
}


- (void)loadChatController{
    self.chatCollectionView.alwaysBounceVertical = YES;
    self.chatCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    chatController = [[MAGChatController alloc]initWithCollectionView:self.chatCollectionView viewController:self];
}


#pragma mark - MAGChatController 

- (void)updateMessage:(MAGChatMessage *)message{
    [chatController updateMessage:message];
}


- (void)updateMessages:(NSArray<MAGChatMessage *> *)messages{
    [chatController updateMessages:messages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)needMessagesOffsetBy:(MAGChatMessage *)message{
    if ([self.delegate respondsToSelector:@selector(needMessagesOffsetBy:)]){
        [self.delegate needMessagesOffsetBy:message];
    }
}

#pragma mark - registering custom classes

- (void)registerMessageSectionControllerClass:(Class)sectionControllerClass forMessageClass:(Class)messageClass {
    [self view];
    [chatController registerMessageSectionControllerClass:sectionControllerClass forMessageClass:messageClass];
}

- (void)registerSendMsgViewControllerClass:(Class)sendMsgViewControllerClass {
    [self view];
    UIViewController* testController = [[sendMsgViewControllerClass alloc] init];
    if ([testController conformsToProtocol:@protocol(MAGSendMessageViewControllerProtocol)]) {
        if ([testController respondsToSelector:@selector(setDelegate:)]){
            sendMessageViewClass = sendMsgViewControllerClass;
            [self loadSendMessageViewWithClass:sendMessageViewClass];
        }
    }
}

- (void)registerDateSeparatorSectionControllerClass:(Class)dateSeparatorSectionControllerClass{
    [self view];
    [chatController registerDateSeparatorSectionControllerClass:dateSeparatorSectionControllerClass];
}

- (void)registerNewMessagesSeparatorSectionControllerClass:(Class)newMessagesSeparatorSectionControllerClass{
    [self view];
    [chatController registerNewMessagesSeparatorSectionControllerClass:newMessagesSeparatorSectionControllerClass];
}

- (void)registerLoadingSectionControllerClass:(Class)loadingSectionControllerClass{
    [self view];
    [chatController registerLoadingSectionControllerClass:loadingSectionControllerClass];
}

- (void)registerIsTypingSectionControllerClass:(Class)isTypingSectionControllerClass{
    [self view];
    [chatController registerIsTypingSectionControllerClass:isTypingSectionControllerClass];
}

- (void)setDelegate:(id<MAGChatViewControllerDelegate>)delegate {
    _delegate = delegate;
    [self view];
    chatController.delegate = self;
}


#pragma mark - MAGSendMessageViewControllerDelegate

- (void)sendMessage:(MAGChatMessage *)message {
    message.localIdentifier = [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSinceReferenceDate]];
    message.senderTimeStamp = [NSDate date];
    message.selfMessage = YES;
    [chatController updateMessage:message];
    if ([self.delegate respondsToSelector:@selector(messageDidCreate:)]) {
        [self.delegate messageDidCreate:message];
    }
}


#pragma mark - keyboard notifications

- (void)keyboardWillHide:(NSNotification *)notification
{
    _sendMessageBottomConstraint.constant = 0;
    [self.view layoutIfNeeded];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary* userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    _sendMessageBottomConstraint.constant = keyboardSize.height;
    [self.view layoutIfNeeded];
}

- (void)setIsLoading:(BOOL)isLoading {
    [chatController setLoading:isLoading];
}

- (BOOL)isLoading {
    return [chatController isLoading];
}

- (void)setIsTyping:(BOOL)isTyping {
    [chatController setIsTyping:isTyping];
}

- (BOOL)isTyping {
    return [chatController isTyping];
}

@end
