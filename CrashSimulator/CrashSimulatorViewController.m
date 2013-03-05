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

@property (strong, nonatomic) CrashSimulator *crashSimulator;

@end

@implementation CrashSimulatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _crashSimulator = [[CrashSimulator alloc] init];
    
    _minimizedHeight = CGRectGetHeight(self.mainToggleButton.frame);
    _maximizedHeight = _minimizedHeight + CGRectGetHeight(self.tableView.frame);
    _maximized = NO;
    
    [self adjustLayoutToMinimizedOrMaximizedAnimated:NO];
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    
    CGPoint offset = CGPointMake((parent.view.bounds.size.width - self.view.bounds.size.width) / 2.f, 0.f);
    self.view.frame = CGRectOffset(self.view.bounds, offset.x, offset.y);
    
}

#pragma mark - minimizing / maximizing

- (IBAction)toggleMinimizedMaximized {
    _maximized = !_maximized;
    [self adjustLayoutToMinimizedOrMaximizedAnimated:YES];
}

- (void) adjustLayoutToMinimizedOrMaximizedAnimated:(BOOL) animated {
    CGFloat newHeight = _maximized ? _maximizedHeight : _minimizedHeight;
    
    void (^animation)(void) = ^{
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, CGRectGetWidth(self.view.frame), newHeight);
    };
    if (animated) {
        [UIView animateWithDuration:0.2 animations:animation];
    } else {
        animation();
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.crashSimulator.crashSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((CrashSection *) self.crashSimulator.crashSections[section]).crashes.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return ((CrashSection *) self.crashSimulator.crashSections[section]).title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CrashSection *section = ((CrashSection *) self.crashSimulator.crashSections[indexPath.section]);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"crashCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"crashCell"];
    }
    Crash *crash = section.crashes[indexPath.row];
    cell.textLabel.text = crash.title;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Crash *crash = ((CrashSection *) self.crashSimulator.crashSections[indexPath.section]).crashes[indexPath.row];
    crash.crashBlock();
}

#pragma mark - Constructor
+ (instancetype) crashSimulatorViewController {
    return [[UIStoryboard storyboardWithName:@"CrashSimulator" bundle:nil] instantiateInitialViewController];
}
@end
