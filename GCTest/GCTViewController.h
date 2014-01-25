//
//  GCTViewController.h
//  GCTest
//
//  Created by Roberto Scarciello on 24/01/14.
//  Copyright (c) 2014 Roberto Scarciello. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameController/GameController.h"

@interface GCTViewController : UIViewController

@property (nonatomic, assign) BOOL controllerConnected;
@property (nonatomic, assign) BOOL pause;
@property (nonatomic, strong) GCController *gameController;

@property (nonatomic, strong) IBOutlet UILabel *status;
@property (nonatomic, strong) IBOutlet UILabel *vendor;
@property (nonatomic, strong) IBOutlet UILabel *LS;
@property (nonatomic, strong) IBOutlet UILabel *RS;
@property (nonatomic, strong) IBOutlet UILabel *LT;
@property (nonatomic, strong) IBOutlet UILabel *RT;
@property (nonatomic, strong) IBOutlet UILabel *A;
@property (nonatomic, strong) IBOutlet UILabel *B;
@property (nonatomic, strong) IBOutlet UILabel *X;
@property (nonatomic, strong) IBOutlet UILabel *Y;
@property (nonatomic, strong) IBOutlet UIImageView *up;
@property (nonatomic, strong) IBOutlet UIImageView *left;
@property (nonatomic, strong) IBOutlet UIImageView *right;
@property (nonatomic, strong) IBOutlet UIImageView *down;
@property (nonatomic, strong) IBOutlet UIImageView *LTA;
@property (nonatomic, strong) IBOutlet UIImageView *RTA;
@property (nonatomic, strong) IBOutlet UIImageView *LTM;
@property (nonatomic, strong) IBOutlet UIImageView *RTM;
@property (nonatomic, strong) IBOutlet UIImageView *pauseButton;

@end
