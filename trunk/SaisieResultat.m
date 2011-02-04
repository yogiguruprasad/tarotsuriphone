//
//  SaisieResultat.m
//  Tarot2
//
//  Created by Aurélien SIGNE on 01/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SaisieResultat.h"


@implementation SaisieResultat
@synthesize score;
@synthesize monPickerView;
@synthesize chelem;
@synthesize petitAuBout;
@synthesize validerResultat;

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
	self.title = @"Résultat";
	UIBarButtonItem *item = [[UIBarButtonItem alloc]   
                             initWithTitle:@"Scores" style:UIBarButtonItemStyleBordered
                             target:self   
                             action:@selector(afficherScore:)];  
    self.navigationItem.rightBarButtonItem = item;  
	
	
	
	
	[score setText:@"46"];
	[score setDelegate:self];
	
	monPickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    CGSize pickerSize = [monPickerView sizeThatFits:CGSizeZero];
	CGRect pickerRect = CGRectMake(0.0,100.0,pickerSize.width,162.0);
	monPickerView.frame = pickerRect;
	
    monPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    monPickerView.showsSelectionIndicator = YES; // Par défaut, non
    
    monPickerView.delegate = self;
    monPickerView.dataSource = self;
	
	nbBoutsArray = [[NSArray alloc] initWithObjects:
					 @"Aucun",@"1 bout",@"2 bouts",@"3 bouts",nil];
	
	[self.view addSubview:monPickerView];
    [super viewDidLoad];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
	if(textField == score)
		[score resignFirstResponder];
	return YES;
}


-(void) validerResultat:(id)sender{
	NSInteger scoreAObtenir=0;
	NSInteger scoreObtenu=0;
	NSInteger scoreTotal=0;
	NSInteger coeffMulti=0;
	NSInteger primeChelem=0;
	NSInteger primePetitAuBout=0;
	NSInteger primePoignee=0;
	
	scoreObtenu = [score.text integerValue];
	
	Tarot2AppDelegate *app = (Tarot2AppDelegate*)[[UIApplication sharedApplication] delegate];
	
	switch ([monPickerView selectedRowInComponent:0]) {
		case 0:
			scoreAObtenir=56;
			break;
		case 1:
			scoreAObtenir=51;
			break;
		case 2:
			scoreAObtenir=41;
			break;
		case 3:
			scoreAObtenir=36;
			break;
		default:
			break;
	}
	
	switch ([app contrat]) {
		case 0:
			//petite
			coeffMulti=1;
			break;
		case 1:
			//garde
			coeffMulti=2;
			break;
		case 2:
			//garde sans
			coeffMulti=4;
			break;
		case 3:
			//garde contre
			coeffMulti=6;
			break;
		default:
			break;
	}
	
	if(petitAuBout.on)
		primePetitAuBout=10;
	else
		primePetitAuBout=0;
	
	
	if(chelem.on){
		//chelem realise
		if([app chelem]==0)
			//chelem non annonce
			primeChelem = 200;
		else if([app chelem] == 1)
			//chelem annonce
			primeChelem = 400;
	}
	else if(!chelem.on){
		//chelem non realise
		if([app chelem]==0)
			//chelem non annonce
			primeChelem = 0;
		else if([app chelem] == 1)
			//chelem annonce
			primeChelem = -200;
	}
	
	//voir pour la poignée
	switch ([app poignee]) {
		case 0:
			//Aucune poignee
			primePoignee = 0;
			break;
		case 1:
			//Simple
			primePoignee = 20;
			break;
		case 2:
			//Double
			primePoignee = 30;
			break;
		case 3:
			//Triple
			primePoignee = 40;
			break;
		default:
			break;
	}

	//score calcule pour le preneur(attaque)
	scoreTotal = (25+(ABS(scoreAObtenir-scoreObtenu)))*coeffMulti + primePoignee + primePetitAuBout*coeffMulti + primeChelem;
//	NSLog([NSString stringWithFormat:@"%d",scoreTotal]);
	
	NSInteger i;
	if((scoreObtenu - scoreAObtenir)<0){
		//attaque perd
		for (i=0; i<[[app joueurs] count]; i++) {
			if([[app joueurs] objectAtIndex:i] == [app preneur]){
			//preneur
				[[[app joueurs] objectAtIndex:i] modifierScore:-(scoreTotal*3)];
			}
			else{
			//joueur de la défense
				[[[app joueurs] objectAtIndex:i] modifierScore:(scoreTotal)];
			}
				
		}
	}
	else{
		//attaque gagne
		for (i=0; i<[[app joueurs] count]; i++) {
			if([[app joueurs] objectAtIndex:i] == [app preneur]){
				//preneur
				[[[app joueurs] objectAtIndex:i] modifierScore:(scoreTotal*3)];
			}
			else{
				//joueur de la défense
				[[[app joueurs] objectAtIndex:i] modifierScore:-(scoreTotal)];
			}
			
		}
	}
	app.nouvellePartie=YES;
	AffichageScores *affichageScores = [[AffichageScores alloc] init];//WithNibName:@"affichageScores" bundle:nil];
	[self.navigationController pushViewController:affichageScores animated:YES];
	[affichageScores release];
}

-(void) afficherScore:(id)sender{
	AffichageScores *affichageScores = [[AffichageScores alloc] init];//WithNibName:@"affichageScores" bundle:nil];
	[self.navigationController pushViewController:affichageScores animated:YES];
	[affichageScores release];
}



#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *returnStr = @"";
	if(pickerView == monPickerView){
		if (component == 0)
			returnStr = [nbBoutsArray objectAtIndex:row];
		}
    return returnStr;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    CGFloat componentWidth = 0.0;
    if(pickerView == monPickerView){
		if (component == 0)
			componentWidth = 320.0;
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
	if(pickerView == monPickerView){
		if(component==0)
			nbLignes = [nbBoutsArray count];
	}
	return nbLignes;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	NSInteger nbComponents = 0;
	if(pickerView == monPickerView)
		nbComponents = 1;
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
