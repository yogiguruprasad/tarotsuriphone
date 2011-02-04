//
//  SaisieNom4.h
//  Tarot2
//
//  Created by Aurélien SIGNE on 31/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Joueur.h"
#import "Tarot2AppDelegate.h"
#import "SaisieParametre.h"

@interface SaisieNom4 : UIViewController <UITextFieldDelegate> {
	UITextField *nomJ1;
	UITextField *nomJ2;
	UITextField *nomJ3;
	UITextField *nomJ4;
}

@property (nonatomic, retain) IBOutlet UITextField *nomJ1;
@property (nonatomic, retain) IBOutlet UITextField *nomJ2;
@property (nonatomic, retain) IBOutlet UITextField *nomJ3;
@property (nonatomic, retain) IBOutlet UITextField *nomJ4;

-(void) validerNom:(id)sender;

-(BOOL) textFieldShouldReturn:(UITextField *)textField;

@end
