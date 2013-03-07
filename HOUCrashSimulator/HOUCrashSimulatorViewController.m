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
    
    CGSize _initialSize;
    
    CGFloat _maxWidthInRelationToContainer;
    CGFloat _maxHeightInRelationToContainer;
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
    
    _maxWidthInRelationToContainer = 0.7f;
    _maxHeightInRelationToContainer = 0.6f;
    
    _initialSize = self.view.bounds.size;
    
    [self adjustLayoutToMinimizedOrMaximizedAnimated:NO];
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    self.view.frame = [self niceFrameForContainingRect:parent.view.bounds]; // a recommended rect 
}

#pragma mark - Layout ...
- (void)viewDidLayoutSubviews {
    _maximizedHeight = floorf(MIN(self.view.superview.bounds.size.height*_maxHeightInRelationToContainer, _initialSize.height));
    [self adjustLayoutToMinimizedOrMaximizedAnimated:NO];
}

- (CGRect) niceFrameForContainingRect: (CGRect) container {
    _maximizedHeight = floorf(MIN(container.size.height*_maxHeightInRelationToContainer, _initialSize.height));
    CGSize size = CGSizeMake(floorf(container.size.width * _maxWidthInRelationToContainer), _maximizedHeight);
    CGPoint offset = CGPointMake((container.size.width - size.width) / 2.f, 0.f);
    CGRect rect = CGRectMake(offset.x, offset.y, size.width, _minimizedHeight);
    return rect;
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
    id<HOUCrash> crash = [self.crashSimulator crashAtIndexPath:indexPath];
    
    UITableViewCell *cell;

    if ([crash isKindOfClass:[HOUActionCrash class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"crashCell"];
    } else if ([crash isKindOfClass:[HOUToggleableCrash class]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"toggleCell"];
        BOOL currentlyEnabled = ((HOUToggleableCrash *) crash).enabled;
        cell.accessoryType = currentlyEnabled ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = crash.title;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id<HOUCrash> crash = [self.crashSimulator crashAtIndexPath:indexPath];
    if ([crash isKindOfClass:[HOUActionCrash class]]) {
        [((HOUActionCrash *) crash) crash];
    } else if ([crash isKindOfClass:[HOUToggleableCrash class]]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        BOOL currentlyEnabled = ((HOUToggleableCrash *) crash).enabled;
        BOOL enabled = !currentlyEnabled;
        ((HOUToggleableCrash *) crash).enabled = enabled;        
        cell.accessoryType = enabled ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
}

#pragma mark - Constructor
+ (instancetype) crashSimulatorViewController {
    return [[UIStoryboard storyboardWithName:@"HOUCrashSimulator" bundle:nil] instantiateInitialViewController];
}
@end
