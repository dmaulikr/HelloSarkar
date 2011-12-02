//
//  ComplainTypeViewController.m
//  HelloSarkar
//
//  Created by nepal on 26/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ComplainTypeViewController.h"

@implementation ComplainTypeViewController

@synthesize complainTypeListTableView;
@synthesize complainTypeCodeListArray;
@synthesize complainTypeListArray;
@synthesize selectedIndex;
@synthesize selectedComplainTypeCode;
@synthesize delegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        complainTypeCodeListArray =[[NSMutableArray alloc] init];
        complainTypeListArray =[[NSMutableArray alloc] init];
    }
    return self;
}

-(id)initWithComplainTypeCode:(NSString *)_complainTypeCode{
    if((self = [super init])){
        // Custom initialization
        complainTypeCodeListArray =[[NSMutableArray alloc] init];
        complainTypeListArray =[[NSMutableArray alloc] init];
        selectedComplainTypeCode = _complainTypeCode;
	}
	return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	complainTypeListTableView.backgroundColor = [UIColor clearColor];

    [self prepareComplainTypeList];

    selectedIndex = [complainTypeCodeListArray indexOfObjectIdenticalTo:selectedComplainTypeCode];
    NSLog(@"CODE --> %@", selectedComplainTypeCode);
    NSLog(@"SELECTED INDEX --> %d", selectedIndex);
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark ---------- UITABLEVIEW DELEGATE METHODS ----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {    
    return [complainTypeListArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell..
    [self configureCell:cell atIndexPath:indexPath];
    
	return cell;
}

// Configure CELL
-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleGray;   
    cell.textLabel.text = (NSString *)[complainTypeListArray objectAtIndex:indexPath.row];
    if (indexPath.row == selectedIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (selectedIndex >= 0) {
        NSIndexPath *formalIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        cell = [tableView cellForRowAtIndexPath:formalIndexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    selectedIndex = indexPath.row;
    cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [delegate selectedComplainType:[complainTypeListArray objectAtIndex:indexPath.row] withCode:[complainTypeCodeListArray objectAtIndex:indexPath.row]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark ---------- CUSTOM METHODS ----------
-(void)prepareComplainTypeList {    
    NSDictionary *complainTypeDictionary = [[[NSDictionary alloc] init] autorelease];
    for (int i = 0; i < [SharedStore store].complainTypeArray.count; i++) {
        complainTypeDictionary = (NSDictionary *)[[SharedStore store].complainTypeArray objectAtIndex:i];
        
        [complainTypeListArray addObject:[complainTypeDictionary valueForKey:@"text"]];
        [complainTypeCodeListArray addObject:[complainTypeDictionary valueForKey:@"code"]];
    }    
    
    // DUMMY DATA
    [complainTypeListArray addObjectsFromArray:[NSArray arrayWithObjects:@"General", @"Robbery", @"Thuggery", nil]];
    [complainTypeCodeListArray addObjectsFromArray:[NSArray arrayWithObjects:@"Gn", @"Rob", @"Tug", nil]];

    NSLog(@"COMPLAIN TYPES --> %@", complainTypeListArray);
    NSLog(@"COMPLAIN TYPES --> %@", complainTypeCodeListArray);
}


#pragma mark - 
#pragma mark ---------- MEMORY MANAGEMENT ----------

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [complainTypeListTableView release];
    [complainTypeCodeListArray release];
    [complainTypeListArray release];
    [selectedComplainTypeCode release];
    [super dealloc];
}
@end
