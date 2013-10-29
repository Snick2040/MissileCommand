//
//  ViewController.m
//  MissileCommand
//
//  Created by Nick on 10/24/13.
//  Copyright (c) 2013 Nick. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSegueWithIdentifier:@"segueToGame" sender:self];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapToPlay:(id)sender {
    
    [self performSegueWithIdentifier:@"segueToGame" sender:self];
    
}

@end
