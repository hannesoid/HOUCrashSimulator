//
//  HOUCrash.m
//  HOUCrashSimulatorDemo
//
//  Created by Hannes Oud on 05.03.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import "HOUCrash.h"

@implementation HOUCrash
- (id)initWithTitle: (NSString *) title crashBlock: (HOUCrashBlock) crashBlock
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _crashBlock = [crashBlock copy];
    }
    return self;
}
@end
