//
//  FlipsideViewController.m
//  BlockGame
//
//  Created by Eric on 13-12-22.
//  Copyright (c) 2013年 Eric. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController
@synthesize maxScore;
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *filePath= [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"] stringByAppendingPathComponent:@"score"];
    NSMutableDictionary *readFile1=[NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:filePath]];
    maxScore.text=[NSString stringWithFormat:@"name:%@,score:%d",[[readFile1 valueForKey:@"maxScore"] valueForKey:@"name"],[[[readFile1 valueForKey:@"maxScore"] valueForKey:@"score"] intValue]];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
