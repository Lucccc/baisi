//
//  GLRecommendUserCell.m
//  百思不得姐
//
//  Created by Lucccc on 16/4/28.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLRecommendUserCell.h"
#import "GLRecommendUser.h"
#import <UIImageView+WebCache.h>
@interface GLRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation GLRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setUser:(GLRecommendUser *)user{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    
    NSString *subNumber = nil;
    if(user.fans_count < 10000){
        subNumber = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    }else{
        subNumber = [NSString stringWithFormat:@"%.1f万人关注",user.fans_count/10000.0];
    }
    self.fansCountLabel.text = subNumber;
    [self.headerImageView sd_setImageWithURL:user.header placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
