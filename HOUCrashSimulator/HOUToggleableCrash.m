//
//  HOUToggleableCrash.m
//  CrashSimulatorDemo
//
//  Created by Hannes Oud on 07.03.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import "HOUToggleableCrash.h"
@interface HOUToggleableCrash()

@property (nonatomic, copy) HOUSetEnabledBlock setEnabledBlock;

@property (nonatomic, copy) HOUIsEnabledBlock isEnabledBlock;

@end

@implementation HOUToggleableCrash {
    NSString *_title;
}

- (id)initWithTitle: (NSString *) title setEnabledBlock:(HOUSetEnabledBlock) setEnabled isEnabledBlock:(HOUIsEnabledBlock) isEnabled
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _setEnabledBlock = [setEnabled copy];
        _isEnabledBlock = [isEnabled copy];
    }
    return self;
}

- (NSString *)title {
    return _title;
}

- (BOOL)enabled {
    return self.isEnabledBlock();
}

- (void)setEnabled:(BOOL)enabled {
    self.setEnabledBlock(enabled);
}

@end
