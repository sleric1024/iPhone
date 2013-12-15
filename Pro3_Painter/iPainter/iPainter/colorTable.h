//
//  colorTable.h
//  iPainter
//
//  Created by eric on 13-11-7.
//  Copyright (c) 2013年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "colorCell.h"
@interface colorTable : UITableView<UITableViewDataSource>

@property(nonatomic,retain)NSMutableArray *dataArray;

@end
