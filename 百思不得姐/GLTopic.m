//
//  GLTopic.m
//  百思不得姐
//
//  Created by Lucccc on 16/5/16.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import "GLTopic.h"


@implementation GLTopic
{
    CGFloat _cellHeight;
    CGRect _pictureViewFrame;
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}

-(CGFloat)cellHeight{
    if (!_cellHeight) {
        //文字最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * GLTopicMargin, MAXFLOAT);
        
        //计算文字高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        
        //cell的高度
        _cellHeight = GLTopicCellTextY + textH + GLTopicCellBottomBarH + 3 * GLTopicMargin ;
        
        //根据段子的类型来计算cell的高度
        if (self.type == GLTopicTypePicture) {//图片帖子
            //图片显示出来的宽度
            CGFloat imageW = maxSize.width;
            //图片显示出来的高度
            CGFloat imageH = imageW * self.height / self.width;
            if (imageH >= GLTopicCellPictureMaxH) {//图片过长
                imageH = GLTopicCellPictureBreakH;
                self.tooBigPicture = YES;//大图
            }
            //计算图片控件的frame
            CGFloat picX = GLTopicMargin;
            CGFloat picY = GLTopicCellTextY + textH + GLTopicMargin;
            _pictureViewFrame = CGRectMake(picX, picY, imageW, imageH);
            
            _cellHeight += imageH;
        }
        
    }
    
    return _cellHeight;
}

-(NSString *)create_time{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) {//今年
        if (create.isToday) {//今天
            NSDateComponents *cmps =[[NSDate date]deltaFrom:create];
            if (cmps.hour >= 1) {//时间差大于1小时
               return  [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if(cmps.minute >= 1){//时间差小于1小时大于等于1分钟
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{//时间差距小于一分钟
                return @"刚刚";
            }
        }else if (create.isYesterday){//昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
            
        }else{//其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
        
    }else{//非今年
        return _create_time;
    }
}

@end
