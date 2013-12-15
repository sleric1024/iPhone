//
//  openView.h
//  iPainter
//
//  Created by eric on 13-11-7.
//  Copyright (c) 2013年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dataStore.h"
#import "mainView.h"
@interface openView : UIViewController
{
    dataStore *dataIO;
    NSMutableArray *deleteImg;
    NSMutableArray *images;
    int flag;
}
@property (retain, nonatomic) UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *item1;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *item2;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *item3;
@property (weak, nonatomic) IBOutlet UIToolbar *tool;
@end
