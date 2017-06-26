//
//  MAGCustomExampleViewController.m
//  MAGChatUI
//
//  Created by user on 19.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGCustomExampleViewController.h"
#import "MAGCustomSendMessageViewController.h"
#import "MAGChatMessageWithAvatarSectionController.h"
#import "MAGChatMessageWithAvatar.h"

@interface MAGCustomExampleViewController () <MAGChatViewControllerDelegate>
- (IBAction)startChat:(id)sender;
@end

@implementation MAGCustomExampleViewController
{
    MAGChatPerson *companion;
    MAGChatPerson *user;
    MAGChatViewController *chatViewController;
    NSTimer* spamtimer;
    NSUInteger testMessageCount;
    NSUInteger historyMessageCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    testMessageCount = 0;
    historyMessageCount = 0;
    companion = [[MAGChatPerson alloc] init];
    user = [[MAGChatPerson alloc] init];
    
}

#pragma mark - setupUI

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)startChat:(id)sender {
    [self setupChatController];
}

- (void)setupChatController {
    NSBundle *bundle = [NSBundle bundleForClass:[MAGChatViewController class]];
    chatViewController = [[MAGChatViewController alloc]initWithNibName:@"MAGChatViewController" bundle:bundle];
    [self registerCustomClasses];
    chatViewController.delegate = self;
    [self.navigationController pushViewController:chatViewController animated:YES];
    [self startSpam];
}

- (void)registerCustomClasses{
    [chatViewController registerMessageSectionControllerClass:[MAGChatMessageWithAvatarSectionController class] forMessageClass:[MAGChatMessageWithAvatar class]];
    [chatViewController registerSendMsgViewControllerClass:[MAGCustomSendMessageViewController class]];
}

- (void)needMessagesOffsetBy:(MAGChatMessage *)message {
    [self performSelector:@selector(moreMessagesDidLoad) withObject:nil afterDelay:2];
}

#pragma mark - MAGChatViewControllerDelegate

- (void)messageDidCreate:(MAGChatMessage *)message {
    NSLog(@"messageDidCreate");
}

#pragma mark - optional

- (void)messageDidEdit:(MAGChatMessage *)message {
    NSLog(@"messageDidEdit");
}

- (void)messageDidDelete:(MAGChatMessage *)message {
    NSLog(@"messageDidDelete");
}


#pragma mark - example messages generating

- (MAGChatMessage *)testMessageOfCompanion {
    MAGChatMessageWithAvatar *message = [[MAGChatMessageWithAvatar alloc] init];
    message.sender = companion;
    message.messageText = [NSString stringWithFormat:@"Hello !!!"];
    testMessageCount++;
    message.identifier = [NSString stringWithFormat:@"%ld",(long)testMessageCount];
    message.serverTimeStamp = [NSDate date];
    message.receivedTimeStamp = [NSDate date];
    message.senderTimeStamp = [NSDate date];
    message.unRead = YES;
    message.avatar = [UIImage imageNamed:@"avatar1"];
    return message;
}

- (void)startSpam {
    spamtimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                 target:self
                                               selector:@selector(spamTimerTick:)
                                               userInfo:nil
                                                repeats:YES];
}

- (void) spamTimerTick:(NSTimer *)timer {
    if ([chatViewController isTyping]){
        [chatViewController setIsTyping:NO];
        [chatViewController updateMessage:[self testMessageOfCompanion]];
    } else {
        [chatViewController setIsTyping:YES];
    }
}

- (void)moreMessagesDidLoad{
    chatViewController.isLoading = NO;
    MAGChatMessageWithAvatar *message = [[MAGChatMessageWithAvatar alloc] init];
    message.sender = companion;
    message.messageText = [NSString stringWithFormat:@"Message from history"];
    historyMessageCount++;
    message.identifier = [NSString stringWithFormat:@"history%ld",(long)historyMessageCount];
    NSTimeInterval interval = historyMessageCount * 50000;
    NSDate* date = [[NSDate date] dateByAddingTimeInterval:-interval];
    message.serverTimeStamp = date;
    message.receivedTimeStamp = date;
    message.senderTimeStamp = date;
    
    message.unRead = NO;
    message.avatar = [UIImage imageNamed:@"avatar1"];
    [chatViewController updateMessage:message];
}

@end
