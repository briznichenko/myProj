//
//  CMaze.h
//  ConsoleMaze
//
//  Created by user on 5/24/17.
//  Copyright © 2017 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMaze : NSObject

@property(strong) NSMutableArray* a_maze;


- (instancetype)initWithRows:(NSInteger)rows columns:(NSInteger)columns;
- (void) printMaze;

@end
