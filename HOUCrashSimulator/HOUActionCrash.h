//
//  HOUCrash.h
//  HOUCrashSimulatorDemo
//
//  Created by Hannes Oud on 05.03.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HOUCrash.h"

typedef void(^HOUCrashBlock)(void);

@interface HOUActionCrash : NSObject<HOUCrash>

- (id)initWithTitle: (NSString *) title crashBlock: (HOUCrashBlock) crashBlock;

/**
 * Calls the crashBlock provided on construction
 */
- (void)crash;

@end
