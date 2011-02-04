//
//  SaisieResultat.h
//  Tarot2
//
//  Created by Aurélien SIGNE on 01/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tarot2AppDelegate.h"
#import "AffichageScores.h"

@interface SaisieResultat : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>{
	UITextField *score;
	UIPickerView *monPickerView;
	NSArray *nbBoutsArray;
	UISwitch *chelem;
	UISwitch *petitAuBout;
	UIButton *validerResultat;
}

@property(nonatomic, retain) IBOutlet UITextField *score;
@property(nonatomic, retain) IBOutlet UIPickerView *monPickerView;
@property(nonatomic, retain) IBOutlet UISwitch *chelem;
@property(nonatomic, retain) IBOutlet UISwitch *petitAuBout;
@property(nonatomic, retain) IBOutlet UIButton *validerResultat;

-(void) validerResultat:(id)sender;
-(void) afficherScore:(id)sender;

@end
