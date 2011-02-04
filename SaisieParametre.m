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
@synthesize contrat;
@synthesize preneur;
@synthesize segmentedController;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"Paramètres";
	
	//creation du bouton pour voir les scores
	UIBarButtonItem *item = [[UIBarButtonItem alloc]   
                             initWithTitle:@"Scores" style:UIBarButtonItemStyleBordered
                             target:self   
                             action:@selector(afficherScore:)];  
    self.navigationItem.rightBarButtonItem = item;  
	[item release];
	
	Tarot2AppDelegate *app = (Tarot2AppDelegate*)[[UIApplication sharedApplication] delegate];
	app.nouvellePartie=NO;
	
	//pickerView pour le preneur et le contrat
	monPickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    CGSize pickerSize = [monPickerView sizeThatFits:CGSizeZero];
	CGRect pickerRect = CGRectMake(0.0, 50.0, pickerSize.width, 216.0);
	monPickerView.frame = pickerRect;
    monPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    monPickerView.showsSelectionIndicator = YES; // Par défaut, non
	monPickerView.delegate = self;
    monPickerView.dataSource = self;
//	[monPickerView selectRow:0 inComponent:0 animated:YES];
//	[monPickerView selectRow:0 inComponent:1 animated:YES];
	[self.view addSubview:monPickerView];
	[monPickerView release];
	
	//pickerView pour la poignee et le chelem
	pickerViewPoignee = [[UIPickerView alloc] initWithFrame:CGRectZero];
	CGRect pickerRectPoignee = CGRectMake( 0.0, 50, pickerSize.width, 216.0);
	pickerViewPoignee.frame = pickerRectPoignee;
    pickerViewPoignee.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    pickerViewPoignee.showsSelectionIndicator = YES; // Par défaut, non
	pickerViewPoignee.delegate = self;
    pickerViewPoignee.dataSource = self;
	[self.view addSubview:pickerViewPoignee];
	[pickerViewPoignee selectRow:0 inComponent:0 animated:NO];
	[pickerViewPoignee selectRow:0 inComponent:1 animated:NO];

	[pickerViewPoignee release];
	//on cache pickerViewPoignee
	pickerViewPoignee.hidden=YES;
	
	//creation de la liste des joueurs
	joueursArray = [[NSArray alloc] initWithObjects:
					(NSString*) [[app.joueurs objectAtIndex:0] nom],
					(NSString*) [[app.joueurs objectAtIndex:1] nom],
					(NSString*) [[app.joueurs objectAtIndex:2] nom],
					(NSString*) [[app.joueurs objectAtIndex:3] nom],nil];
	
	//creation de la liste des contrats
	contratsArray = [[NSArray alloc] initWithObjects:
					 @"Petite",@"Garde",@"Garde sans",@"Garde Contre",nil];
	
	//creation de la liste des poignees
	poigneesArray = [[NSArray alloc] initWithObjects:
					 @"Aucune",@"Simple (10)",@"Double (13)",@"Triple (15)",nil];
	
	//creation de la liste des chelem
	chelemsArray = [[NSArray alloc] initWithObjects:
					@"Non annoncé",@"Attaque",@"Défense",nil];
	
	
	//creation bouton segmentation
	segmentedController.selectedSegmentIndex = 0;
	[segmentedController addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	[segmentedController release]; 
	[super viewDidLoad];

}

//action pour changer "d'onglet"
- (IBAction)segmentAction:(id)sender{
	segmentedController = (UISegmentedControl *)sender;
	if(segmentedController.selectedSegmentIndex == 0){
		pickerViewPoignee.hidden=YES;
		monPickerView.hidden=NO;
		poignee.hidden=YES;
		preneur.hidden=NO;
		chelem.hidden=YES;
		contrat.hidden=NO;
	}
	else if(segmentedController.selectedSegmentIndex == 1){
		monPickerView.hidden=YES;
		pickerViewPoignee.hidden=NO;
		preneur.hidden=YES;
		poignee.hidden=NO;
		contrat.hidden=YES;
		chelem.hidden=NO;
	}
}

//validation des parametres de la partie
-(void) validerParametres:(id)sender{
	Tarot2AppDelegate *app = (Tarot2AppDelegate*)[[UIApplication sharedApplication] delegate];
	[app setChelem:(NSInteger) [pickerViewPoignee selectedRowInComponent:1]];
	[app setPoignee:[pickerViewPoignee selectedRowInComponent:0]];
	[app setPreneur:[app.joueurs objectAtIndex:[monPickerView selectedRowInComponent:0]]];
	[app setContrat:[monPickerView selectedRowInComponent:1]];
	
	//changement de "page"
	SaisieResultat *saisieResultat = [[SaisieResultat alloc] init];
	[self.navigationController pushViewController:saisieResultat animated:YES];
	[saisieResultat release];
}

//afficher les scores
-(void) afficherScore:(id)sender{
	AffichageScores *affichageScores = [[AffichageScores alloc] init];
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
			componentWidth = 158.0;
		else if (component == 1)
			componentWidth = 158.0;		
	}
	else if(pickerView == monPickerView){
		if (component == 0)
			componentWidth = 158.0;
		else if (component == 1)
			componentWidth = 158.0;
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
	[joueursArray release];
	[poigneesArray release];
	[contratsArray release];
	[chelemsArray release];
    [super dealloc];
}


@end
