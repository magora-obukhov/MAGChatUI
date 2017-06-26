//
//  MAGSendMessageViewController.m
//  MAGChatUI
//
//  Created by Stanislav on 08.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGSendMessageViewController.h"
#define __MaximalSendMessageTextViewHeight 140

@interface MAGSendMessageViewController () <UITextViewDelegate>
- (IBAction)sendMessage:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sendMessageButton;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UIView *textBackView;

@end

@implementation MAGSendMessageViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageTextView.text = @"Введите сообщение";
    self.messageTextView.textColor = [UIColor lightGrayColor];
    self.sendMessageButton.enabled = NO;
    self.textBackView.layer.cornerRadius = 10;
    self.textBackView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.textBackView.layer.borderWidth = 1;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.contentSize.height <= __MaximalSendMessageTextViewHeight) {
       // textView.bounds.size.height = textView.contentSize.height
        CGRect bounds = textView.bounds;
        bounds.size.height = [textView sizeThatFits:textView.bounds.size].height;
        textView.bounds = bounds;
        textView.scrollEnabled = NO;
        [textView setContentOffset:CGPointZero];
        //[self.view setNeedsLayout];
       // [self.view layoutIfNeeded];
    } else {
        textView.scrollEnabled = YES;
    }
}

- (IBAction)sendMessage:(id)sender {
    if ([self.delegate respondsToSelector:@selector(sendMessage:)]) {
        MAGChatMessage* newMessage = [[MAGChatMessage alloc]init];
        newMessage.messageText = self.messageTextView.text;
        [self.delegate sendMessage:newMessage];
    }
    [self.messageTextView resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Введите сообщение"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        self.sendMessageButton.enabled = YES;
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Введите сообщение";
        textView.textColor = [UIColor lightGrayColor];
        self.sendMessageButton.enabled = NO;
    }
    [textView resignFirstResponder];
}
@end
