//
//  MainViewController.m
//  BlockGame
//
//  Created by Eric on 13-12-22.
//  Copyright (c) 2013年 Eric. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize level;

@synthesize numOfBricks;

@synthesize speed,score,highest;

@synthesize soundFile;

-(void)playSound:(NSString*)soundAct{
	
	NSString *path = [NSString stringWithFormat:@"%@%@",
					  [[NSBundle mainBundle] resourcePath],
					  soundAct];
	
	NSLog(@"%@\n", path);
	
	SystemSoundID soundID;
	
	NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
	
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
	
	AudioServicesPlaySystemSound(soundID);
	
}

- (IBAction)onLeft:(id)sender {
	
	[UIImageView beginAnimations:@"animLeft" context:NULL];
	
	[UIImageView setAnimationDuration:0.2];
	
	board.center=CGPointMake(board.center.x-20, board.center.y);
	
	[UIImageView commitAnimations];
	
	soundFile = [NSString stringWithFormat:@"/button_press.caf"];
	
	[self playSound: soundFile];
	
}

- (IBAction)onRight:(id)sender {
	
	[UIImageView beginAnimations:@"animRight" context:NULL];
	
	[UIImageView setAnimationDuration:0.2];
	
	board.center=CGPointMake(board.center.x+20, board.center.y);
	
	[UIImageView commitAnimations];
	
	soundFile = [NSString stringWithFormat:@"/button_press.caf"];
	
	[self playSound: soundFile];
	
}

