//
//  ViewController.m
//  CrashSimulatorDemo
//
//  Created by Hannes Oud on 14.02.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import "ViewController.h"
#import "CrashSimulatorViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CrashSimulatorViewController *crashSimulatorViewController = [CrashSimulatorViewController crashSimulatorViewController];
    [self addChildViewController:crashSimulatorViewController];
    [self.view addSubview:crashSimulatorViewController.view];
    [crashSimulatorViewController didMoveToParentViewController:self];

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
