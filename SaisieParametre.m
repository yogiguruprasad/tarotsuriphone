//
//  SaisieParametre.m
//  Tarot2
//
//  Created by Aurélien SIGNE on 31/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SaisieParametre.h"


@implementation SaisieParametre
@synthesize chelem;
@synthesize poignee;

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
	self.title = @"Paramètres";
	UIBarButtonItem *item = [[UIBarButtonItem alloc]   
                             initWithTitle:@"Scores" style:UIBarButtonItemStyleBordered
                             target:self   
                             action:@selector(afficherScore:)];  
    self.navigationItem.rightBarButtonItem = item;  
	
	
	Tarot2AppDelegate *app = (Tarot2AppDelegate*)[[UIApplication sharedApplication] delegate];
	app.nouvellePartie=NO;
	
	monPickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    CGSize pickerSize = [monPickerView sizeThatFits:CGSizeZero];
	CGRect pickerRect = CGRectMake(0.0,
								   23.0,
								   pickerSize.width,
								   162.0);
	
	monPickerView.frame = pickerRect;
	
    monPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    monPickerView.showsSelectionIndicator = YES; // Par défaut, non
    
    monPickerView.delegate = self;
    monPickerView.dataSource = self;
	
	
	pickerViewPoignee = [[UIPickerView alloc] initWithFrame:CGRectZero];
	CGRect pickerRectPoignee = CGRectMake( 0.0,
								   210.0,
								   pickerSize.width,
								   162.0);
	
	
	//CGRect pickerRectPoignee = CGRectMake(175.0, 215.0, 150.0, 100.0);
	
	pickerViewPoignee.frame = pickerRectPoignee;
	
    pickerViewPoignee.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    pickerViewPoignee.showsSelectionIndicator = YES; // Par défaut, non
    
    pickerViewPoignee.delegate = self;
    pickerViewPoignee.dataSource = self;
	
	
	
	
	[self.view addSubview:monPickerView];
	
	
	[self.view addSubview:pickerViewPoignee];
	
	joueursArray = [[NSArray alloc] initWithObjects:
					   (NSString*) [[app.joueurs objectAtIndex:0] nom],
					   (NSString*) [[app.joueurs objectAtIndex:1] nom],
					   (NSString*) [[app.joueurs objectAtIndex:2] nom],
					   (NSString*) [[app.joueurs objectAtIndex:3] nom],nil];
	
	contratsArray = [[NSArray alloc] initWithObjects:
					   @"Petite",@"Garde",@"Garde sans",@"Garde Contre",nil];
	
	poigneesArray = [[NSArray alloc] initWithObjects:
					 @"Aucune",@"Simple (10)",@"Double (13)",@"Triple (15)",nil];
	
	chelemsArray = [[NSArray alloc] initWithObjects:
					 @"Non annoncé",@"Annoncé",nil];
	
	
	[super viewDidLoad];
}

-(void) validerParametres:(id)sender{
	Tarot2AppDelegate *app = (Tarot2AppDelegate*)[[UIApplication sharedApplication] delegate];
	[app setChelem:(NSInteger) [pickerViewPoignee selectedRowInComponent:1]];
	[app setPoignee:[pickerViewPoignee selectedRowInComponent:0]];
	[app setPreneur:[app.joueurs objectAtIndex:[monPickerView selectedRowInComponent:0]]];
	[app setContrat:[monPickerView selectedRowInComponent:1]];

	SaisieResultat *saisieResultat = [[SaisieResultat alloc] init];//WithNibName:@"saisieResultat" bundle:nil];
	[self.navigationController pushViewController:saisieResultat animated:YES];
	[saisieResultat release];
}

-(void) afficherScore:(id)sender{
	AffichageScores *affichageScores = [[AffichageScores alloc] init];//WithNibName:@"affichageScores" bundle:nil];
	[self.navigationController pushViewController:affichageScores animated:YES];
	[affichageScores release];
}


#pragma mark -
#pragma mark UIPickerViewDelegate

/*- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	
	Tarot2AppDelegate *app = (Tarot2AppDelegate*)[[UIApplication sharedApplication] delegate];
	self.contrat = [NSString stringWithFormat:@"%@",
			   [contratsArray objectAtIndex:[pickerView selectedRowInComponent:1]]];
	
	preneur = [app.joueurs objectAtIndex:[pickerView selectedRowInComponent:0]];
}*/

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *returnStr = @"";
	if(pickerView == pickerViewPoignee){
		if (component == 0)
			returnStr = [poigneesArray objectAtIndex:row];
		else if (component == 1)
			returnStr = [chelemsArray objectAtIndex:row];
	}
	else if(pickerView == monPickerView){
	if (component == 0)
		returnStr = [joueursArray objectAtIndex:row];
	else if (component == 1)
		returnStr = [contratsArray objectAtIndex:row];
	}
    return returnStr;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    CGFloat componentWidth = 0.0;
    if(pickerView == pickerViewPoignee){
		if (component == 0)
			componentWidth = 160.0;
		else if (component == 1)
			componentWidth = 160.0;		
	}
	else if(pickerView == monPickerView){
		if (component == 0)
			componentWidth = 160.0;
		else if (component == 1)
			componentWidth = 160.0;
	}
    return componentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	NSInteger nbLignes = 0;
	if(pickerView == pickerViewPoignee){
		if(component==0)
			nbLignes = [poigneesArray count];
		else if(component==1)
			nbLignes = [chelemsArray count];		
	}
	else if(pickerView == monPickerView){
		if(component==0)
			nbLignes = [joueursArray count];
		else if(component==1)
			nbLignes = [contratsArray count];
	}
	return nbLignes;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	NSInteger nbComponents = 0;
	if(pickerView == monPickerView)
		nbComponents = 2;
	else if(pickerView == pickerViewPoignee)
		nbComponents = 2;
	return nbComponents;
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
