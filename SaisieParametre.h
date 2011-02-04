//
//  SaisieParametre.h
//  Tarot2
//
//  Created by Aurélien SIGNE on 31/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tarot2AppDelegate.h"
#import "SaisieResultat.h"

@interface SaisieParametre : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
	UISwitch *chelem;
	UITextField *poignee;
		
	UIPickerView *pickerViewPoignee;
	NSArray *poigneesArray;
	NSArray *chelemsArray;

	
	UIPickerView *monPickerView;
	NSArray *joueursArray;
	NSArray *contratsArray;
}

@property(nonatomic, retain) IBOutlet UISwitch* chelem;
@property(nonatomic, retain) IBOutlet UITextField* poignee;

-(void) validerParametres:(id)sender;

@end
