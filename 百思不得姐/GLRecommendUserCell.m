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
    self.fansCountLabel.text = [NSString stringWithFormat:@"%ld人关注", (long)user.fans_count];
    [self.headerImageView sd_setImageWithURL:user.header placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
