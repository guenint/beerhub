//
//  trgSearchViewController.h
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

@interface trgSearchViewController : UIViewController<CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *beerList;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)twitter:(id)sender;
- (IBAction)facebook:(id)sender;


@property (strong, nonatomic) id detailItem;

- (void)setDetailItem:(id)newDetailItem :(NSInteger)index;


@end
