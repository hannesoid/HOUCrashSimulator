//
//  Crash.m
//  CrashSimulatorDemo
//
//  Created by Hannes Oud on 05.03.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import "Crash.h"

@implementation Crash
- (id)initWithTitle: (NSString *) title crashBlock: (CrashBlock) crashBlock
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _crashBlock = [crashBlock copy];
    }
    return self;
}
@end
