//
//  MAGMessageWithAvatarCell.m
//  MAGChatUI
//
//  Created by user on 19.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGMessageWithAvatarCell.h"

@interface MAGMessageWithAvatarCell()
@property (weak, nonatomic) IBOutlet UILabel *messageText;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@end

@implementation MAGMessageWithAvatarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMessage:(MAGChatMessageWithAvatar *)message{
    _message = message;
    _messageText.text = message.messageText;
    _avatarImage.image = message.avatar;
}

+ (CGFloat)cellHeightForMessage:(MAGChatMessageWithAvatar *)message{
    UIFont *font = [UIFont systemFontOfSize:17];
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGFloat messageTextWidth = [UIScreen mainScreen].bounds.size.width - (8 * 3) - 50;
    CGRect rect = [message.messageText boundingRectWithSize:CGSizeMake(messageTextWidth, CGFLOAT_MAX)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:attributes
                                                    context:nil];
    if (rect.size.height < (50 - 16)) {
        return 50 + 16;
    }
    return rect.size.height + 16 + 16;
    
}

@end
