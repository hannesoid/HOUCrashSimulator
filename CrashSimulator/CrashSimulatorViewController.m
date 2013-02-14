//
//  CrashSimulatorViewController.m
//  CrashSimulatorDemo
//
//  Created by Hannes Oud on 14.02.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import "CrashSimulatorViewController.h"
#import "CrashSimulator.h"

@interface CrashSimulatorViewController () {
    CGFloat _minimizedHeight;
    CGFloat _maximizedHeight;
    BOOL _maximized;
}
 
@property (weak, nonatomic) IBOutlet UIButton *mainToggleButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CrashSimulatorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _minimizedHeight = CGRectGetHeight(self.mainToggleButton.frame);
    _maximizedHeight = _minimizedHeight + CGRectGetHeight(self.tableView.frame);
    
    [self adjustLayoutToMinimizedOrMaximized];
}

#pragma mark - Table View


#pragma mark - minimizing / maximizing

- (IBAction)toggleMinimizedMaximized {
    _maximized = !_maximized;
    [self adjustLayoutToMinimizedOrMaximized];
}

- (void) adjustLayoutToMinimizedOrMaximized {
    CGFloat newHeight = _maximized ? _maximizedHeight : _minimizedHeight;
    
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, CGRectGetWidth(self.view.frame), newHeight);
}

@end
