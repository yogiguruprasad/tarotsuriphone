//
//  AffichageScores.h
//  Tarot2
//
//  Created by Aurélien SIGNE on 01/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tarot2AppDelegate.h"


@interface AffichageScores : UIViewController {
	UILabel *nomJ1;
	UILabel *nomJ2;
	UILabel *nomJ3;
	UILabel *nomJ4;
	
	UILabel *scoreJ1;
	UILabel *scoreJ2;
	UILabel *scoreJ3;
	UILabel *scoreJ4;
}

@property (nonatomic,retain) IBOutlet UILabel* nomJ1;
@property (nonatomic,retain) IBOutlet UILabel* nomJ2;
@property (nonatomic,retain) IBOutlet UILabel* nomJ3;
@property (nonatomic,retain) IBOutlet UILabel* nomJ4;
@property (nonatomic,retain) IBOutlet UILabel* scoreJ1;
@property (nonatomic,retain) IBOutlet UILabel* scoreJ2;
@property (nonatomic,retain) IBOutlet UILabel* scoreJ3;
@property (nonatomic,retain) IBOutlet UILabel* scoreJ4;


-(void) revenirParametre:(id)sender;


@end
