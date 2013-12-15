//
//  colorTable.m
//  iPainter
//
//  Created by eric on 13-11-7.
//  Copyright (c) 2013年 eric. All rights reserved.
//

#import "colorTable.h"

@implementation colorTable
@synthesize dataArray;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        dataArray=[[NSMutableArray alloc]init];
        self.dataSource=self;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellWithIdentifier = @"Cell";
    colorCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[colorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
    }
    NSArray *array=[self.dataArray objectAtIndex:indexPath.row];
    cell.color.backgroundColor=[array objectAtIndex:0];
    cell.colorName.text=[array objectAtIndex:1];
    return cell;
}
@end
