//
//  openView.m
//  iPainter
//
//  Created by eric on 13-11-7.
//  Copyright (c) 2013年 eric. All rights reserved.
//

#import "openView.h"

@interface openView ()

@end

@implementation openView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dataIO=[[dataStore alloc] initWithPath:@"Documents"];
        [dataIO newFile:@"myImg"];
        deleteImg=[[NSMutableArray alloc] init];
        images=[NSKeyedUnarchiver unarchiveObjectWithData:[dataIO readFile]];
        flag=0;
        _scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, [UIScreen mainScreen].bounds.size.height-20-44)];
        _scroll.backgroundColor=[UIColor clearColor];
        _scroll.showsHorizontalScrollIndicator=NO;
        _scroll.showsVerticalScrollIndicator=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _item3.enabled=NO;
    [self.view addSubview:_scroll];
    [self layoutImg];
        // Do any additional setup after loading the view from its nib.
}
-(void)layoutImg{
    int col=0,row=0;
    NSArray *subs=[_scroll subviews];
    for(int i=0;i<[subs count];i++)
        [[subs objectAtIndex:i] removeFromSuperview];
    for(int i=0;i<[images count];i++){
        NSDictionary *image=[images objectAtIndex:i];
        UIView *kuang=[[UIView alloc] initWithFrame:CGRectMake(row*100+12.5,col*150+3.5 , 95, 95)];
        kuang.layer.borderWidth=1;
        kuang.layer.borderColor=[[UIColor blackColor]CGColor];
        UIImageView *tempView=[[UIImageView alloc] initWithImage:[image objectForKey:@"img"]];
        tempView.frame=CGRectMake(2.5,2.5 , 90, 90);
        tempView.tag=i+1;
        tempView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [tempView addGestureRecognizer:tap];
        UILabel *name=[[UILabel alloc] init];
        UILabel *time=[[UILabel alloc] init];
        name.backgroundColor=[UIColor clearColor];
        time.backgroundColor=[UIColor clearColor];
        name.textAlignment=1;
        time.textAlignment=1;
        time.adjustsFontSizeToFitWidth=YES;
        name.adjustsFontSizeToFitWidth=YES;
        name.frame=CGRectMake(kuang.frame.origin.x, kuang.frame.origin.y+kuang.frame.size.height, kuang.frame.size.width, 20);
        time.frame=CGRectMake(kuang.frame.origin.x, name.frame.origin.y+name.frame.size.height, kuang.frame.size.width, 25);
        name.text=[image objectForKey:@"name"];
        time.text=[image objectForKey:@"time"];
        [_scroll addSubview:kuang];
        [kuang addSubview:tempView];
        [_scroll addSubview:name];
        [_scroll addSubview:time];
        row++;
        if(row==3){
            row=0;
            col++;
        }
    }
    _scroll.contentSize=CGSizeMake(320, (col+1)*150+5);

}
-(void)tapAction:(UITapGestureRecognizer *)recognizer{
    UIImageView *tapView=(UIImageView *)[recognizer view];
    if(flag){
        for(NSString *tempItem in deleteImg){
            if([tempItem isEqualToString:[NSString stringWithFormat:@"%d",tapView.tag]]){
                UIView *kuang=[tapView superview];
                kuang.layer.borderColor=[[UIColor blackColor]CGColor];
                [deleteImg removeObject:tempItem];
                return;
            }
        }
        UIView *kuang=[tapView superview];
        kuang.layer.borderColor=[[UIColor redColor]CGColor];
        [deleteImg addObject:[NSString stringWithFormat:@"%d",tapView.tag]];
        return;
    }
    [mainView getCurDrawView].drawImg=tapView.image;
    [[mainView getCurDrawView].lines removeAllObjects];
    [[mainView getCurDrawView].path removeAllObjects];
    [[mainView getCurDrawView] setNeedsDisplay];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)item1:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)item2:(id)sender {
    UIBarButtonItem *item2=(UIBarButtonItem *)sender;
    if(flag==0){
        [item2 setTitle:@"完成"];
        _item3.enabled=YES;
        flag=1;
        [deleteImg removeAllObjects];
    }
    else{
        [item2 setTitle:@"编辑"];
        flag=0;
        _item3.enabled=NO;
        [self layoutImg];
    }
}
- (IBAction)item3:(id)sender {
    [_item2 setTitle:@"编辑"];
    flag=0;
    _item3.enabled=NO;
    [deleteImg sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSString *)obj2 intValue]-[(NSString *)obj1 intValue];
    }];
    for(int i=0;i<[deleteImg count];i++)
        [images removeObjectAtIndex:[[deleteImg objectAtIndex:i] intValue]-1];
    [self layoutImg];
    [dataIO writeFile:[NSKeyedArchiver archivedDataWithRootObject:images]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
