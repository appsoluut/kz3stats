//
//  FriendsListViewController.m
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/24/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import "FriendsListViewController.h"


@implementation FriendsListViewController
@synthesize fetchedResultsController;
@synthesize managedObjectContext;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
		[self setTitle:NSLocalizedString(@"FriendsKey", @"")];
		
		UIBarButtonItem *addFriendButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriendButtonClicked:)];
		self.navigationItem.rightBarButtonItem = addFriendButton;
		[addFriendButton release], addFriendButton = nil;
	}
    return self;
}

#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Friends" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    friendsObjects = [[NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:nil]] retain];
    [fetchRequest release], fetchRequest = nil;
    
//	
//	friends = [[NSMutableArray alloc] initWithArray:[self.db readFriendsFromDatabase]];
	[self setEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
	
//	[friends removeAllObjects];
//	[friends release], friends = nil;
//    
    [friendsObjects release], friendsObjects = nil;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return [friends count];
    return [friendsObjects count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Friends *friend = [friendsObjects objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[friend name]];
    
    // Configure the cell...
	//Friend *friend = [friends objectAtIndex:indexPath.row];
    
	//[[cell textLabel] setText:[friend name]];
//	NSLog(@"%@ has %i kills!", [friend name], [friend kills]);
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        /*
		[db deleteFriend:[(Friend *)[friends objectAtIndex:indexPath.row] name]];
		[friends removeObjectAtIndex:indexPath.row];
         */
        NSManagedObject *friend = [friendsObjects objectAtIndex:indexPath.row];
        [managedObjectContext deleteObject:friend];
        [managedObjectContext save:nil];

        [friendsObjects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Bar buttons
- (void)addFriendButtonClicked:(id)sender {
	UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"AddAFriendKey", @"")
													 message:@"\n"
													delegate:self
										   cancelButtonTitle:NSLocalizedString(@"CancelKey", @"")
										   otherButtonTitles:NSLocalizedString(@"AddKey", @""), nil];
	
	username = [[UITextField alloc] initWithFrame:CGRectMake(12, 45, 260, 25)];
	[username setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
	[username setAdjustsFontSizeToFitWidth:NO];
	[username setPlaceholder:NSLocalizedString(@"UsernameKey", @"")];
	[username setAutocorrectionType:UITextAutocorrectionTypeNo];
	[username setAutocapitalizationType:UITextAutocapitalizationTypeNone];
	[username setBackgroundColor:[UIColor whiteColor]];
	[username setKeyboardType:UIKeyboardTypeDefault];
	[username setKeyboardAppearance:UIKeyboardAppearanceAlert];
	[username setReturnKeyType:UIReturnKeyDone];
	[username setDelegate:self];
	[prompt addSubview:username];

	[prompt show];
	[prompt release];
}

#pragma mark -
#pragma mark Handle add friend prompt
- (void)didPresentAlertView:(UIAlertView *)alertView {
	[username becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[username resignFirstResponder];
	[self alertView:nil clickedButtonAtIndex:1];
	return YES;
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 0) {
		// Cancel
	} else {
		if ([[username text] length] > 0) {
            NSError *error;
            
            NSManagedObject *friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friends" inManagedObjectContext:self.managedObjectContext];
            [friend setValue:[username text] forKey:@"name"];
            if ( ![self.managedObjectContext save:&error] ) {
                DLog(@"Can't save due to: %@", [error description]);
            }
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Friends" inManagedObjectContext:managedObjectContext];
            [fetchRequest setEntity:entity];
            friendsObjects = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] retain];
            [fetchRequest release], fetchRequest = nil;
            
			[self.tableView reloadData];

            /*
			Friend *friend = [[Friend alloc] initWithName:[username text] kills:0 dbId:0];
			[friends addObject:friend];
			[self.db addFriend:[friend name]];
			
			[friend release];
             */
		}
	}
	
	[username release];
	username = nil;
}



@end

