//
//  trgLocViewController.h
//  beerhub
//
//  Created by Teddy Guenin on 5/2/13.
//  Copyright (c) 2013 Teddy Guenin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Social/Social.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>



@interface trgLocViewController : UIViewController <CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *beerList;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)facebook:(id)sender;
- (IBAction)twitter:(id)sender;


@property (strong, nonatomic) id detailItem;

- (void)setDetailItem:(id)newDetailItem :(NSInteger)index;
- (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address;

@end
