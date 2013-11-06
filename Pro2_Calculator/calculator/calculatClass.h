//
//  MyCalculatorViewController.h
//  calculator
//
//  Created by Eric on 13-10-19.
//  Copyright (c) 2013年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface calculatClass : NSObject

+(int)errorID;
+(float) calculatFun:(NSString *)Exp withState:(int [])state;
@end
