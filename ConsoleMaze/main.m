//
//  main.m
//  ConsoleMaze
//
//  Created by user on 5/23/17.
//  Copyright © 2017 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Maze.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Maze *maze = [[Maze alloc] initWithRows:11 columns:11];
        [maze printMaze];
    }
    return 0;
}
