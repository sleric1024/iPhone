//
//  mainView.h
//  iPainter
//
//  Created by eric on 13-11-2.
//  Copyright (c) 2013年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "drawFunaction.h"
#import "PopoverView.h"
#import "colorTable.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "dataStore.h"
#import "openView.h"
#import "mapView.h"
@implementation CLLocationManager (TemporaryHack)//让程序在模拟器中也能获取位置

- (void)hackLocationFix
{
    float latitude = 23.134844f;
    float longitude = 113.317290f;  //这里可以是任意的经纬度值
    CLLocation *location= [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [[self delegate] locationManager:self didUpdateToLocation:location fromLocation:nil];
}

- (void)startUpdatingLocation
{
    [self performSelector:@selector(hackLocationFix) withObject:nil afterDelay:0.1];
}
@end
@interface mainView : UIViewController<PopoverViewDelegate,UITextFieldDelegate,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate,UITextFieldDelegate>
{
    PopoverView *pv;
    PopoverView *inputLine;
    PopoverView *inputColor;
    PopoverView *inputImgName;
    dataStore *dataIO;
    dataStore *locaIO;
    CLLocationManager *locationManager;
    CLLocation *checkinLocation;
}
+(drawFunaction *)getCurDrawView;
@property (weak, nonatomic) IBOutlet drawFunaction *drawView;


- (IBAction)item1:(id)sender;
- (IBAction)CleanAction:(id)sender;
- (IBAction)location:(id)sender;

- (IBAction)item2:(id)sender;
- (IBAction)item3:(id)sender;
- (IBAction)item4:(id)sender;
- (IBAction)item5:(id)sender;
- (IBAction)item6:(id)sender;
@end
