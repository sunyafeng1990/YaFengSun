//
//  Tool.m
//  测试时间
//
//  Created by yons on 16/10/24.
//  Copyright © 2016年 孙亚锋. All rights reserved.
//

#import "Tool.h"

@implementation Tool

+ (NSString *)getDayWeek:(int)dayDelay {
    NSString *weekDay;
    NSDate *dateNow;
    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//这句我也不明白具体时用来做什么。。。
    comps = [calendar components:unitFlags fromDate:dateNow];
    NSInteger weekNumber = [comps weekday];  //获取星期对应的长整形字符串
    NSInteger day        =[comps day];       //获取日期对应的长整形字符串
    NSInteger year       =[comps year];      //获取年对应的长整形字符串
    NSInteger month      =[comps month];     //获取月对应的长整形字符串
//    NSInteger hour     =[comps hour];      //获取小时对应的长整形字符串
//    NSInteger minute   =[comps minute];    //获取月对应的长整形字符串
//    NSInteger second   =[comps second];    //获取秒对应的长整形字符串
//    NSString *riQi =[NSString stringWithFormat:@"%@年%@月%@日%@时%@分%@秒", @(year), @(month), @(day), @(hour), @(minute), @(second)];//把日期长整形转成对应的汉字字符串
   NSString *riQi =[NSString stringWithFormat:@"%@年%@月%@日", @(year), @(month), @(day)];//把日期长整形转成对应的汉字字符串
    switch (weekNumber) {
        case 1:
            weekDay=@"星期日";
            break;
        case 2:
            weekDay=@"星期一";
            break;
        case 3:
            weekDay=@"星期二";
            break;
        case 4:
            weekDay=@"星期三";
            break;
        case 5:
            weekDay=@"星期四";
            break;
        case 6:
            weekDay=@"星期五";
            break;
        case 7:
            weekDay=@"星期六";
            break;
        default:
            break;
    }
    weekDay = [riQi stringByAppendingString:weekDay];//这里我本身的程序里只需要日期和星期，所以上面的年月时分秒都没有用上
    return weekDay;
}

@end
