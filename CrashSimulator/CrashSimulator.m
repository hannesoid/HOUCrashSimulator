//
//  CrashSimulator.m
//  CrashSimulatorDemo
//
//  Created by Hannes Oud on 14.02.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import "CrashSimulator.h"

@implementation CrashSimulator {
    BOOL _expanded;
    int _timerCount;
    NSTimer *_timer;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _expanded = NO;
        _timerCount = 0;
        _blockWhenGoingToBackground = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        

        _crashSections = [[NSMutableArray alloc] init];
        __weak CrashSimulator *this = self;
        

        // init _crashSections...
        [_crashSections addObject:
         [[CrashSection alloc] initWithTitle:@"Exceptions" crashes:@[
          
          [[Crash alloc] initWithTitle:@"Unknown Selector" crashBlock:^{
             [this simulateSelectorException];}],
          
          [[Crash alloc] initWithTitle:@"Out of Bounds" crashBlock:^{
             [this simulateOutOfBoundsException];}],
          
          [[Crash alloc] initWithTitle:@"NSAssertion Error" crashBlock:^{
             [this simulateAssertionError];}]

          ]]];
        
        
        [_crashSections addObject:
         [[CrashSection alloc] initWithTitle:@"Memory" crashes:@[
          
          [[Crash alloc] initWithTitle:@"Bad Access" crashBlock:^{
             [this simulateBadMemoryAccess];}],
          
          [[Crash alloc] initWithTitle:@"Out of Bounds" crashBlock:^{
             [this simulateOutOfBoundsException];}],
          
          ]]];
        
        [_crashSections addObject:
         [[CrashSection alloc] initWithTitle:@"Blocking" crashes:@[
          
          [[Crash alloc] initWithTitle:@"Deadlock on Main" crashBlock:^{
             [this simulateDeadlockOnMain];}],
          
          [[Crash alloc] initWithTitle:@"Infinite loop on Main" crashBlock:^{
             [this simulateBlockedMainthread];}],
          
          ]]];
        
        [_crashSections addObject:
         [[CrashSection alloc] initWithTitle:@"Threading" crashes:@[
          
          [[Crash alloc] initWithTitle:@"UIKit on wrong Thread" crashBlock:^{
             [this simulateUIOnWrongThread];}],
          
          ]]];

        
    }
    return self;
}


- (void)simulateSelectorException {
    [self performSelector:@selector(nonExistingSelector) withObject:self];
}

- (void)simulateOutOfBoundsException {
    [@[@"1"] objectAtIndex:10];
}

- (void)simulateBlockedMainthread {
    dispatch_async(dispatch_get_main_queue(), ^(){
        while (YES) {
            // do nothing in here
        }
    });
}

- (void)simulateDeadlockOnMain {
    dispatch_sync(dispatch_get_main_queue(), ^() {
        // this will never be called
    });
}

- (void)simulateBadMemoryAccess {
    CGColorRef color;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wall"
    CGColorGetAlpha(color);
#pragma clang diagnostic pop    
}

- (void)simulateUIOnWrongThread {
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    
    NSString *textBefore = @"runs";
    
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(0,0,200,50)];
    label.center = CGPointMake(CGRectGetMidX(mainWindow.bounds), CGRectGetMidY(mainWindow.bounds));
    [mainWindow addSubview:label];

    dispatch_time_t popTime;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 300; i++) {
        double delayInSeconds = 0.01 * (double)i;
        popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, queue, ^{
            label.text = [NSString stringWithFormat:@"%@: %d", textBefore, i];
        });
    }
    dispatch_after(popTime, queue, ^{[label removeFromSuperview];});
}

- (void)simulateAssertionError {
    NSAssert(1 > 2, @"Intended Assertion Eror");
}

#pragma mark - property: keepRunningTimer
- (BOOL) keepRunningTimer {
    return _timer != nil;
}

- (void)setKeepRunningTimer:(BOOL)keepRunningTimer {
    [_timer invalidate];
    _timer = nil;
    if (keepRunningTimer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCallBack:) userInfo:nil repeats:YES];
    } else {
        _timerCount ++;
    }
}

- (void) timerCallBack: (NSTimer *) timer {
    _timerCount++;
}

#pragma mark - Notifications
- (void) applicationDidEnterBackground: (NSNotification *) notification {
    if (self.blockWhenGoingToBackground) {
        sleep(20);
    }
}

#pragma mark - Cleanup
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
