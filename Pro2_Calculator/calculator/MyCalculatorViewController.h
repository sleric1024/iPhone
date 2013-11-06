//
//  MyCalculatorViewController.h
//  calculator
//
//  Created by Eric on 13-10-19.
//  Copyright (c) 2013年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "calculatClass.h"

@interface MyCalculatorViewController : UIViewController
{
    NSString *operator;
    NSString *tempNumber;
    

    int i;
    int nArr[100];
    float memoryNumber;

	

}
@property (weak, nonatomic) IBOutlet UIButton *btn_one;
@property (weak, nonatomic) IBOutlet UILabel *disLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatorLabel;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
- (IBAction)numberClick:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)pointClick:(id)sender;
- (IBAction)addSign:(id)sender;
- (IBAction)operateClick:(id)sender;
- (IBAction)MemoryClear:(id)sender;
- (IBAction)MemoryAdd:(id)sender;
- (IBAction)MemoryOut:(id)sender;
- (IBAction)showMemory:(id)sender;

@end
