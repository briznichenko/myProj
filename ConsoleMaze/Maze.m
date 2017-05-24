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
            for (int row = 0; row < rows; row++)
            {
                NSMutableArray *columnArray = [NSMutableArray array];
            
                for (int column = 0; column < columns; column++){
                    if(row == 0 || row == (rows - 1) || column == 0 || column == (columns - 1))
                        [columnArray addObject:@"*"];//wall
                    else if (!(row % 2) || !(column % 2))
                        [columnArray addObject:@"*"];//cell
                    else
                        [columnArray addObject:@"0"];
                }
                
            
                [self.a_maze addObject:columnArray];
            }
            NSDictionary* startPoint = [self generateStartPoint];
            int x = [[startPoint valueForKey:@"x"] intValue];
            int y = [[startPoint valueForKey:@"y"] intValue];;
            [self generateMaze:x y: y];
        }
    

        return self;

    }



-(void)generateMaze:(int) x y:(int) y
{
    self.a_maze[x][y] = @" ";
    NSArray* randomDirs = [self generateRandomDirections];
    for (int i = 0; i < randomDirs.count; i++)
    {
        switch ([randomDirs[i] intValue])
        {
            case 0:
                if (x - 2 <= 0)
                    continue;
                if (![[self.a_maze[x - 2][y] description] isEqual: @" "]){
                    self.a_maze[x - 2][y] = @" ";
                    self.a_maze[x - 1][y] = @" ";
                    [self generateMaze:x - 2 y: y];
                }
                break;
                
            case 1:
                if (y + 2 >= ((int)self.a_maze.count - 1))
                    continue;
                if (![[self.a_maze[x][y + 2] description] isEqual: @" "])
                {
                    self.a_maze[x][y + 2] = @" ";
                    self.a_maze[x][y + 1] = @" ";
                    [self generateMaze:x y: y + 2];
                }
                break;
                
            case 2:
                if (x + 2 >= ((int)[self.a_maze[0] count] - 1))
                    continue;
                if (![[self.a_maze[x + 2][y] description] isEqual: @" "])
                {
                    self.a_maze[x + 2][y] = @" ";
                    self.a_maze[x + 1][y] = @" ";
                    [self generateMaze:x + 2 y: y];
                }
                break;
                
            case 3:
                if (y - 2 <= 0)
                    continue;
                if (![[self.a_maze[x][y - 2] description] isEqual: @" "])
                {
                    self.a_maze[x][y - 2] = @" ";
                    self.a_maze[x][y - 1] = @" ";
                    [self generateMaze:x y: y - 2];
                }
                break;

        }
    }
    NSLog(@"%i, %i", x, y);
}

-(NSDictionary*)generateStartPoint
{
    long x = arc4random_uniform((int)self.a_maze.count / 2) * 2 + 1;
    long y = arc4random_uniform((int)[self.a_maze[0] count] / 2) * 2 + 1;
    return @{@"x":@(x), @"y":@(y)};

}

-(NSArray*) generateRandomDirections
{
    NSMutableArray* randomNums = [NSMutableArray array];
    while(randomNums.count < 4){
        NSNumber* randomNum = [NSNumber numberWithInt:arc4random_uniform(4)];
        if([randomNums containsObject:randomNum])
            randomNum = [NSNumber numberWithInt:arc4random_uniform(4)];
        else
            [randomNums addObject:randomNum];
    }
    return randomNums;
}

-(void) generateEntryAndExitPoints
{
    //Todo
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
