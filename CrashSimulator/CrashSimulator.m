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

- (void)simulateUIOnWrongThread:(UIButton *)button {
    
    static NSString *textBefore;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        textBefore =  button.titleLabel.text;
    });
    
    for (int i = 0; i < 300; i++) {
        double delayInSeconds = 0.01 * (double)i;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(popTime, queue, ^(void){
            button.titleLabel.text = [NSString stringWithFormat:@"%@: %d", textBefore, i];
        });
    }
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
