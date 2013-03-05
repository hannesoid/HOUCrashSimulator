//
//  CrashSection.h
//  CrashSimulatorDemo
//
//  Created by Hannes Oud on 05.03.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Crash.h"

@interface CrashSection : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSMutableArray *crashes;

- (id)initWithTitle:(NSString *)title crashes:(NSArray *)crashes;

@end

