//
//  colorCell.m
//  iPainter
//
//  Created by eric on 13-11-7.
//  Copyright (c) 2013年 eric. All rights reserved.
//

#import "colorCell.h"

@implementation colorCell
@synthesize color;
@synthesize colorName;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        colorName=[[UILabel alloc] init];
        [self.contentView addSubview:colorName];
        color=[[UIView alloc] init];
        [self.contentView addSubview:color];
        colorName.font=[UIFont fontWithName:colorName.font.fontName size:12];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    color.frame=CGRectMake(10, 15, self.frame.size.width/3-10, self.frame.size.height-30);
    colorName.frame=CGRectMake(self.frame.size.width/3+10, 5, 2*self.frame.size.width/2-15,  self.frame.size.height-10);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
