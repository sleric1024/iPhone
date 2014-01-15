//
//  MainViewController.h
//  BlockGame
//
//  Created by Eric on 13-12-22.
//  Copyright (c) 2013年 Eric. All rights reserved.
//
#import "FlipsideViewController.h"

#import <Foundation/Foundation.h>

#import <AudioToolbox/AudioToolbox.h>

#import <QuartzCore/QuartzCore.h>

#import "BoardView.h"

#define BRICKHIGHT 15
#define BRICKWIDTH 44

#define BOARDHIGHT 10
#define BOARDWIDTH 110
#define TOP 40


@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	IBOutlet UILabel *highestLabel;
    IBOutlet UILabel *levelLabel;
    IBOutlet UILabel *scoreLabel;
	NSTimer *timer;
	UIImageView *ball;
	CGPoint moveDis;
	BoardView *board;
	//存放砖块的内容
	NSMutableArray *bricks;
	int level,numOfBricks,score,highest;
	//球速
	double speed;
	//声音文件
	NSString *soundFile;
	NSMutableDictionary *TopScore;
    NSString *filePath;
}

@property int level,score,highest;
@property int numOfBricks;
@property double speed;

@property(nonatomic,retain)NSString *soundFile;

- (IBAction)onLeft:(id)sender;
- (IBAction)onRight:(id)sender;

- (IBAction)onStart:(id)sender;

- (void)levelMap:(int)inlevel;

-(void)playSound:(NSString*)soundAct;

- (IBAction)showInfo:(id)sender;



@end
