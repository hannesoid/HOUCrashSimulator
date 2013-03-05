//
//  HOUCrashSimulatorViewController.m
//  HOUCrashSimulatorDemo
//
//  Created by Hannes Oud on 14.02.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import "HOUCrashSimulatorViewController.h"
#import "HOUCrashSimulator.h"
#import <QuartzCore/QuartzCore.h>

@interface HOUCrashSimulatorViewController () {
    CGFloat _minimizedHeight;
    CGFloat _minimizedAlpha;
    CGFloat _maximizedHeight;
    CGFloat _maximizedAlpha;
    BOOL _maximized;
}
 
@property (weak, nonatomic) IBOutlet UIButton *mainToggleButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) HOUCrashSimulator *crashSimulator;

@end

@implementation HOUCrashSimulatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _crashSimulator = [[HOUCrashSimulator alloc] init];
    
    _minimizedHeight = CGRectGetHeight(self.mainToggleButton.frame);
    _maximizedHeight = _minimizedHeight + CGRectGetHeight(self.tableView.frame);
    _maximized = NO;
    
    self.view.layer.borderColor = [[UIColor redColor] CGColor];
    self.view.layer.borderWidth = 1.f;

    _minimizedAlpha = 0.6f;
    _maximizedAlpha = 1.f;
    
    
    [self adjustLayoutToMinimizedOrMaximizedAnimated:NO];
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    
    _maximizedHeight = floorf(MAX(parent.view.bounds.size.height*0.6f,self.view.bounds.size.height));
    CGSize size = CGSizeMake(floorf(parent.view.bounds.size.width * 0.7f), _maximizedHeight);
    CGPoint offset = CGPointMake((parent.view.bounds.size.width - size.width) / 2.f, 0.f);
    self.view.frame = CGRectMake(offset.x, offset.y, size.width, _minimizedHeight);
    
}

#pragma mark - minimizing / maximizing

- (IBAction)toggleMinimizedMaximized {
    _maximized = !_maximized;
    [self adjustLayoutToMinimizedOrMaximizedAnimated:YES];
}

- (void) adjustLayoutToMinimizedOrMaximizedAnimated:(BOOL) animated {
    CGFloat newHeight = _maximized ? _maximizedHeight : _minimizedHeight;
    self.view.alpha = _maximized ? _maximizedAlpha : _minimizedAlpha;
    
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
    return ((HOUCrashSection *) self.crashSimulator.crashSections[section]).crashes.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return ((HOUCrashSection *) self.crashSimulator.crashSections[section]).title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HOUCrashSection *section = ((HOUCrashSection *) self.crashSimulator.crashSections[indexPath.section]);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"crashCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"crashCell"];
    }
    HOUCrash *crash = section.crashes[indexPath.row];
    cell.textLabel.text = crash.title;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HOUCrash *crash = ((HOUCrashSection *) self.crashSimulator.crashSections[indexPath.section]).crashes[indexPath.row];
    crash.crashBlock();
}

#pragma mark - Constructor
+ (instancetype) crashSimulatorViewController {
    return [[UIStoryboard storyboardWithName:@"HOUCrashSimulator" bundle:nil] instantiateInitialViewController];
}
@end
