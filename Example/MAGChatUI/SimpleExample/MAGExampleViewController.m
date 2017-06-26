//
//  MAGExampleViewController.m
//  MAGChatUI
//
//  Created by Stanislav on 06.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGExampleViewController.h"
#import "MAGSendMessageViewController.h"

@interface MAGExampleViewController () <MAGChatViewControllerDelegate>
- (IBAction)startChat:(id)sender;

@end

@implementation MAGExampleViewController
{
    NSUInteger testMessageCount;
    MAGChatPerson *person1;
    MAGChatPerson *person2;
    MAGChatViewController *chatViewController;
    NSTimer* spamtimer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    testMessageCount = 10000;
    person1 = [[MAGChatPerson alloc] init];
    person2 = [[MAGChatPerson alloc] init];
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
    chatViewController.delegate = self;
    [self.navigationController pushViewController:chatViewController animated:YES];
    [self startSpam];
}

#pragma mark - MAGChatViewControllerDelegate

- (void)messageDidCreate:(MAGChatMessage *)message {
    NSLog(@"messageDidCreate");
    message.messageText = [NSString stringWithFormat:@"%@_upd",message.messageText];
    [chatViewController updateMessage:message];
}

- (void)messageDidDelete:(MAGChatMessage *)message {
    NSLog(@"messageDidDelete");
}

- (void)messageDidEdit:(MAGChatMessage *)message {
    NSLog(@"messageDidEdit");
}

- (void)needMessagesOffsetBy:(MAGChatMessage *)message {
    NSMutableArray *testMessages = [[NSMutableArray alloc]init];
    [testMessages addObject:[self testMessageForPerson:person1]];
    [testMessages addObject:[self testMessageForPerson:person2]];
    [chatViewController updateMessages:testMessages];
    chatViewController.isLoading = NO;
}

- (MAGChatMessage *)testMessageForPerson:(MAGChatPerson *)person {
    MAGChatMessage *message = [[MAGChatMessage alloc] init];
    message.sender = person;
    message.messageText = [NSString stringWithFormat:@"message %ld",(long)testMessageCount];
    testMessageCount--;
    message.identifier = [NSString stringWithFormat:@"%ld",(long)testMessageCount];
    //    message.serverTimeStamp = [NSDate date];
    //    message.receivedTimeStamp = [NSDate date];
    //    message.senderTimeStamp = [NSDate date];
    
    message.serverTimeStamp = [NSDate dateWithTimeIntervalSinceReferenceDate:testMessageCount];
    message.receivedTimeStamp = [NSDate dateWithTimeIntervalSinceReferenceDate:testMessageCount];
    message.senderTimeStamp = [NSDate dateWithTimeIntervalSinceReferenceDate:testMessageCount];
    return message;
}

- (MAGChatMessage *)testNewMessageForPerson:(MAGChatPerson *)person {
    MAGChatMessage *message = [[MAGChatMessage alloc] init];
    message.sender = person;
    message.messageText = [NSString stringWithFormat:@"sagemes sagemessa gessagem%ld",(long)testMessageCount];
    testMessageCount--;
    message.identifier = [NSString stringWithFormat:@"%ld",(long)testMessageCount];
        message.serverTimeStamp = [NSDate dateWithTimeIntervalSinceNow:(10000 - testMessageCount)*40000];
        message.receivedTimeStamp = [NSDate dateWithTimeIntervalSinceNow:(10000 - testMessageCount)*40000];
        message.senderTimeStamp = [NSDate dateWithTimeIntervalSinceNow:(10000 - testMessageCount)*40000];
    message.unRead = YES;
    return message;
}

- (void)startSpam {
    spamtimer = [NSTimer scheduledTimerWithTimeInterval:2.5
                                     target:self
                                   selector:@selector(spamTimerTick:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void) spamTimerTick:(NSTimer *)timer {
    [chatViewController updateMessage:[self testNewMessageForPerson:person2]];
    if ([chatViewController isTyping]){
        [chatViewController setIsTyping:NO];
    } else {
        [chatViewController setIsTyping:YES];
    }
}

@end
