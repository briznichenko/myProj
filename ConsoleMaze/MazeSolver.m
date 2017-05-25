//
//  MazeSolver.m
//  ConsoleMaze
//
//  Created by user on 5/25/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "MazeSolver.h"

@implementation MazeSolver


-(void)solveAMaze:(NSArray*) maze
{
    self.a_maze = maze;
    int height = (int)maze.count;
    int width = (int)[maze[0] count];
//    struct cell current_cell = [self findEntries:self.a_maze];
    NSLog(@"%@", [self findEntries:self.a_maze]);
}

-(NSDictionary*)findEntries:(NSArray*) maze
{
    NSDictionary* entryCell = @{@"x":@(0), @"y":@(0)};
//    for(int y = 0; y < maze.count; y+=((int)maze.count - 1))
//        entryCell = @{@"x":@(0), @"y":@(0)}
    return entryCell;
}

@end
