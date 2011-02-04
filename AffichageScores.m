//
//  AffichageScores.m
//  Tarot2
//
//  Created by Aurélien SIGNE on 01/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AffichageScores.h"


@implementation AffichageScores
@synthesize nomJ1;
@synthesize nomJ2;
@synthesize nomJ3;
@synthesize nomJ4;
@synthesize scoreJ1;
@synthesize scoreJ2;
@synthesize scoreJ3;
@synthesize scoreJ4;

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
	self.title = @"Scores";
	Tarot2AppDelegate *app = (Tarot2AppDelegate*)[[UIApplication sharedApplication] delegate];
	
	if(app.nouvellePartie){
		UIBarButtonItem *item2 = [[UIBarButtonItem alloc]   
								  initWithTitle:@"Nouvelle Partie" style:UIBarButtonItemStyleBordered
								  target:self   
								  action:@selector(revenirParametre:)];  
		app.nouvellePartie=NO;
		self.navigationItem.leftBarButtonItem = item2; 
	}
		
	
	
	
	nomJ1.text = [[[app joueurs] objectAtIndex:0] nom];
	nomJ2.text = [[[app joueurs] objectAtIndex:1] nom];
	nomJ3.text = [[[app joueurs] objectAtIndex:2] nom];
	nomJ4.text = [[[app joueurs] objectAtIndex:3] nom];
	scoreJ1.text = [NSString stringWithFormat:@"%d",[[[app joueurs] objectAtIndex:0] score]];
	scoreJ2.text = [NSString stringWithFormat:@"%d",[[[app joueurs] objectAtIndex:1] score]];
	scoreJ3.text = [NSString stringWithFormat:@"%d",[[[app joueurs] objectAtIndex:2] score]];
	scoreJ4.text = [NSString stringWithFormat:@"%d",[[[app joueurs] objectAtIndex:3] score]];
	
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


-(void) revenirParametre:(id)sender{
	NSArray *allControleurs = [self.navigationController viewControllers];
	[self.navigationController popToViewController:[allControleurs objectAtIndex:2] animated:YES];
}


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
