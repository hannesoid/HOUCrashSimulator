//
//  HOUCrash.h
//  HOUCrashSimulatorDemo
//
//  Created by Hannes Oud on 05.03.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^HOUCrashBlock)(void);

@interface HOUCrash : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) HOUCrashBlock crashBlock;

- (id)initWithTitle: (NSString *) title crashBlock: (HOUCrashBlock) crashBlock;
@end