- (IBAction)onStart:(id)sender {
	
	if(!timer){
		timer=[NSTimer scheduledTimerWithTimeInterval:speed target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
		//球开始时的坐标
		ball.frame=CGRectMake(160, 328, 32, 32);
		[self.view addSubview:ball];
		//弹板开始时的坐标
		board.frame=CGRectMake(160, 360, 110, 10);
	}
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    filePath= [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"score"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main.jpg"]];
	[super viewDidLoad];
	//球的动态移动距离
	moveDis=CGPointMake(-3, -3);
	speed=0.03;
	board=[[BoardView alloc] initWithImage:[UIImage imageNamed:@"ban.png"]];
	//定义图像的用户交互作用属性值
	[board setUserInteractionEnabled:YES];
	//定义弹板的坐标，尺寸
	board.frame=CGRectMake(160, 360, BOARDWIDTH, BOARDHIGHT);
	ball=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
	[self.view addSubview:board];
	level=1; score=0; highest=0;
	levelLabel.text=[NSString stringWithFormat:@"游戏级别: %i",level];
	scoreLabel.text=[NSString stringWithFormat:@"现时得分: %i",score];
	highestLabel.text=[NSString stringWithFormat:@"最高成绩: %i",highest];
	//调用显示游戏级数方法
	[self levelMap:level];
}
//显示游戏级别方法
- (void)levelMap:(int)inlevel {
	UIImageView *brick;
	switch (inlevel) {
		case 1:
			bricks=[NSMutableArray arrayWithCapacity:20];
			//砖块数量
			numOfBricks=20;
			for (int i=0; i<3; i++) {
				for (int j=0;j<6;j++) {
					brick=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brick.png"]];
                    //定义砖块图像视图开始时的坐标位置和尺寸大小
					brick.frame=CGRectMake(20+j*BRICKWIDTH+j*5, TOP+10+BRICKHIGHT*i+5*i, BRICKWIDTH, BRICKHIGHT);
					[self.view addSubview:brick];
					[bricks addObject:brick];
				}
			}
			brick=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brick.png"]];
			//定义砖块图像视图开始时的坐标位置和尺寸大小
			brick.frame=CGRectMake(20, TOP+10+20*2+5*4, BRICKWIDTH, BRICKHIGHT);
			
			[self.view addSubview:brick];
			
			[bricks addObject:brick];
			
			brick=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brick.png"]];
			
			brick.frame=CGRectMake(20+5*BRICKWIDTH+5*5, TOP+10+20*2+5*4, BRICKWIDTH, BRICKHIGHT);
			
			[self.view addSubview:brick];
			
			[bricks addObject:brick];
			
			
			break;
			
		case 2:
			
			bricks=[NSMutableArray arrayWithCapacity:28];
			
			numOfBricks=28;
			
			for (int i=0; i<7; i++) {
				
				for (int j=0;j<2;j++) {
					
					brick=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brick.png"]];
					
					brick.frame=CGRectMake(20+j*BRICKWIDTH+j*5, TOP+10+BRICKHIGHT*i+5*i, BRICKWIDTH, BRICKHIGHT);
					
					[self.view addSubview:brick];
					
					[bricks addObject:brick];
					
				}
			}
			
			for (int i=0; i<7; i++) {
				
				for (int j=0;j<2;j++) {
					
					brick=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brick.png"]];
					brick.frame=CGRectMake(20+j*BRICKWIDTH+j*5+180, TOP+10+BRICKHIGHT*i+5*i, BRICKWIDTH, BRICKHIGHT);
					[self.view addSubview:brick];
					[bricks addObject:brick];
					
				}
			}
			
			
			break;
			
		default:
			break;
	}
}

- (void)onTimer{
	
	float posx,posy;
	//球的中心坐标
	posx=ball.center.x; posy=ball.center.y;
	
	ball.center = CGPointMake(posx+moveDis.x, posy+moveDis.y);
	
	if (ball.center.x>305 || ball.center.x<15 ) {
		
		moveDis.x=-moveDis.x;
		
	}
	
	if ( ball.center.y<TOP ) {
		
		moveDis.y=-moveDis.y;
		
	}
	//定以跟随移动图像视图的轨迹图像视图文件
	UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Path.png"]];
	//定义轨迹图像视图开始时的坐标位置和尺寸大小
	imageView.frame = CGRectMake(posx-16, posy-16, 32, 32);
	[self.view addSubview:imageView];
	//动画开始
	[UIView beginAnimations:nil context:(__bridge void *)(imageView)];
    //持续时间为3秒
	[UIView setAnimationDuration:3.0];
    //缓慢进出动画效果
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    //轨迹视图结束时的坐标位置和尺寸大小
	imageView.frame = CGRectMake(posx-6, posy-6, 12, 12);
	[imageView setAlpha:0.0];
	[UIView commitAnimations];
	//把ball子视图放在最前面
	[self.view bringSubviewToFront:ball];
	int j=[bricks count];
	
	for (int i=0; i<j; i++) {
		
		UIImageView *brick=(UIImageView *)[bricks objectAtIndex:i];
		
		if (CGRectIntersectsRect(ball.frame, brick.frame)&&[brick superview]) {
			
			soundFile = [NSString stringWithFormat:@"/Brick_move.caf"];
			
			[self playSound: soundFile];
			
			score+=100;
			
			[brick removeFromSuperview];
			
			if (rand()%5==0) {
				
				UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhadan"]];
				
				imageView.frame = CGRectMake(brick.frame.origin.x, brick.frame.origin.y, 48, 48);
				
				[self.view addSubview:imageView];
				
				[UIView beginAnimations:nil context:(__bridge void *)(imageView)];
				
				[UIView setAnimationDuration:5.0];
				
				[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
				
				imageView.frame = CGRectMake(brick.frame.origin.x, 480, 40, 40);
				
				[UIView setAnimationDelegate:self];
				
				[UIView setAnimationDidStopSelector:@selector(removeSmoke:finished:context:)];
				
				[UIView commitAnimations];
				
			}
			
			numOfBricks--;
			
			if ((ball.center.y-16<brick.frame.origin.y+BRICKHIGHT || ball.center.y+16>brick.frame.origin.y)
				&& ball.center.x>brick.frame.origin.x && ball.center.x<brick.frame.origin.x+BRICKWIDTH) {
				
				moveDis.y=-moveDis.y;
				
			}else if (ball.center.y>brick.frame.origin.y && ball.center.y<brick.frame.origin.y+BRICKHIGHT
					  && (ball.center.x+16>brick.frame.origin.x || ball.center.x-16<brick.frame.origin.x+BRICKWIDTH)){
				
				moveDis.x=-moveDis.x;
				
			}else{
				
				moveDis.x=-moveDis.x;
				moveDis.y=-moveDis.y;
			}
			
			break;
			
		}
	}
	
	if (numOfBricks==0) {
		
		if (level<2) {
			
			[ball removeFromSuperview];
			
			[timer invalidate];
            
            timer = NULL;
			
			level++; speed=speed-0.003;
			
			levelLabel.text=[NSString stringWithFormat:@"Level %i",level];
			
			[self levelMap:level];
			
		}else{
            [ball removeFromSuperview];
            [timer invalidate];
			
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"K.O."
														  message:@"		"
														 delegate:self cancelButtonTitle:@"OK"
												otherButtonTitles:nil];
			
			[alert show];
			
			soundFile = [NSString stringWithFormat:@"/Win.caf"];
			
			[self playSound: soundFile];
			
		}
	}
	
	if (CGRectIntersectsRect(ball.frame, board.frame)) {
		
		soundFile = [NSString stringWithFormat:@"/Kick.caf"];
		
		[self playSound: soundFile];
		
		if (ball.center.x>board.frame.origin.x&&ball.center.x<board.frame.origin.x+BOARDWIDTH) {
			
			moveDis.y=-moveDis.y;
			
		}else {
			
			moveDis.x=-moveDis.x;
			moveDis.y=-moveDis.y;
			
		}
		
	}else{
		
		if (ball.center.y>380){
			
			[ball removeFromSuperview];
			
			[timer invalidate];
			
			timer=NULL;
			
            TopScore=[NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:filePath]];
            if(TopScore==nil){
                TopScore=[[NSMutableDictionary alloc] init];
            }
            if([TopScore count]==0||score>=[[[TopScore valueForKey:@"maxScore"] valueForKey:@"score"] intValue]){
                
                UIView *popView=[[UIView alloc] initWithFrame:CGRectMake(40, 100, 240, 120)];
                popView.tag=1002;
                popView.backgroundColor=[UIColor whiteColor];
                popView.layer.cornerRadius=8.f;
                UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 240, 32)];
                label.textAlignment=1;
                label.text=@"恭喜您取得了最高分！";
                [popView addSubview:label];
                UITextField *name=[[UITextField alloc] initWithFrame:CGRectMake(10, 32, 220, 44)];
                name.tag=1001;
                name.borderStyle=UITextBorderStyleRoundedRect;
                name.contentVerticalAlignment=0;
                name.placeholder=@"请输入名字";
                [popView addSubview:name];
                UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.frame=CGRectMake(90, 80, 60, 32);
                [button setTitle:@"ok" forState:UIControlStateNormal];
                [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
                [popView addSubview:button];
                [self.view addSubview:popView];
                
            }
            else{
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"游戏结束"
														  message:@"你输了，继续获取更好的成绩..."
														 delegate:self
												cancelButtonTitle:@"确定"
												otherButtonTitles:nil];
			[alert show];
            }
			soundFile = [NSString stringWithFormat:@"/Lose.caf"];
			
			[self playSound: soundFile];
			
		}
		
	}
	
	scoreLabel.text=[NSString stringWithFormat:@"现时得分: %i",score];
}
-(void)buttonAction{
    UIView *popView=(UIView *)[self.view viewWithTag:1002];
    UITextField *name=(UITextField *)[self.view viewWithTag:1001];
    [TopScore setValue:[NSDictionary dictionaryWithObjectsAndKeys:name.text,@"name",[NSNumber numberWithInt:score],@"score", nil] forKey:@"maxScore"];
    [[NSKeyedArchiver archivedDataWithRootObject:TopScore] writeToFile:filePath atomically:YES];
    [popView removeFromSuperview];
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)showInfo:(id)sender {
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	[self presentViewController:controller animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}

@end
