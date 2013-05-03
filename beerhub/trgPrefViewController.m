//
//  trgPrefViewController.m
//  beerhub
//
//  Created by Teddy Guenin on 5/2/13.
//  Copyright (c) 2013 Teddy Guenin. All rights reserved.
//

#import "trgPrefViewController.h"
#import "trgDataParse.h"

@interface trgPrefViewController ()

@property (weak, nonatomic) NSMutableArray * selectedIndexes;

@end

@implementation trgPrefViewController

@synthesize array;
@synthesize selectedIndexes;

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
    NSArray *objectArray = [[NSArray alloc] initWithObjects:@"English-Style India Pale Ale", @"Ordinary Bitter", @"Scottish-Style Light Ale", @"English-Style Brown Ale", @"Scotch Ale", @"American-Style India Pale Ale", @"American-Style Pale Ale", @"American-Style Amber/Red Ale", @"French & Belgian-Style Saison", @"American-Style Brown Ale", @"American-Style Stout", @"Imperial or Double India Pale Ale", @"Extra Special Bitter", @"Light American Wheat Ale or Lager with Yeast", @"American-Style Premium Lager", @"Brown Porter", @"Belgian-Style Pale Ale", @"American-Style Imperial Stout", @"Wood- and Barrel-Aged Beer", nil];
    array = objectArray;
    NSLog(@"count = %d", [array count]);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
//    
//    if ([selectedCell accessoryType] == UITableViewCellAccessoryNone) {
//        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
//        [selectedIndexes addObject:[NSNumber numberWithInt:indexPath.row]];
//    } else {
//        [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
//        [selectedIndexes removeObject:[NSNumber numberWithInt:indexPath.row]];
//    }
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"count = %d", [array count]);
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


@end
