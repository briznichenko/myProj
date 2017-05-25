//
//  main.m
//  ConsoleMaze
//
//  Created by user on 5/23/17.
//  Copyright © 2017 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Maze.h"
#import "MazeSolver.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Maze *maze = [[Maze alloc] initWithRows:25 columns:25];
        [maze printMaze];
        MazeSolver* solver = [[MazeSolver alloc] init];
        [solver solveAMaze:maze.a_maze];
    }
    return 0;
}
