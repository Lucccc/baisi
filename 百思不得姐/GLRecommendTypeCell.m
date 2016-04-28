//
//  GLRecommendTypeCell.m
//  百思不得姐
//
//  Created by Lucccc on 16/4/28.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLRecommendTypeCell.h"
#import "GLRecommendCategory.h"

@interface GLRecommendTypeCell ()
/**
 *  选中时的显示控件
 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation GLRecommendTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor =GLRGBColor(244, 244, 244);
    self.textLabel.textColor = GLRGBColor(78, 78, 78);
   // self.textLabel.highlightedTextColor = GLRGBColor(219, 21, 26);
    
    UIView *bg = [[UIView alloc]init];
    bg.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = bg;
    
}

-(void)setCategory:(GLRecommendCategory *)category{
    _category = category;
    self.textLabel.text = category.name;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    //重新调整textlabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 *self.textLabel.y;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected? GLRGBColor(219, 21, 26):GLRGBColor(78, 78, 78);
}
@end
