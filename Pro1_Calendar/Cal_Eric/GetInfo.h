//
//  GetInfo.h
//  Cal_Eric
//
//  Created by Eric on 13-10-15.
//  Copyright (c) 2013年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetInfo : NSObject

+(void) getMonth:(int) year andMonth:(int) month;
+(void) getYear:(int) year;
+(NSUInteger) getWeekDay:(int) month andYear:(int) year;
+(int) getMonthDays:(int) month andYear:(int) year;
+(void) vPrint:(int) week andMonth:(int) month andYear:(int) year;


@end
