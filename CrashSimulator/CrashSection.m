//
//  CrashSection.m
//  CrashSimulatorDemo
//
//  Created by Hannes Oud on 05.03.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import "CrashSection.h"

@implementation CrashSection
- (id)initWithTitle:(NSString *)title crashes: (NSArray *)crashes
{
    self = [super init];
    
    if (self) {
        _crashes = [[NSMutableArray alloc] initWithArray:crashes];
        _title = title;
    }
    
    return self;
}
@end
