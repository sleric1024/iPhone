//
//  FlipsideViewController.h
//  BlockGame
//
//  Created by Eric on 13-12-22.
//  Copyright (c) 2013年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *maxScore;

- (IBAction)done:(id)sender;

@end
