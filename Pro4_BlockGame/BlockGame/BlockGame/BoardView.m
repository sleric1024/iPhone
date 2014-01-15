//
//  BoardView.m
//  BlockGame
//
//  Created by Eric on 13-12-22.
//  Copyright (c) 2013年 Eric. All rights reserved.
//

#import "BoardView.h"

@interface BoardView ()

@end

@implementation BoardView

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	//定义图形位置变量对象的坐标，locationInView表明视图中触摸点的坐标
	startLocation= [[touches anyObject] locationInView:self];
	//把BoardView子视图放在最前面
	[[self superview] bringSubviewToFront:self];
}

//获取手指的触摸移动事件方法
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	//定义图形位置变量对象的坐标，locationInView表明视图中触摸点的坐标
	CGPoint pt=[[touches anyObject] locationInView:self];
	//创建图形框架尺寸变量的对象
	CGRect frame=[self frame];
	//定义图形框架位置变量对象的x坐标值，pt.x表明图形位置变量对象的x坐标值，startLocation.x表明触摸点的x坐标
	frame.origin.x = frame.origin.x + (pt.x-startLocation.x);
	//设定图形框架位置变量数值
	[self setFrame:frame];
}

@end
