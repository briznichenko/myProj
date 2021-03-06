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
            rows = rows % 2 ? rows : (NSLog(@"Rows must be of odd value! Making it odd."), rows + 1);
            columns = columns % 2 ? columns : (NSLog(@"Columns must be of odd value! Making it odd."), columns + 1);
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
            
            NSDictionary* startPoint = [self generateStartPointForRows: rows columns: columns];
            int x = [[startPoint valueForKey:@"x"] intValue];
            int y = [[startPoint valueForKey:@"y"] intValue];;
            [self generateMaze:x y: y];
            [self makeValidEntries: rows columns: columns];
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
}


-(void)makeValidEntries:(NSInteger) rows columns:(NSInteger) columns
{
    int counter;
    int entry_counter = 0;
    NSArray* randomSides = [self generateRandomDirections];
    
    for (int side = 0; side < randomSides.count; side++)
        switch ((int)side) {
            case 0:
                for(int x = 1; x < (columns - 1); x+=2)
                {
                    counter = 0;
                    for(int i = (x - 1); i <= (x + 1); i++)
                        for(int j = 0; j < 3; j++)
                        {
                            if([self.a_maze[j][i] isEqual:@"*"])
                                counter++;
                        }
                    if(counter == 7 && entry_counter < 2)
                    {
                        entry_counter++;
                        self.a_maze[0][x] = @" ";
                    }
                }
                break;
                
            case 1:
                for(int y = 1; y < (rows - 1); y+=2)
                {
                    counter = 0;
                    for(long i = (columns - 1); i > (columns - 4); i--)
                        for(int j = (y - 1); j <= (y + 1); j++)
                        {
                            if([self.a_maze[j][i] isEqual:@"*"])
                                counter++;
                        }
                    if(counter == 7 && entry_counter < 2)
                    {
                        entry_counter++;
                        self.a_maze[y][columns - 1] = @" ";
                    }
                }
                break;
                
            case 2:
                for(int x = 1; x < (columns - 1); x+=2)
                {
                    counter = 0;
                    for(int i = (x - 1); i <= (x + 1); i++)
                        for(long j = (rows - 1); j > (rows - 4); j--)
                        {
                            if([self.a_maze[j][i] isEqual:@"*"])
                                counter++;
                        }
                    if(counter == 7 && entry_counter < 2)
                    {
                        entry_counter++;
                        self.a_maze[rows - 1][x] = @" ";
                    }
                }
                break;
                
            case 3:
                for(int y = 1; y < (rows - 1); y+=2)
                {
                    counter = 0;
                    for(int i = 0; i < 3; i++)
                        for(int j = (y - 1); j <= (y + 1); j++)
                        {
                            if([self.a_maze[j][i] isEqual:@"*"])
                                counter++;
                        }
                    if(counter == 7 && entry_counter < 2)
                    {
                        entry_counter++;
                        self.a_maze[y][0] = @" ";
                    }
                }
                break;
        }
    if(entry_counter < 2)
        [self generateRandomEntries:entry_counter rows:rows columns:columns];
}

-(NSDictionary*)generateStartPointForRows:(NSInteger) rows columns:(NSInteger) columns
{
    long x = arc4random_uniform(((int)rows) / 2) * 2 + 1;
    long y = arc4random_uniform((int)columns / 2) * 2 + 1;
    return @{@"x":@(x), @"y":@(y)};
    
}

-(void) generateRandomEntries:(int) entries rows:(NSInteger) rows columns:(NSInteger) columns
{
    long x = arc4random_uniform(((int)columns) / 2) * 2 + 1;
    long y = arc4random_uniform((int)rows / 2) * 2 + 1;
    int needed_entries = 0;
    needed_entries = (entries < 1) ?  2 : 1;
    for(int i = 0; i < needed_entries; i++)
        switch (arc4random_uniform(3)) {
            case 0:
                self.a_maze[0][x] = @" ";
                break;
                
            case 1:
                self.a_maze[y][columns - 1] = @" ";
                break;
                
            case 2:
                self.a_maze[rows - 1][x] = @" ";
                break;
                
            case 3:
                self.a_maze[y][0] = @" ";
                break;
        }
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
