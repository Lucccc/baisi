//
//  GLRecommendTagCell.m
//  百思不得姐
//
//  Created by Lucccc on 16/4/28.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLRecommendTagCell.h"
#import "GLRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface GLRecommendTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation GLRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setRecommendTag:(GLRecommendTag *)recommendTag{
    _recommendTag = recommendTag;
    
    [self.imageListImageView sd_setImageWithURL:recommendTag.image_list placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.themeNameLabel.text = recommendTag.theme_name;
    
    NSString *subNumber = nil;
    if(recommendTag.sub_number < 10000){
        subNumber = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }else{
         subNumber = [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number/10000.0];
    }
    
    self.subNumberLabel.text = subNumber;
}

-(void)setFrame:(CGRect)frame{
    
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 2;
    [super setFrame:frame];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
