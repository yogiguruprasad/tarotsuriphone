//
//  Accueil.m
//  Tarot2
//
//  Created by Aurélien SIGNE on 31/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Accueil.h"


@implementation Accueil
	
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
	self.title = @"Accueil";
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	[super viewDidLoad];
}

-(void)saisieNom4joueurs:(id)sender{
	NSInteger nbJoueurs=4;
	NSInteger i;
	Tarot2AppDelegate *app = (Tarot2AppDelegate*)[[UIApplication sharedApplication] delegate];
	app.joueurs = [[NSMutableArray alloc] initWithCapacity:nbJoueurs];
	

	for (i=0; i<nbJoueurs; i++) {
		Joueur *joueurTemp=[[Joueur alloc] initWithNom:[NSString stringWithFormat:@"Joueur %d", i]];
		[app.joueurs addObject:joueurTemp];
		[joueurTemp release];
		
//		NSLog([[app.joueurs objectAtIndex:i] nom]);
	}
	
	/*
	Partie *unePartie;
	unePartie = [[Partie alloc] initWithNbJoueurs:4];
	
	NSLog([NSString stringWithFormat:@"Score %d",[[app.joueurs objectAtIndex:1] score]]);
	*/
	
	//NSLog([NSString stringWithFormat:@"Score %d",[[[unePartie joueurs] objectAtIndex:1] score]]);
	
	//NSLog([NSString stringWithFormat:@"Score %d",[[[app.maPartie joueurs] objectAtIndex:1] score]]);
	//NSLog([app.unJoueur nom]);
	
	
	
	/*joueurs = [[NSMutableArray alloc] initWithCapacity:(NSInteger)nbJoueurs];
	NSInteger i;
	for (i=0; i<nbJoueurs; i++) {
		Joueur *joueurTemp=[[Joueur alloc] initWithNom:[NSString stringWithFormat:@"Joueur %d", i]];
		[joueurs addObject:joueurTemp];
		//	NSLog([NSString stringWithFormat:@"Score %d",[joueurTemp score]]);
		[joueurTemp release];
	}
	for (i=0; i<nbJoueurs; i++) {
		//	NSLog([NSString stringWithFormat:@"Score %d",[[joueurs objectAtIndex:i] score]]);
	}
	*/
	
	//creation partie
	//Partie *partiee;
	//partiee = Tarot2AppDelegate.maPartie;
//	Tarot2AppDelegate.maPartie = [[Partie alloc] initWithNbJoueurs:4];
	

	
	SaisieNom4 *saisieNom4 = [[SaisieNom4 alloc] init];//WithNibName:@"saisieNom4" bundle:nil];
	[self.navigationController pushViewController:saisieNom4 animated:YES];
	[saisieNom4 release];
}
-(void)saisieNom5joueurs:(id)sender{
	
}
-(void)saisieNom6joueurs:(id)sender{
	
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
