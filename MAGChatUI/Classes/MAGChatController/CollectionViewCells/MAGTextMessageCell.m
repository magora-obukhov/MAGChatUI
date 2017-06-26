//
//  MAGTextMessageCell.m
//  MAGChatUI
//
//  Created by Stanislav on 06.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGTextMessageCell.h"

@interface MAGTextMessageCell()
@property (weak, nonatomic) IBOutlet UILabel *messageText;
@property (weak, nonatomic) IBOutlet UILabel *senderUserName;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation MAGTextMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMessage:(MAGChatMessage *)message{
    _message = message;
    _messageText.text = message.messageText;
    _senderUserName.text = message.sender.name;
}

+ (CGFloat)cellHeightForMessage:(MAGChatMessage *)message{
    UIFont *font = [UIFont systemFontOfSize:17];
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGFloat messageTextWidth = [UIScreen mainScreen].bounds.size.width - 16;
    CGRect rect = [message.messageText boundingRectWithSize:CGSizeMake(messageTextWidth, CGFLOAT_MAX)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:attributes
                                                      context:nil];
    
    return rect.size.height + 16 + 41;
}

@end
