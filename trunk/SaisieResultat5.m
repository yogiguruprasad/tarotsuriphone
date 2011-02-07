//
//  SaisieResultat5.m
//  Tarot2
//
//  Created by Aurélien SIGNE on 05/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SaisieResultat5.h"


@implementation SaisieResultat5
@synthesize score;
@synthesize monPickerView;
@synthesize chelem;
@synthesize petitAuBout;
@synthesize validerResultat;
@synthesize validerScore;

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

- (void)viewDidLoad {
	chelem.on=NO;
	self.title = @"Résultat";
	Tarot2AppDelegate *app = (Tarot2AppDelegate*)[[UIApplication sharedApplication] delegate];
	app.nouvellePartie=NO;
	
	
	//creation du bouton pour voir les scores
	UIBarButtonItem *item = [[UIBarButtonItem alloc]   
                             initWithTitle:@"Scores" style:UIBarButtonItemStyleBordered
                             target:self   
                             action:@selector(afficherScore)];  
    self.navigationItem.rightBarButtonItem = item;
	[item release];
	
	//initialisation textField score
	[score setText:@"Score de l'attaque"];
	[score setDelegate:self];
	
	//pickerView pour le nb de bouts et le petit au bout
	monPickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    CGSize pickerSize = [monPickerView sizeThatFits:CGSizeZero];
	CGRect pickerRect = CGRectMake(0.0,100.0,pickerSize.width,180);
	monPickerView.frame = pickerRect;
    monPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    monPickerView.showsSelectionIndicator = YES; // Par défaut, non
    monPickerView.delegate = self;
    monPickerView.dataSource = self;
	[self.view addSubview:monPickerView];
	[monPickerView release];
	
	//creation de la liste des joueurs
	joueursArray = [[NSMutableArray alloc] init];	
	NSInteger i;
	for (i=0; i<[[app joueurs] count]; i++) {
		[joueursArray insertObject:(NSString*)[[app.joueurs objectAtIndex:i] nom]atIndex:i];
	}
	
	//creation de la liste des nb de bouts
	nbBoutsArray = [[NSArray alloc] initWithObjects:
					@"Aucun",@"1 bout",@"2 bouts",@"3 bouts",nil];
	
	//creation de la liste des petit au bout
	petitAuBoutArray = [[NSArray alloc] initWithObjects:
						@"Personne",@"Attaque",@"Défense",nil];
	
    [super viewDidLoad];
}

//cacher le bouton pour valider le score
-(void) afficherBtnValiderScore:(id)sender{
	validerScore.hidden=NO;
}

//retirer la clavier apres avoir ecrit le score
-(void) retirerClavier:(id)sender{
	[score resignFirstResponder];	
	validerScore.hidden=YES;
}

