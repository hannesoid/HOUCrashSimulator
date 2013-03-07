//
//  HOUToggleableCrash.h
//  CrashSimulatorDemo
//
//  Created by Hannes Oud on 07.03.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import "HOUActionCrash.h"
#import "HOUCrash.h"

typedef void(^HOUSetEnabledBlock)(BOOL enabled);

typedef BOOL(^HOUIsEnabledBlock)();

@interface HOUToggleableCrash : NSObject<HOUCrash>

/**
 * Delegates getting and setting to the setEnabled and isEnabled blocks provided on construction
 */
@property (nonatomic, assign) BOOL enabled;


- (id)initWithTitle: (NSString *) title setEnabledBlock:(HOUSetEnabledBlock) setEnabled isEnabledBlock:(HOUIsEnabledBlock) isEnabled;

@end
