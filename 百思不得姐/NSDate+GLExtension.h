//
//  NSDate+GLExtension.h
//  百思不得姐
//
//  Created by Lucccc on 16/5/16.
//  Copyright © 2016年 Lucccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GLExtension)

-(NSDateComponents *)deltaFrom:(NSDate *)from;

-(BOOL)isThisYear;

-(BOOL)isToday;

-(BOOL)isYesterday;

@end
