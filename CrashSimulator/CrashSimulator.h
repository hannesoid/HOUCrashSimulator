//
//  CrashSimulator.h
//  CrashSimulatorDemo
//
//  Created by Hannes Oud on 14.02.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrashSimulator : NSObject

@property (nonatomic, assign) BOOL blockWhenGoingToBackground;

@property (nonatomic, assign) BOOL keepRunningTimer;

- (void)simulateSelectorException;

- (void)simulateOutOfBoundsException;

- (void)simulateBlockedMainthread;

- (void)simulateDeadlockOnMain;

- (void)simulateBadMemoryAccess;

- (void)simulateUIOnWrongThread:(UIButton *)button;

- (void)simulateAssertionError;

@end
