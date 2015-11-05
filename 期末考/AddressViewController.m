//
//  AddressViewController.m
//  期末考
//
//  Created by 鄭涵嚴 on 2015/11/5.
//  Copyright © 2015年 鄭涵嚴. All rights reserved.
//

#import "AddressViewController.h"
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface AddressViewController ()
{
    CLPlacemark *placeMark;
    __weak IBOutlet MKMapView *localMap;
}

@end

@implementation AddressViewController
- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:self.address completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error == nil && placemarks.count > 0)
        {
            placeMark = placemarks[0];
            MyAnnotation *annotation = [[MyAnnotation alloc]
                                        initWithCoordinate:placeMark.location.coordinate title:@"咖啡廳" subtitle:self.address];
            
            [localMap addAnnotation:annotation];
            [self mapView:localMap didUpdateUserLocation:nil];
            
        }
    }];
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:
(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(placeMark.location.coordinate,200, 200 );
    [mapView setRegion:region animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
