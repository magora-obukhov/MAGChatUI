//
//  MAGDateSeparatorCell.m
//  MAGChatUI
//
//  Created by user on 15.06.17.
//  Copyright © 2017 Magora Systems. All rights reserved.
//

#import "MAGDateSeparatorCell.h"

@interface MAGDateSeparatorCell()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation MAGDateSeparatorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDate:(NSDate *)date{
    NSString *dateString = [NSDateFormatter localizedStringFromDate:date
                                                          dateStyle:NSDateFormatterLongStyle
                                                          timeStyle:NSDateFormatterNoStyle];
    _dateLabel.text = dateString;
    _date = date;
}

@end