//validation du resultat et affichage des scores
-(void) validerResultat:(id)sender{
	Tarot2AppDelegate *app = (Tarot2AppDelegate*)[[UIApplication sharedApplication] delegate];
	
	//initialisation des variables à 0
	NSInteger scoreAObtenir = 0;
	NSInteger coeffMulti = 0;
	NSInteger primeChelem = 0;
	NSInteger primePetitAuBout = 0;
	NSInteger primePoignee = 0;
	NSInteger scoreTotal = 0;
	
	//recuperation du score saisi
	NSInteger scoreObtenu = [score.text integerValue];
	
	//determination du score a obtenir en fonction du nombre de bouts
	switch ([monPickerView selectedRowInComponent:0]) {
		case 0://aucun bout
			scoreAObtenir=56;
			break;
		case 1://1 bout
			scoreAObtenir=51;
			break;
		case 2://2 bouts
			scoreAObtenir=41;
			break;
		case 3://3 bouts
			scoreAObtenir=36;
			break;
		default:
			break;
	}
	
	//determination de 25 ou -25
	if((scoreObtenu - scoreAObtenir)>0){
		//attaque gagne
		scoreTotal = 25;
	}
	else {
		//attaque perd
		scoreTotal = -25;
	}
	
	//determination du coeff multiplicateur en fonction du contrat
	switch ([app contrat]) {
		case 0://petite
			coeffMulti=1;
			break;
		case 1://garde
			coeffMulti=2;
			break;
		case 2://garde sans
			coeffMulti=4;
			break;
		case 3://garde contre
			coeffMulti=6;
			break;
		default:
			break;
	}
	
	//determination de la prime pour le petit au bout
	switch ([monPickerView selectedRowInComponent:2]){
		case 0:
			//persone
			break;
		case 1:
			//dernier pli pour l'attaque
			primePetitAuBout = 10*coeffMulti;
			break;
		case 2:
			//dernier pli pour la défense
			if((scoreObtenu - scoreAObtenir)>0){
				//attaque gagne
				primePetitAuBout = -10*coeffMulti;
			}
			else {
				//attaque perd
				primePetitAuBout = 10*coeffMulti;
			}
			break;
		default:
			break;
	}
	
	//determination de la prime pour le chelem
	switch ([app chelem]) {
		case 0:
			//aucun
			if(chelem.on){
				//aucun chelem annoncé
				if((scoreObtenu - scoreAObtenir)>0){
					//si chelem réussi pour l'attaque
					primeChelem=200;
				}
				else {
					//si chelem réussi pour la défense
					primeChelem=-200;
				}
			}
			else {
				primeChelem=0;
			}
			break;
		case 1:
			//chelem attaque
			if(chelem.on){
				//si chelem reussi par l'attaque
				primeChelem=400;
			}
			else {
				//si chelem raté par l'attaque
				primeChelem=-200;
			}
			break;
		case 2:
			//chelem defense
			if(chelem.on){
				//si chelem reussi par la defense
				primeChelem=-400;
			}
			else {
				//si chelem raté par la defense
				primeChelem=200;
			}
			break;
		default:
			break;
	}
	
	//determination de la prime pour la poignée
	switch ([app poignee]){
		case 1:
			//Simple attaque
			primePoignee = 20;
			break;
		case 2:
			//Double attaque
			primePoignee = 30;
			break;
		case 3:
			//Triple attaque
			primePoignee = 40;
			break;
		default:
			break;
	}
	if((scoreObtenu - scoreAObtenir)<0){
		//dans le cas d'une victoire de la défense 	
		primePoignee = -primePoignee;
	}
	
	//score calcule pour le preneur (attaque)
	/*scoreTotal =	+ ou - 25 
	 + (difference entre le score obtenu et le score à obtenir) * le coeff multiplicateur
	 + prime de la poignee
	 + prime du petit au bout
	 + prime du chelem
	 */
	scoreTotal = (scoreTotal+(scoreObtenu - scoreAObtenir))*coeffMulti+ primePoignee + primePetitAuBout + primeChelem;
	
	//mise a jour des scores de chaque joueur
	NSInteger i;
	if(![app typePartage]){
		for (i=0; i<[[app joueurs] count]; i++) {
			if([[app joueurs] objectAtIndex:i] == [app preneur] || 
			   [[app joueurs] objectAtIndex:i] == [[app joueurs] objectAtIndex:[monPickerView selectedRowInComponent:1]]){
				//preneur
				[[[app joueurs] objectAtIndex:i] modifierScore:(scoreTotal*1.5)];
			}
			else{
				//joueurs de la défense
				[[[app joueurs] objectAtIndex:i] modifierScore:-scoreTotal];
			}
		}
	}
	else{
		for (i=0; i<[[app joueurs] count]; i++) {
			if([[app joueurs] objectAtIndex:i] == [app preneur]){
				//preneur
				[[[app joueurs] objectAtIndex:i] modifierScore:(scoreTotal*2)];
			}
			else if([[app joueurs] objectAtIndex:i] == [[app joueurs] objectAtIndex:[monPickerView selectedRowInComponent:1]]){
				//appele
				[[[app joueurs] objectAtIndex:i] modifierScore:scoreTotal];
			}
			else{
				//joueurs de la défense
				[[[app joueurs] objectAtIndex:i] modifierScore:-scoreTotal];
			}
		}
	}
	app.nouvellePartie=YES;
	
	[self afficherScore];
}


-(void) afficherScore{
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
		else if (component == 1)
			returnStr = [joueursArray objectAtIndex:row];
		else if (component == 2)
			returnStr = [petitAuBoutArray objectAtIndex:row];
	}
	return returnStr;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    CGFloat componentWidth = 0.0;
    if(pickerView == monPickerView){
		if (component == 0)
			componentWidth = 95.0;
		else if (component == 1)
			componentWidth = 110.0;
		else if (component == 2)
			componentWidth = 115.0;
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
		else if(component==1)
			nbLignes = [joueursArray count];
		else if(component==2)
			nbLignes = [petitAuBoutArray count];
	}
	return nbLignes;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	NSInteger nbComponents = 0;
	if(pickerView == monPickerView)
		nbComponents = 3;
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
	[nbBoutsArray release];
	[petitAuBoutArray release];
    [super dealloc];
}


@end
