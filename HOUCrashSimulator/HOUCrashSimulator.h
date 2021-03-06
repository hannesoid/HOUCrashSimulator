//
//  HOUCrashSimulator.h
//  HOUCrashSimulatorDemo
//
//  Created by Hannes Oud on 14.02.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HOUCrashSection.h"
#import "HOUActionCrash.h"
#import "HOUToggleableCrash.h"

@interface HOUCrashSimulator : NSObject

@property (nonatomic, assign) BOOL blockWhenGoingToBackground;

@property (nonatomic, assign) BOOL keepRunningTimer;

@property (strong, nonatomic) NSMutableArray *crashSections;

- (id<HOUCrash>) crashAtIndexPath: (NSIndexPath *) indexPath;

- (void)simulateSelectorException;

- (void)simulateOutOfBoundsException;

- (void)simulateBlockedMainthread;

- (void)simulateDeadlockOnMain;

- (void)simulateBadMemoryAccess;

- (void)simulateUIOnWrongThread;

- (void)simulateAssertionError;

@end
