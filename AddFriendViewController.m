    //
//  AddFriendViewController.m
//  KZ3Stats
//
//  Created by Paul Hameteman on 3/28/11.
//  Copyright 2011 AppSoluut. All rights reserved.
//

#import "AddFriendViewController.h"


@implementation AddFriendViewController
@synthesize db;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 20)];
		[labelName setText:@"Name:"];
		[[self view] addSubview:labelName];
		
		inputName = [[UITextView alloc] initWithFrame:CGRectMake(50, 20, self.view.frame.size.width - 50, 100)];
		[inputName setReturnKeyType:UIReturnKeyDone];
		[inputName setKeyboardType:UIKeyboardTypeDefault];
		[inputName setScrollEnabled:NO];
		[inputName setAutocorrectionType:UITextAutocorrectionTypeNo];
		[inputName setAutocapitalizationType:UITextAutocapitalizationTypeNone];
		[[inputName layer] setCornerRadius:5.0f];
		[inputName setClipsToBounds:YES];
		[[self view] addSubview:inputName];
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[labelName release];
	[inputName release];
	
    [super dealloc];
}


@end
