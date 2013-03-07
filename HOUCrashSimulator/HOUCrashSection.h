//
//  HOUCrashSection.h
//  HOUCrashSimulatorDemo
//
//  Created by Hannes Oud on 05.03.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HOUActionCrash.h"

/**
 * Contains a title and an array intended for id<HOUCrash>es
 */
@interface HOUCrashSection : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSMutableArray *crashes;

- (id)initWithTitle:(NSString *)title crashes:(NSArray *)crashes;

@end

