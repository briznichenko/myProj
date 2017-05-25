//
//  Maze.h
//  HomeWorkMaze
//
//  Created by user on 5/23/17.
//  Copyright © 2017 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Maze : NSObject

@property(weak) NSMutableArray* a_maze;

- (instancetype)initWithRows:(NSInteger)rows columns:(NSInteger)columns;
- (void) printMaze;

@end
