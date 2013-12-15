//
//  mapView.h
//  iPainter
//
//  Created by eric on 13-11-8.
//  Copyright (c) 2013年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface mapView : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocation *checkinLocation;
}
@property (nonatomic,retain) CLLocation *checkinLocation;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *item1;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@end
