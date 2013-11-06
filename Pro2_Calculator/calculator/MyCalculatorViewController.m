//
//  MyCalculatorViewController.m
//  calculator
//
//  Created by Eric on 13-10-19.
//  Copyright (c) 2013年 Eric. All rights reserved.
//

#import "MyCalculatorViewController.h"

@implementation MyCalculatorViewController

@synthesize disLabel;
@synthesize showLabel;
@synthesize operatorLabel;

- (void)viewDidLoad
{
	disLabel.text = @"";
	operator = @"=";
    operatorLabel.text=@"";
    tempNumber=@"";
    i=0;
    memset(nArr, 0, sizeof(nArr));
    memoryNumber=0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//数字键功能
- (IBAction)numberClick:(id)sender {

   // backOpen = YES;
	NSString * digit = [sender currentTitle];

    showLabel.text =[showLabel.text stringByAppendingString:digit];
    nArr[i]=0;

    i++;
    tempNumber=[tempNumber stringByAppendingString:digit];
}

//清除键功能
- (IBAction)clear:(id)sender {
    disLabel.text = @"";
	operator = @"=";
    showLabel.text=@"";
    
    memset(nArr, 0, sizeof(nArr));
    
    tempNumber=@"";
    i=0;
}

//退格键功能
- (IBAction)back:(id)sender {

    
    //new Add
    if (showLabel.text.length==1) {
        showLabel.text=@"";
    }else if (![showLabel.text isEqualToString:@""])
    {
        showLabel.text=[showLabel.text substringToIndex:showLabel.text.length-1];
    }
    if(i>0)
    {
        nArr[i]=0;
        i--;
    }
    if(i==0)
    {
        nArr[i]=0;
    }


}

//增加小数点
- (IBAction)pointClick:(id)sender {
       showLabel.text=[showLabel.text stringByAppendingString:@"."];
    nArr[i]=0;
    i++;
}
static int signFlag=0;//0='-'
//正负号取反
- (IBAction)addSign:(id)sender {

    int length=[tempNumber length];
    NSString *ceq_op=[NSString stringWithFormat:signFlag==0 ? @"-":@""];
    showLabel.text=[NSString stringWithFormat:@"%@%@%@",[showLabel.text substringToIndex:[showLabel.text length]-length-signFlag],ceq_op,tempNumber];
    if(signFlag==0){
        int j,k;
        for(j=[showLabel.text length]-1,k=0;k<length;k++,j--)
            nArr[j]=nArr[j-1];
        nArr[j]=-1;
        signFlag=1;
    }
    else{
        int j,k;
        for(j=[showLabel.text length]-length,k=0;k<length;k++,j++)
            nArr[j]=nArr[j+1];
        signFlag=0;
    }
    for(int j=0;j<[showLabel.text length];j++)
        printf("%d ",nArr[j]);
    printf("\n");
    NSLog(@"%@",showLabel.text);

}

//运算操作
- (IBAction)operateClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    operator = btn.titleLabel.text;

    if(![operator isEqualToString:@"="])
    {
        showLabel.text=[showLabel.text stringByAppendingString:btn.titleLabel.text];
        nArr[i]=0;
        i++;
    }
    if([operator isEqualToString:@"="])
    {
        ///处理，，，，，，，，，，，
        float ans=[calculatClass calculatFun:showLabel.text withState:nArr];
        int errorID=[calculatClass errorID];
        if(errorID==0){
            disLabel.text=[NSString stringWithFormat:@"%g",ans];
        }
        else if(errorID==1){
            disLabel.text=@"错误ERROR";
        }
        else if(errorID==2){
            disLabel.text=@"错误ERROR";
        }
        NSLog(@"-----------------------------------");
        NSLog(@"%@",showLabel.text);
        NSLog(@"%g",ans);
        int j=0;
        for(j=0;j<i;j++)
        {
            printf("%d",nArr[j]);
        }

    }
    
}


int memFlag=0;
float tempMem=0;

- (IBAction)MemoryClear:(id)sender {
    memoryNumber=0;
    operatorLabel.text=@"";
    disLabel.text=@"";
    showLabel.text=@"";
    tempMem=0;
}

- (IBAction)MemoryAdd:(id)sender {
    operatorLabel.text=@"M";
    if(memFlag==0)
    {
        memoryNumber +=[disLabel.text floatValue];
        memFlag++;
        tempMem=memoryNumber;
    }else{
        memoryNumber+=tempMem;
    }
    showLabel.text=[NSString stringWithFormat:@"%g",memoryNumber];
    disLabel.text=showLabel.text;
    
    printf("%f\n",memoryNumber);
}

- (IBAction)MemoryOut:(id)sender {
    operatorLabel.text=@"M";
    if(memFlag==0)
    {
        memoryNumber -=[disLabel.text floatValue];
        memFlag++;
        tempMem=memoryNumber;
    }else
    {
        memoryNumber-=tempMem;
    }
    showLabel.text=[NSString stringWithFormat:@"%g",memoryNumber];
    disLabel.text=showLabel.text;
    
    printf("%f\n",memoryNumber);
}

- (IBAction)showMemory:(id)sender {
    showLabel.text=[NSString stringWithFormat:@"%g",memoryNumber];
    disLabel.text=[NSString stringWithFormat:@"%g",memoryNumber];
}
@end
