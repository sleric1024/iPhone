//
//  mainView.m
//  iPainter
//
//  Created by eric on 13-11-2.
//  Copyright (c) 2013年 eric. All rights reserved.
//

#import "mainView.h"

@interface mainView ()

@end

@implementation mainView
static drawFunaction *drawP=nil;
+(drawFunaction *)getCurDrawView{
    return  drawP;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dataIO=[[dataStore alloc] initWithPath:@"Documents"];
        [dataIO newFile:@"myImg"];
        locaIO=[[dataStore alloc] initWithPath:@"Documents"];
        [locaIO newFile:@"myLoc"];
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = 200;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:_drawView];
    [_drawView initData];
    drawP=_drawView;
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)item1:(id)sender {
    CGPoint point;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 260, 200)];
    view.backgroundColor=[UIColor clearColor];
    UITextField *inputView=[[UITextField alloc] initWithFrame:CGRectMake(10, 10, 240, 44)];
    inputView.backgroundColor=[UIColor clearColor];
    inputView.textAlignment=1;
    inputView.tag=101;
    inputView.delegate=self;
    inputView.borderStyle=UITextBorderStyleRoundedRect;
    inputView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    inputView.placeholder=@"请输入线条宽度(单位像素)";
    UIButton *buttonSure=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonSure.frame=CGRectMake(120-45, 60, 90, 30);
    [buttonSure setTitle:@"确定" forState:UIControlStateNormal];
    [buttonSure addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buttonSure];
    [view addSubview:inputView];
    point.x=160;
    point.y=100;
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 135, 40, 15)];
    label.text=@"预览";
    [view addSubview:label];
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(55, 140-0.5, 180,1)];
    line.tag=31;
    line.backgroundColor=[UIColor blackColor];
    [view addSubview:line];
    inputLine=[PopoverView showPopoverAtPoint:point
                                inView:self.view
                       withContentView:view
                              delegate:self];
    inputLine.isArrow=0;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    UIView *view1=[self.view viewWithTag:31];
    float lineWid=textField.text==NULL?1.0:[textField.text floatValue];
    if(![string isEqualToString:@""])
        lineWid=lineWid*10+[string floatValue];
    else
        lineWid=(int)(lineWid/10);
    lineWid=lineWid==0?1:lineWid;
    NSLog(@"%f",lineWid);
    if(view1){
        view1.frame=CGRectMake(55, 140-lineWid/2, 180,lineWid);
    }
    return YES;
}
- (IBAction)CleanAction:(id)sender {
    [_drawView.lines removeAllObjects];
    [_drawView.path removeAllObjects];
    _drawView.lineWeith=@"1";
    _drawView.drawImg=nil;
    [_drawView setNeedsDisplay];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    checkinLocation = newLocation;
    [locaIO deleteFile];
    [locaIO writeFile:[NSKeyedArchiver archivedDataWithRootObject:checkinLocation]];
    //do something else
}
- (IBAction)location:(id)sender {
    mapView *map=[[mapView alloc] init];
    map.checkinLocation=(CLLocation *)[NSKeyedUnarchiver unarchiveObjectWithData:[locaIO readFile]];
    NSLog(@"%@",map.checkinLocation);
    [self presentViewController:map animated:YES completion:nil];
}
-(void)sureAction{
    [inputLine dismiss:YES];
    _drawView.lineWeith=[(UITextField *)[self.view viewWithTag:101] text];
}
- (IBAction)item2:(id)sender {
    CGPoint point;
    colorTable *colortable=[[colorTable alloc]initWithFrame:CGRectMake(0, 0, 80, 320)];
    colortable.tag=102;
    colortable.delegate=self;
    NSMutableArray *array=[[NSMutableArray alloc] initWithObjects:
                           [NSArray arrayWithObjects:[UIColor clearColor],@"自定义", nil],
                           [NSArray arrayWithObjects:[UIColor redColor],@"red", nil],
                           [NSArray arrayWithObjects:[UIColor blackColor],@"black", nil],
                           [NSArray arrayWithObjects:[UIColor greenColor],@"green", nil],
                           [NSArray arrayWithObjects:[UIColor grayColor],@"gray", nil],
                           [NSArray arrayWithObjects:[UIColor yellowColor],@"yellow", nil],
                           [NSArray arrayWithObjects:[UIColor blueColor],@"blue", nil],
                           [NSArray arrayWithObjects:[UIColor brownColor],@"brow", nil],
                           [NSArray arrayWithObjects:[UIColor purpleColor],@"purple", nil],
                            nil];
    colortable.dataArray=array;
    point.x=((UIButton *)sender).frame.size.width/2+((UIButton *)sender).frame.origin.x;
    point.y=((UIButton *)sender).frame.size.height/2+((UIButton *)sender).frame.origin.y;
    pv=[PopoverView showPopoverAtPoint:point
                                inView:self.view
                       withContentView:colortable
                              delegate:self];
    pv.isArrow=1;
}

