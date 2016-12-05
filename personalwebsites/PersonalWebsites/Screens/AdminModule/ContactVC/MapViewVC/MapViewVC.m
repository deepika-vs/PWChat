//
//  MapViewVC.m
//  PersonalWebsites
//
//  Created by vectoscalar on 26/09/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "MapViewVC.h"

#define kLatitute   28.7041
#define kLongitude  77.1025

@interface MapViewVC ()
{
    CGFloat lat, lng;
    NSString *locality, *subLocal, *address;
    
}

@end

@implementation MapViewVC
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set Initial Value
    lat = kLatitute;
    lng = kLongitude;
    
    self.camera = [GMSCameraPosition cameraWithLatitude:lat
                                              longitude:lng
                                                   zoom:12.0
                                      ];
    
    
    self.mGMapView.delegate = self;
    
    self.mGMapView.camera = self.camera;
    self.mGMapView.mapType = kGMSTypeNormal;
    
    //MyLocations.
    self.mGMapView.myLocationEnabled = YES;
    self.mGMapView.settings.compassButton = YES;
    
    //self.mGMapView.settings.myLocationButton = YES;
    //self.mGMapView.settings.scrollGestures = NO;
    
    [self.mGMapView accessibilityLanguage];
    [self addMarkerToGMap];
    // Do any additional setup after loading the view from its nib.
}



- (void) addMarkerToGMap{
    self.mGMapView.padding = UIEdgeInsetsMake (20, 20, 20, 20);
    
    self.marker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(lat, lng)];
    self.marker.title = @"New Delhi, India";
    self.marker.snippet = [NSString stringWithFormat:@"Latitute: %f, Longitude: %f", lat, lng];
    
    UIImage *icon = [UIImage imageNamed:@"contactMap"];
    icon = [icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.marker.icon = icon;//[icon imageWithAlignmentRectInsets:UIEdgeInsetsMake(-(icon.size.height/2), -(icon.size.width/2), 0, 0)];
    
    
    self.marker.appearAnimation = kGMSMarkerAnimationPop;
    
    //Set the orientation of a marker to be flat against the earth.
    //Flat markers rotate when the map is rotated, and change perspective when the map is tilted
    self.marker.flat = YES;
    
    //Enable marker to draggable.
    self.marker.draggable = YES;
    
    self.marker.tracksViewChanges = YES;
    
    self.marker.map = self.mGMapView;
    
    
    //Set marker window offset.
    self.marker.infoWindowAnchor = CGPointMake(0.5, 0.1);
    [self.mGMapView setSelectedMarker:self.marker];
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)mapView:(GMSMapView *)mapView didTapPOIWithPlaceID:(NSString *)placeID name:(NSString *)name location:(CLLocationCoordinate2D)location{
    
    lat = location.latitude;
    lng = location.longitude;
    
    [[GMSGeocoder geocoder] reverseGeocodeCoordinate:CLLocationCoordinate2DMake(lat, lng) completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error) {
        NSLog(@"reverse geocoding results:%@",[response results]);
        for(GMSAddress* addressObj in [response results])
        {
            if(addressObj.locality){
                address = [NSString stringWithFormat:@"%@, %@", addressObj.locality, addressObj.country];
            }else if(addressObj.subLocality && addressObj.locality == nil){
                address = [NSString stringWithFormat:@"%@, %@", addressObj.subLocality, addressObj.country];
            }else if(addressObj.administrativeArea && addressObj.subLocality==nil && addressObj.locality == nil){
                //address = [NSString stringWithFormat:@"%@, %@", addressObj.administrativeArea, addressObj.country];
            }else{
                address = [NSString stringWithFormat:@"%@", addressObj.country];
            }
            
            //            locality = addressObj.locality;
            //            subLocal = addressObj.subLocality;
            
            self.marker.title = address;
        }
    }];
    
    self.marker.snippet = [NSString stringWithFormat:@"Latitute: %f, Longitude: %f", lat, lng];
    self.marker.position = CLLocationCoordinate2DMake(lat, lng);
    
    self.marker.tracksInfoWindowChanges =YES;
}



- (void)mapView:(GMSMapView *)mapView didBeginDraggingMarker:(GMSMarker *)marker{
    //marker.tracksInfoWindowChanges = YES;
    //marker.map = mapView;
}


- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator{
    
}


- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position{
    
    [self.mGMapView animateToCameraPosition:position];

}



- (IBAction)didUserSelectedLocation:(PWButton *)sender {
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    
    [delegate userDidSelectedLocation:location withAddress:address];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
