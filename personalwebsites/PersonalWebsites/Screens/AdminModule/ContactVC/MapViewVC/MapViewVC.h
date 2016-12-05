//
//  MapViewVC.h
//  PersonalWebsites
//
//  Created by vectoscalar on 26/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "PWButton.h"
#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@class MapViewVC;

@protocol MapViewVCDelegate <NSObject>

- (void)userDidSelectedLocation:(CLLocation *)location withAddress:(NSString *)address;

@end

@interface MapViewVC : UIViewController <GMSMapViewDelegate>


@property (weak, nonatomic) IBOutlet GMSMapView *mGMapView;

@property (strong, nonatomic) GMSMarker *marker;

@property (strong, nonatomic) GMSCameraPosition *camera;

@property (weak, nonatomic) IBOutlet UILabel *coordinateLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (assign,nonatomic) id <MapViewVCDelegate> delegate;


@property (weak, nonatomic) IBOutlet PWButton *didUserSelectedLocation;

@end
