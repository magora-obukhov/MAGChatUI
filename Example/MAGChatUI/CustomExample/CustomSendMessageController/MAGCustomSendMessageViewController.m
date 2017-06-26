//
//  MAGCustomSendMessageViewController.m
//  MAGChatUI
//
//  Created by user on 20.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGCustomSendMessageViewController.h"
#import "MAGChatMessageWithAvatar.h"

@interface MAGCustomSendMessageViewController () <UITextFieldDelegate>
- (IBAction)sendMessage:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sendMessageButton;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@end

@implementation MAGCustomSendMessageViewController
@synthesize delegate; //Don't forget it;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.messageTextField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)sendMessage:(id)sender {
    if ([self.delegate respondsToSelector:@selector(sendMessage:)] && self.messageTextField.text.length > 0) {
        MAGChatMessageWithAvatar* newMessage = [[MAGChatMessageWithAvatar alloc]init];
        newMessage.messageText = self.messageTextField.text;
        newMessage.avatar = [UIImage imageNamed:@"avatar2"];
        newMessage.senderTimeStamp = [NSDate date];
        [self.delegate sendMessage:newMessage];
        self.messageTextField.text = @"";
    }
    [self.messageTextField resignFirstResponder];
}

-(void)textFieldDidChange:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        self.sendMessageButton.enabled = NO;
    } else {
        self.sendMessageButton.enabled = YES;
    }
}

@end
