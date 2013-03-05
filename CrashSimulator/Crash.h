//
//  Crash.h
//  CrashSimulatorDemo
//
//  Created by Hannes Oud on 05.03.13.
//  Copyright (c) 2013 Hannes Oud. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CrashBlock)(void);

@interface Crash : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) CrashBlock crashBlock;

- (id)initWithTitle: (NSString *) title crashBlock: (CrashBlock) crashBlock;
@end
