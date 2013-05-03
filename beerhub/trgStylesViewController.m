//
//  trgStylesViewController.m
//  beerhub
//
//  Created by Teddy Guenin on 5/3/13.
//  Copyright (c) 2013 Teddy Guenin. All rights reserved.
//

#import "trgStylesViewController.h"

@interface trgStylesViewController ()
{
    NSArray *array;
    NSMutableArray *selected;
}

@end

@implementation trgStylesViewController

@synthesize myTableView;
@synthesize selectedIndexes;
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *objectArray = [[NSArray alloc] initWithObjects:@"English-Style India Pale Ale", @"Ordinary Bitter", @"Scottish-Style Light Ale", @"English-Style Brown Ale", @"Scotch Ale", @"American-Style India Pale Ale", @"American-Style Pale Ale", @"American-Style Amber/Red Ale", @"French & Belgian-Style Saison", @"American-Style Brown Ale", @"American-Style Stout", @"Imperial or Double India Pale Ale", @"Extra Special Bitter", @"Light American Wheat Ale or Lager with Yeast", @"American-Style Premium Lager", @"Brown Porter", @"Belgian-Style Pale Ale", @"American-Style Imperial Stout", @"Wood- and Barrel-Aged Beer", nil];
    array = objectArray;
    selectedIndexes = [[NSMutableArray alloc] init];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    if([self.selectedIndexes containsObject:indexPath]){
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [selected addObject:[array objectAtIndex:indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [selected removeObject:[array objectAtIndex:indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [[cell textLabel] setText:[array objectAtIndex:indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    return cell;    
}

- (NSMutableArray *) selectedArrays {
    return selected;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([self.selectedIndexes containsObject:indexPath]){
        [self.selectedIndexes removeObject:indexPath];
    } else {
        [self.selectedIndexes addObject:indexPath];
    }
    [tableView reloadData];
    
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

@end
