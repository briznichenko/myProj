//
//  MazeSolver.h
//  ConsoleMaze
//
//  Created by user on 5/25/17.
//  Copyright © 2017 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MazeSolver : NSObject

@property(weak) NSMutableArray* a_maze;

-(void)solveAMaze:(NSArray*) maze;

@end
