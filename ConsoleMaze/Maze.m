//
//  Maze.m
//  HomeWorkMaze
//
//  Created by user on 5/23/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "Maze.h"
#include <stdlib.h>

@implementation Maze

-(instancetype)initWithRows:(NSInteger)rows columns:(NSInteger)columns
{
    self = [super init];
    
    if(self)
        {
            self.a_maze = [NSMutableArray array];
            for (int column = 0; column < columns; column++)
            {
                NSMutableArray *columnArray = [NSMutableArray array];
            
                for (int row = 0; row < rows; row++)
                    [columnArray addObject:[NSNumber numberWithInt:1]];
            
                [self.a_maze addObject:columnArray];
            }
            self.a_maze = [self buildMaze:self.a_maze];
        }
    

        return self;

    }

- (NSMutableArray*)buildMaze:(NSMutableArray*) unbuilt_maze
{
    int horizontal_bound[] = {0, unbuilt_maze.count - 1};
    NSMutableArray* vertical_bound = [NSMutableArray array];
    
    for (int i = 1; i < unbuilt_maze.count - 1; i++)
        [vertical_bound addObject:[NSNumber numberWithInt:i]];

    int row = arc4random_uniform(unbuilt_maze.count - 1);
    int column = 0;
    
    //start point
    if(row == 0)
    {
        column = arc4random_uniform([vertical_bound count]  - 1);
        [unbuilt_maze[row] replaceObjectAtIndex:column withObject:[NSNumber numberWithInt:8]];
    }
    else if (row == unbuilt_maze.count - 1)
    {
        column = arc4random_uniform(vertical_bound.count - 1);
         [unbuilt_maze[row] replaceObjectAtIndex:column withObject:[NSNumber numberWithInt:8]];
    }
    else
    {
        column = horizontal_bound[arc4random_uniform(2)];
        [unbuilt_maze[row] replaceObjectAtIndex:column withObject:[NSNumber numberWithInt:8]];
    }
    
    //building a path
    NSMutableDictionary* path = [NSMutableDictionary dictionary];
    NSDictionary* current_position = @{@"y":@(row), @"x":@(column)};
    [path setObject:current_position forKey:@"Entry"];
    NSLog(@"%@", current_position);
    
    
    //making first move
    long x = [[current_position valueForKey:@"x"] longValue];
    long y = [[current_position valueForKey:@"y"] longValue];
    
    if(y == 0)
    {
        current_position = [self down:current_position];
        long x = [[current_position valueForKey:@"x"] longValue];
        long y = [[current_position valueForKey:@"y"] longValue];
        [unbuilt_maze[y] replaceObjectAtIndex:x withObject:@"0"];
    }
    else if (y == (unbuilt_maze.count - 1))
    {
        current_position = [self up:current_position];
        long x = [[current_position valueForKey:@"x"] longValue];
        long y = [[current_position valueForKey:@"y"] longValue];
        [unbuilt_maze[y] replaceObjectAtIndex:x withObject:@"0"];
    }
    else if (x)
    {
        current_position = [self up:current_position];
        long x = [[current_position valueForKey:@"x"] longValue];
        long y = [[current_position valueForKey:@"y"] longValue];
        [unbuilt_maze[y] replaceObjectAtIndex:x withObject:@"0"];
    }

    

    
    while (([current_position valueForKey:@"x"] > [NSNumber numberWithInt: 0] && [current_position valueForKey:@"x"] < [NSNumber numberWithInt: vertical_bound.count - 1]) &&
           ([current_position valueForKey:@"y"] > [vertical_bound firstObject] && [current_position valueForKey:@"y"] < [vertical_bound lastObject]))
    {
        
    }
    
    
    NSMutableArray* built_maze = unbuilt_maze;
    return built_maze;
}

//movement

-(NSDictionary*) up:(NSDictionary*) position
{
    long x = [[position valueForKey:@"x"] longValue];
    long y = [[position valueForKey:@"y"] longValue] - 1;
    NSDictionary* new_position = @{@"x":@(x), @"y":@(y)};
    return new_position;
}

-(NSDictionary*) down:(NSDictionary*) position
{
    long x = [[position valueForKey:@"x"] longValue];
    long y = [[position valueForKey:@"y"] longValue] + 1;
    NSDictionary* new_position = @{@"x":@(x), @"y":@(y)};
    return new_position;
}

-(NSDictionary*) left:(NSDictionary*) position
{
    long x = [[position valueForKey:@"x"] longValue] - 1;
    long y = [[position valueForKey:@"y"] longValue];
    NSDictionary* new_position = @{@"x":@(x), @"y":@(y)};
    return new_position;
}

-(NSDictionary*) right:(NSDictionary*) position
{
    long x = [[position valueForKey:@"x"] longValue] + 1;
    long y = [[position valueForKey:@"y"] longValue];
    NSDictionary* new_position = @{@"x":@(x), @"y":@(y)};
    return new_position;
}


-(void)printMaze
{
    NSString* maze = @"\r";
    for(NSArray* array in self.a_maze){
        maze = [maze stringByAppendingString:[[array valueForKey:@"description"] componentsJoinedByString:@" "]];
        maze = [maze stringByAppendingString:@"\r"];
    }
    NSLog(@"%@", maze);
}

@end
