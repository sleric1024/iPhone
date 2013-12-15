//
//  mapView.m
//  iPainter
//
//  Created by ceq on 13-11-8.
//  Copyright (c) 2013年 eric. All rights reserved.
//

#import "mapView.h"

@interface mapView ()

@end

@implementation mapView
@synthesize checkinLocation;
@synthesize map;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
    ann.coordinate = [checkinLocation coordinate];
    [map addAnnotation:ann];//添加一个大头针
    MKCoordinateSpan theSpan;
    //设置地图的范围，越小越精确
    theSpan.latitudeDelta = 0.001;
    theSpan.longitudeDelta = 0.001;
    MKCoordinateRegion theRegion;
    theRegion.center = [checkinLocation coordinate]; //让地图跳到之前获取到的当前位置checkinLocation
    theRegion.span = theSpan;
    [map setRegion:theRegion animated:YES];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)item1:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
