//
//  trgSearchViewController.m
//  beerhub
//
//  Created by Teddy Guenin on 5/2/13.
//  Copyright (c) 2013 Teddy Guenin. All rights reserved.
//

#import "trgSearchViewController.h"
#import <Social/Social.h>
#import <MapKit/MapKit.h>

@interface trgSearchViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) CLLocation *currentLocation;
@property(assign, nonatomic) CLLocationDistance distanceFilter;
@property(assign, nonatomic) CLLocationAccuracy desiredAccuracy;
@property(strong, nonatomic) NSMutableArray *array;

@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation trgSearchViewController


@synthesize geocoder;
@synthesize mapView;
@synthesize beerList;
@synthesize detailItem;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)setDetailItem:(id)newDetailItem :(NSInteger)index
{
    if (self.detailItem != newDetailItem) {
        
        detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}



//adding twitter integrationx

- (IBAction)twitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Post your tweet here..."];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}


//facebook integration

- (IBAction)facebook:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"Make your post here..."];
        [self presentViewController:controller animated:YES completion:Nil];
    }
}

-(NSMutableArray *) createArray {
    NSString *dataStr;
    NSMutableArray *final;
    dataStr = [NSString stringWithContentsOfFile:@"breweries2.csv" encoding:NSUTF8StringEncoding error:nil];
    NSArray *tempArray = [dataStr componentsSeparatedByString: @"#"];
    for (NSString *line in tempArray){
        NSArray *tempLine = [dataStr componentsSeparatedByString: @","];
        [final addObject:tempLine];
    }
    return final;
}

//-(NSMutableArray *) outputBrews {
//    NSMutableArray *brewList = self.createArray;
//    
//}





- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
    for(id key in res) {
        
        id value = [res objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        
        NSLog(@"key: %@", keyAsString);
        NSLog(@"value: %@", valueAsString);
    }
    
    // extract specific value...
    NSArray *results = [res objectForKey:@"results"];
    
    for (NSDictionary *result in results) {
        NSString *icon = [result objectForKey:@"icon"];
        NSLog(@"icon: %@", icon);
    }
    
}




//- (void) viewDidAppear:(BOOL)animated {
//    CLLocation *loc = self.currentLocation;
//
//    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
//    pin.coordinate = loc.coordinate;
//    pin.title = [NSString stringWithFormat:@"%f", loc.coordinate.latitude];
//    pin.subtitle = [NSString stringWithFormat:@"%f", loc.coordinate.longitude];
//    [self.mapView addAnnotation:pin];
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.0, 0.03);
//
//    MKCoordinateRegion region = MKCoordinateRegionMake(pin.coordinate, span);
//
//    [self.mapView setRegion:region animated:YES];
//    [self.mapView regionThatFits:region];
//
//
//}

- (NSString *)deviceLocation {
    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", _locationManager.location.coordinate.latitude, _locationManager.location.coordinate.longitude];
    return theLocation;
}


- (void)configureView
{
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startMonitoringSignificantLocationChanges];
    [self.locationManager setDistanceFilter:1000];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    if(![self.locationManager locationServicesEnabled]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enable Location Services?" message:@"This app only works with location services enabled." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"Settings"];
        [alert show];
    }
    
    
    
    
    // Update the user interface for the detail item.
    
    //    self.locationManager = [[CLLocationManager alloc] init];
    //    self.locationManager.delegate = self;
    //    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    //    [self.locationManager startUpdatingLocation];
    //        //CLLocation *loc = self.detailItem[@"location"];
    //    CLLocation *loc = self.locationManager.location;
    //    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    //    pin.coordinate = loc.coordinate;
    //    pin.title = [NSString stringWithFormat:@"Location"];
    //    [self.mapView addAnnotation:pin];
    //MKCoordinateSpan span = MKCoordinateSpanMake(0.03, 0.03);
    
    //MKCoordinateRegion region = MKCoordinateRegionMake(pin.coordinate, span);
    
    //CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(49, -123);
    // MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 200, 200)];
    //[self.mapView setRegion:adjustedRegion animated:YES];
    
    //[self.mapView setRegion:region animated:YES];
    //[self.mapView regionThatFits:region];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 19;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    //need to set labels!!
    // [[cell textLabel] setText:[array objectAtIndex:indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    return cell;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureView];
    _array = [[NSMutableArray alloc] init];
    self.beerList.delegate = self;
    self.beerList.dataSource = self;
    
//    self.responseData = [NSMutableData data];
//    NSURLRequest *request = [NSURLRequest requestWithURL:
//                             [NSURL URLWithString:@"https://maps.googleapis.com/maps/api/place/search/json?location=-33.8670522,151.1957362&radius=500&types=food&name=harbour&sensor=false&key=AIzaSyAbgGH36jnyow0MbJNP4g6INkMXqgKFfHk"]];
//    [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    self.currentLocation = location;
    [self addPinToMapAtLocation:location];
    
}


- (void)addPinToMapAtLocation:(CLLocation *)location {
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = location.coordinate;
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    region.span = span;
    region.center = pin.coordinate;
    
    pin.title = [NSString stringWithFormat:@"Lat:%f, Long:%f", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude];
    [self.mapView addAnnotation:pin];
    [self.mapView setRegion:region animated:TRUE];
    [self.mapView regionThatFits:region];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}



@end