- (IBAction)item3:(id)sender {
    CGPoint point;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 260, 100)];
    view.backgroundColor=[UIColor clearColor];
    UITextField *inputView=[[UITextField alloc] initWithFrame:CGRectMake(10, 10, 240, 44)];
    inputView.backgroundColor=[UIColor clearColor];
    inputView.textAlignment=1;
    inputView.tag=106;
    inputView.delegate=self;
    inputView.borderStyle=UITextBorderStyleRoundedRect;
    inputView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    inputView.placeholder=@"请输入图片名称";
    UIButton *buttonSure=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonSure.frame=CGRectMake(120-45, 60, 90, 30);
    [buttonSure setTitle:@"确定" forState:UIControlStateNormal];
    [buttonSure addTarget:self action:@selector(saveImg) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buttonSure];
    [view addSubview:inputView];
    point.x=160;
    point.y=[[UIScreen mainScreen] bounds].size.height/2-100/2;
    inputImgName=[PopoverView showPopoverAtPoint:point
                                       inView:self.view
                              withContentView:view
                                     delegate:self];
    inputImgName.isArrow=0;
}
-(void)saveImg{
    if([(UITextField *)[self.view viewWithTag:106] text]==NULL||[[(UITextField *)[self.view viewWithTag:106] text]isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    /*
     //保存这次绘图的地理位置信息
    */
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog( @"Starting CLLocationManager" );
        [locationManager startUpdatingLocation];
    } else {
        NSLog( @"Cannot Starting CLLocationManager" );
        [locationManager startUpdatingLocation];
    }
    
    UIGraphicsBeginImageContext(_drawView.frame.size);
	[_drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage* image=UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    //获得系统时间
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    //获得系统日期
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    NSString *  nsDateString= [NSString  stringWithFormat:@"%4d年%2d月%2d日%@",year,month,day,locationString];
    NSMutableArray *images=(NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:[dataIO readFile]];
    if(images==nil){
        images=[[NSMutableArray alloc] init];
    }
    [images addObject:[NSDictionary dictionaryWithObjectsAndKeys:image,@"img",[(UITextField *)[self.view viewWithTag:106] text],@"name",nsDateString,@"time", nil]];
    if([dataIO writeFile:[NSKeyedArchiver archivedDataWithRootObject:images]]){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"保存失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    [inputImgName dismiss:YES];
}
- (IBAction)item4:(id)sender {
    openView *open=[[openView alloc] init];
    [self presentViewController:open animated:YES completion:^{
        
    }];
}

- (IBAction)item5:(id)sender {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
//    //判断是否有摄像头
    if(![UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate=self;   // 设置委托
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];  //需要以模态的形式展示
}

- (IBAction)item6:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.keyboardType=UIKeyboardTypeNumberPad;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)costumColor{
    [inputColor dismiss:YES];
    _drawView.color=[UIColor colorWithRed:[((UITextField *)[self.view viewWithTag:103]).text intValue]/255.0 green:[((UITextField *)[self.view viewWithTag:104]).text intValue]/255.0
        blue:[((UITextField *)[self.view viewWithTag:105]).text intValue]/255.0
        alpha:1];
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    colorCell *cell = (colorCell *)[tableView cellForRowAtIndexPath:indexPath];
    if(cell.tag == 0){
        cell.selected = NO;
        if(indexPath.row==0){
            [pv dismiss:YES];
            CGPoint point;
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
            view.backgroundColor=[UIColor clearColor];
            for(int i=0;i<3;i++){
                UITextField *inputred=[[UITextField alloc] initWithFrame:CGRectMake(10+100*i, 10, 80, 24)];
                inputred.backgroundColor=[UIColor clearColor];
                inputred.textAlignment=1;
                inputred.tag=103+i;
                inputred.font=[UIFont fontWithName:inputred.font.fontName size:14];
                inputred.delegate=self;
                inputred.borderStyle=UITextBorderStyleRoundedRect;
                inputred.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(100*i, 34, 100, 20)];
                label.textAlignment=1;
                label.backgroundColor=[UIColor clearColor];
                switch (i) {
                    case 0:
                        label.text=@"red(0~255)";
                        break;
                    case 1:
                        label.text=@"green(0~255)";
                        break;
                    case 2:
                        label.text=@"blue(0~255)";
                        break;
                    default:
                        break;
                }
                [view addSubview:label];
                [view addSubview:inputred];
            }
            UIButton *buttonSure=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            buttonSure.frame=CGRectMake(150-45, 60, 90, 30);
            [buttonSure setTitle:@"确定" forState:UIControlStateNormal];
            [buttonSure addTarget:self action:@selector(costumColor) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:buttonSure];
            point.x=160;
            point.y=[[UIScreen mainScreen] bounds].size.height/2-100/2;
            inputColor=[PopoverView showPopoverAtPoint:point
                                               inView:self.view
                                      withContentView:view
                                             delegate:self];
            inputColor.isArrow=0;
        }
        else{
            [pv dismiss:YES];
            _drawView.color=[[((colorTable *)[self.view viewWithTag:102]).dataArray objectAtIndex:indexPath.row] objectAtIndex:0];
        }
    }else {
        [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    }
}
#pragma mark -
#pragma mark UIImagePickerController Method
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    _drawView.drawImg=image;
    [_drawView setNeedsDisplay];
    //关闭相册界面
    [picker dismissModalViewControllerAnimated:YES];
}
//完成拍照
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil)
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _drawView.drawImg=image;
    [_drawView setNeedsDisplay];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//用户取消拍照
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
