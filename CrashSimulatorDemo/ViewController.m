//
//  ViewController.m
//  CrashSimulatorDemo
//
//  Created by Hannes Oud on 14.02.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import "ViewController.h"
#import "HOUCrashSimulatorViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // attach a HOUCrashSimulatorViewController
    HOUCrashSimulatorViewController *crashSimulatorViewController = [HOUCrashSimulatorViewController crashSimulatorViewController];

    //this triggers willMoveToParentViewController, which makes the HOUCrashSimulatorViewController set up an appropriate size
    [self addChildViewController:crashSimulatorViewController];
    
    [self.view addSubview:crashSimulatorViewController.view];
    [crashSimulatorViewController didMoveToParentViewController:self];
}

@end
