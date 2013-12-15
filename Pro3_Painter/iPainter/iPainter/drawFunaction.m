//
//  drawFunaction.m
//  iPainter
//
//  Created by eric on 13-11-2.
//  Copyright (c) 2013年 eric. All rights reserved.
//

#import "drawFunaction.h"

@implementation drawFunaction
@synthesize lineWeith;
@synthesize path;
@synthesize color;
@synthesize drawImg;
@synthesize lines;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)initData{
    path=[[NSMutableArray alloc] init];
    lines=[[NSMutableArray alloc] init];
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, [UIScreen mainScreen].bounds.size.height-108);
    flag=1;
    drawImg=nil;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if(drawImg!=nil){
        CGRect needRect;
        needRect.origin.x=0;
        needRect.origin.y=0;
        CGFloat wscale = drawImg.size.width/rect.size.width;
        CGFloat hscale = drawImg.size.height/rect.size.height;
        CGFloat scale = (wscale>hscale)?wscale:hscale;
        needRect.size=CGSizeMake(drawImg.size.width/scale, drawImg.size.height/scale);
        [drawImg drawInRect:needRect];
    }
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    if([lines count]>0){
        for(int i=0;i<[lines count];i++){
            NSDictionary *temp=(NSDictionary *)[lines objectAtIndex:i];
            [self drawAction:temp context:context];
        }
    }
    if([path count]>0&&flag){
        NSDictionary *temp=[NSDictionary dictionaryWithObjectsAndKeys:path,@"line",lineWeith==NULL?@"1":lineWeith,@"width",color==NULL?[UIColor blackColor]:color,@"color", nil];
        [self drawAction:temp context:context];
    }
}
-(void)drawAction:(NSDictionary *)_path context:(CGContextRef )_context{
    CGContextBeginPath(_context);
    //设置笔冒
    CGContextSetLineCap(_context, kCGLineCapRound);
    //设置画线的连接处　拐点圆滑
    CGContextSetLineJoin(_context, kCGLineJoinRound);
    NSArray *pathArray=[_path objectForKey:@"line"];
    CGContextMoveToPoint (_context, [[[pathArray objectAtIndex:0] objectForKey:@"x"] floatValue], [[[pathArray objectAtIndex:0] objectForKey:@"y"] floatValue]);
    for(int i=1;i<[pathArray count];i++){
        CGContextAddLineToPoint (_context, [[[pathArray objectAtIndex:i] objectForKey:@"x"] floatValue], [[[pathArray objectAtIndex:i] objectForKey:@"y"] floatValue]);
    }
    CGContextSetStrokeColorWithColor(_context,[[_path objectForKey:@"color"]==NULL?[UIColor blackColor]:[_path objectForKey:@"color"] CGColor]);
    CGContextSetLineWidth(_context,[_path objectForKey:@"width"]==NULL?1:[[_path objectForKey:@"width"] intValue]);
    CGContextStrokePath(_context);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSDictionary *point=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:[[touches anyObject] locationInView:self].x],@"x",[NSNumber numberWithFloat:[[touches anyObject] locationInView:self].y],@"y", nil];
    flag=1;
    [path removeAllObjects];
    [path addObject:point];
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    flag=0;
    NSDictionary *point=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:[[touches anyObject] locationInView:self].x],@"x",[NSNumber numberWithFloat:[[touches anyObject] locationInView:self].y],@"y", nil];
    [path addObject:point];
    [lines addObject:[NSDictionary dictionaryWithObjectsAndKeys:[path copy],@"line",lineWeith==NULL?@"1":[lineWeith copy],@"width", color==NULL?[UIColor blackColor]:[color copy],@"color",nil]];
    [self setNeedsDisplay];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSDictionary *point=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithFloat:[[touches anyObject] locationInView:self].x],@"x",[NSNumber numberWithFloat:[[touches anyObject] locationInView:self].y],@"y", nil];
    [path addObject:point];
    [self setNeedsDisplay];
}
@end
