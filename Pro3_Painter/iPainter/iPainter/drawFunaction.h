//
//  drawFunaction.h
//  iPainter
//
//  Created by eric on 13-11-2.
//  Copyright (c) 2013年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
@interface drawFunaction : UIView
{
    NSMutableArray *path;//存放当前需要画的线段，元素是字典类型,x和y
    NSMutableArray *lines;//存放画过的线段，字典类型,字段line和字段width和字段color
    int flag;
}
@property(nonatomic,retain)NSString *lineWeith;
@property(nonatomic,retain)UIImage *drawImg;;
@property(nonatomic,retain)NSMutableArray *path;
@property(nonatomic,retain)NSMutableArray *lines;
@property(nonatomic,retain)UIColor *color;
-(void)initData;

@end
