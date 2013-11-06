//
//  GetInfo.m
//  Cal_Eric
//
//  Created by Eric on 13-10-15.
//  Copyright (c) 2013年 Eric. All rights reserved.
//

#import "GetInfo.h"

@implementation GetInfo

char *cWeek[8]={"日","一","二","三","四","五","六"};
char *cMonth[13]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};

//获取一个月的日历并输出
+(void) getMonth:(int)year andMonth:(int)month
{
    NSUInteger weekDay =[GetInfo getWeekDay:month andYear:year];
    int monthDays = [GetInfo getMonthDays:month andYear:year];
    //输出月份，年份
    printf("     %s %d\n",cMonth[month-1],year);
    //输出星期栏
    for (int i=0; i<7; i++) {
        printf("%s ",cWeek[i]);
    }
    printf("\n");
    //格式输出每月第一天前的空格数
    for (int i=0; i<weekDay-1; i++) {
        printf("   ");
    }
    for (int i=1; i<=monthDays; i++) {
        //格式化输出
        if (i<10) {
            printf(" %d ",i);
        } else {
            printf("%d ",i);
        }
        //每7天换行
        if ((i+weekDay-1)%7==0) {
            printf("\n");
        }
    }
    printf("\n");
    
}
//获取一年的月份日历并输出
+(void) getYear:(int)year
{
    for (int i=0; i<4; i++) {//4行3个月
        for (int j=-2; j<6; j++) {//周
            for (int k=0; k<3; k++) {//横排
                
                [GetInfo vPrint:j andMonth:i*3+k+1 andYear:year];
                printf(" ");
                
            }printf("\n");
        }
    }
}


//参数 月份，年份，获得当年当月的第一天是星期几
+(NSUInteger) getWeekDay:(int)month andYear:(int)year   
{
    NSDateComponents *comp=[[NSDateComponents alloc] init];
    [comp setYear:year];
    [comp setMonth:month];
    [comp setDay:1];//计算每个月的第一天
    NSCalendar *myDate = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *d =[myDate dateFromComponents:comp];
    
    NSCalendar *cal =[NSCalendar currentCalendar];
    NSUInteger weekDayOfMonth =[cal ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:d];
    return  weekDayOfMonth;
}

//获取一个月的天数
+(int) getMonthDays:(int)month andYear:(int)year
{
    
    int daysOfMonth;
    
    if (month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12) {
        daysOfMonth=31;
    } else if(month==2){
        if ((year%4==0&&year%100!=0)||(year%400==0)) {
            daysOfMonth=29;
        }else{
            daysOfMonth=28;
        }
    }else{
        daysOfMonth=30;
    }
    
    return daysOfMonth;
}

+(void) vPrint:(int)week andMonth:(int)month andYear:(int)year
{
    NSUInteger dayOfWeek = [GetInfo getWeekDay:month andYear:year];
    
    //输出月份
    if (week==-2) {
        {
            if(month<11)
            {
                printf("        %s          ",cMonth[month-1]);
            }else
            {
                printf("      %s          ",cMonth[month-1]);
            }
            
            
        }
    //输出星期
    }else if(week==-1)
    {
        printf("日 一 二 三 四 五 六 ");
    }else if (week==0)
    {
        for (int i=0; i<dayOfWeek-1; i++) {//输出每月前空格
            printf("   ");
        }
        for (int i=1; i<=8-dayOfWeek; i++) {
            if (i<10) {//1-9前面补空格
                printf(" %d ",i);
            } else {
                printf("%d ",i);
            }
        }
        
    }else{
        int daysOfMonth =[GetInfo getMonthDays:(month) andYear:year];
        NSUInteger firstDayOfLine=(week-1)*7+8-dayOfWeek+1;//计算每行其实第几天
        
        for (int i=0; i<7; i++) {
            if (firstDayOfLine+i>daysOfMonth) {
                printf("   ");
            }else{
                if ((i+firstDayOfLine)<10) {//1-9前面补空格
                    printf(" %ld ",firstDayOfLine+i);
                } else {
                    printf("%ld ",firstDayOfLine+i);
                }
            }
        }
    }

}




@end
