//
//  trgLocViewController.m
//  beerhub
//
//  Created by Teddy Guenin on 5/2/13.
//  Copyright (c) 2013 Teddy Guenin. All rights reserved.
//

#import "trgLocViewController.h"
#import <Social/Social.h>
#import <MapKit/MapKit.h>
#import "trgStylesViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface trgLocViewController ()
{
    NSArray *array;
}
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) CLLocation *currentLocation;
@property(assign, nonatomic) CLLocationDistance distanceFilter;
@property(assign, nonatomic) CLLocationAccuracy desiredAccuracy;
@property(strong, nonatomic) NSMutableArray *array;

@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation trgLocViewController

@synthesize responseData = _responseData;
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
        [tweetSheet setInitialText:@"Enjoying a wonderful beer!"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}


//facebook integration

- (IBAction)facebook:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"Enjoying a wonderful beer!"];
        [self presentViewController:controller animated:YES completion:Nil];
    }
}

//
//-(NSArray *) createArray {
//    NSArray *arrayOfArrays = [CSVParser parseCSVIntoArrayOfArraysFromFile:@"breweries.csv"
//                                             withSeparatedCharacterString:@","
//                                                     quoteCharacterString:nil];
//    return arrayOfArrays;
//}

-(NSMutableArray *) createArray {
    NSString *dataStr;
    NSMutableArray *final;
    dataStr = [NSString stringWithContentsOfFile:@"breweries2.csv" encoding:NSUTF8StringEncoding error:nil];
    NSLog(dataStr);
    NSArray *tempArray = [dataStr componentsSeparatedByString: @"#"];
    for (NSString *line in tempArray){
        NSArray *tempLine = [dataStr componentsSeparatedByString: @","];
        [final addObject:tempLine];
    }
    NSLog(@"Array count %d", [final count]);
    return final;
}

-(NSMutableArray *) outputBrews {
    NSMutableArray *finallist;
    NSMutableArray *brewList = [self createArray];
    for (NSArray *brewery in brewList) {
        NSString *address = [NSString stringWithFormat:@"%@ %@", [brewery objectAtIndex:2], [brewery objectAtIndex:3]];
        CLLocationCoordinate2D current = [self geoCodeUsingAddress:address];
        CLLocation *here = [[CLLocation alloc] initWithLatitude:current.latitude longitude:current.longitude];
        CLLocationDistance distance = [self.locationManager.location distanceFromLocation:here];
        if(distance < 100000){
            [finallist addObject:[brewery objectAtIndex:1]];
        }
    }
    return finallist;
}



- (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address
{
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    return center;
}

- (NSMutableArray *) beers {
    NSMutableArray *list;
    NSMutableArray *brewIds = [self outputBrews];
    for (NSString *id in brewIds){
//        NSURLRequest *request = [NSURLRequest requestWithURL:
//                                 [NSURL URLWithString:[NSString stringWithFormat:@"http://api.brewerydb.com/v2/brewery/%@/beers/?key=079a83fb33046c975a4ff3475f1a4062", id]]];
//       (void) [[NSURLConnection alloc] initWithRequest:request delegate:self];
        NSString *query = [NSString stringWithFormat:@"http://api.brewerydb.com/v2/brewery/%@/beers/?key=079a83fb33046c975a4ff3475f1a4062", id];
        query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSStringFromSelector(_cmd), query;
        NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
        NSDictionary *data = results[@"data"];
        for (NSDictionary *beer in data){
            [list addObject:beer[@"name"]];
        }
    }
    return list;

}



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
    NSArray *results = [res objectForKey:@"data"];
    
    for (NSDictionary *result in results) {
        NSString *icon = [result objectForKey:@"name"];
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
    //return [[self beers] count];
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSMutableArray *beerfinal = [self beers];

    //[[cell textLabel] setText:[beerfinal objectAtIndex:indexPath.row]];
    [[cell textLabel] setText:[array objectAtIndex:indexPath.row]];
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
    NSArray *objectArray = [[NSArray alloc] initWithObjects:@"Billtown Blonde", @"Edgar IPA", @"Hands Off Maibock", @"Inspiration Red", @"Susquehanna Oatmeal Stout", @"Cape of Good Hope", @"Cogh Ale", @"George Washington's Tavern Porter", @"Love Stout", @"Smoked", nil];
    array = objectArray;
//    selectedIndexes = [[NSMutableArray alloc] init];
    self.responseData = [NSMutableData data];

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
