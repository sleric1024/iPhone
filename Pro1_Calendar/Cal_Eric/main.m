//
//  main.m
//  Cal_Eric
//
//  Created by Eric on 13-10-15.
//  Copyright (c) 2013年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetInfo.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *now;
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        now=[NSDate date];
        comps = [calendar components:unitFlags fromDate:now];

        
        if(argc==1) {//一个参数
            //NSLog(@"1个参数");
            int year=[comps year];
            int month = [comps month];
            
            [GetInfo getMonth:year andMonth:month];
            
        } else if(argc==2){
            //NSLog(@"2个参数");
            int year = atoi(argv[1]);
            if (year>9999 || year<1) {
                printf("year %s not in range 1..9999",argv[2]);
            }else
            {
                [GetInfo getYear:year];
            }
        } else if(argc==3){
            //NSLog(@"3个参数");
            if (strcmp(argv[1], "-m")==0) {
                int year = [comps year];
                int month = atoi(argv[2]);
                if (month>12 || month<1) {
                    printf("%s is neither a month number (1..12) nor a name\n",argv[3]);
                }else{
                    [GetInfo getMonth:year andMonth:month];
                }
            }else{
                
                int month = atoi(argv[1]);
                int year = atoi(argv[2]);
                if (year>9999 || year<1) {
                    printf("year %s not in range 1..9999",argv[2]);
                }
                else if (month>12 || month<1) {
                    printf("%s is neither a month number (1..12) nor a name\n",argv[2]);
                }else{
                    [GetInfo getMonth:year andMonth:month];
                }
            }
            
        }else{
            printf("请输入正确格式！");
        }
        
    }
    return 0;
}

