//
//  SaisieNom4.m
//  Tarot2
//
//  Created by Aurélien SIGNE on 31/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SaisieNom4.h"


@implementation SaisieNom4
@synthesize nomJ1;
@synthesize nomJ2;
@synthesize nomJ3;
@synthesize nomJ4;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"Nom des joueurs";
	Tarot2AppDelegate *app = (Tarot2AppDelegate*)[[UIApplication sharedApplication] delegate];
	[nomJ1 setText:[[app.joueurs objectAtIndex:0] nom]];
	[nomJ1 setDelegate:self];
    [nomJ2 setText:[[app.joueurs objectAtIndex:1] nom]];
	[nomJ2 setDelegate:self];
	[nomJ3 setText:[[app.joueurs objectAtIndex:2] nom]];
	[nomJ3 setDelegate:self];
	[nomJ4 setText:[[app.joueurs objectAtIndex:3] nom]];
	[nomJ4 setDelegate:self];
	[super viewDidLoad];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
	if(textField == nomJ1)
		[nomJ1 resignFirstResponder];
	else if(textField == nomJ2)
		[nomJ2 resignFirstResponder];
	else if(textField == nomJ3)
		[nomJ3 resignFirstResponder];
	else if(textField == nomJ4)
		[nomJ4 resignFirstResponder];
	return YES;
}

-(void) validerNom:(id)sender{
	Tarot2AppDelegate *app = (Tarot2AppDelegate*)[[UIApplication sharedApplication] delegate];
	[[app.joueurs objectAtIndex:0] setNom:nomJ1.text];
	[[app.joueurs objectAtIndex:1] setNom:nomJ2.text];
	[[app.joueurs objectAtIndex:2] setNom:nomJ3.text];
	[[app.joueurs objectAtIndex:3] setNom:nomJ4.text];

	SaisieParametre *saisieParametre = [[SaisieParametre alloc] init];//WithNibName:@"saisieParametre" bundle:nil];
	[self.navigationController pushViewController:saisieParametre animated:YES];
	[saisieParametre release];
 }


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
    [super dealloc];
}


@end
