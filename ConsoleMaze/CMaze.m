//
//  CMaze.m
//  ConsoleMaze
//
//  Created by user on 5/24/17.
//  Copyright © 2017 user. All rights reserved.
//

#import "CMaze.h"

@implementation CMaze

struct cell{
    unsigned int x;
    unsigned int y;
} cell;

struct cellString{
    struct cell* cells;
    unsigned int size;
} cellString;


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
                if(row == 0 || row == (rows - 1) || column == 0 || column == (columns - 1) || !(column % 2) || !(row % 2))
                    [columnArray addObject:@"*"];
                else
                    [columnArray addObject:[NSNumber numberWithInt: 0]];
            }
            
            [self.a_maze addObject:columnArray];
        }
    }
    
    return self;
    
}


-(void) genMaze: (NSArray *) empty_maze
{
    struct cell startCell = {1, 1};
    struct cell currentCell = startCell;
    struct cell neighbourCell;
    do{
        struct cellString Neighbours = [self getNeighbours:((int)empty_maze.count - 1) height:((int)[empty_maze[0] count] - 1) maze:empty_maze cell:startCell distance:2];
//        getNeighbours(width, height, maze, startPoint, 2);
        if(Neighbours.size != 0){ //если у клетки есть непосещенные соседи
            randNum  = randomRange(0, Neighbours.size-1);
            neighbourCell = cellStringNeighbours.cells[randNum]; //выбираем случайного соседа
            push(d.startPoint); //заносим текущую точку в стек
            maze = removeWall(currentCell, neighbourCell, maze); //убираем стену между текущей и сосендней точками
            currentCell = neighbourCell; //делаем соседнюю точку текущей и отмечаем ее посещенной
            maze = setMode(d.startPoint, d.maze, VISITED);
            free(cellStringNeighbours.cells);
        }
        else if(stackSize > 0){ //если нет соседей, возвращаемся на предыдущую точку
            startPoint = pop();
        }
        else{ //если нет соседей и точек в стеке, но не все точки посещены, выбираем случайную из непосещенных
            cellString cellStringUnvisited = getUnvisitedCells(width, height, maze);
            randNum = randomRange(0, cellStringUnvisited.size-1);
            currentCell = cellStringUnvisited.cells[randNum];
            free(cellStringUnvisited.cells);
        };
    }
        while(unvisitedCount() > 0);
    }

-(struct cellString) getNeighbours: (unsigned int) width height: (unsigned int) height maze: (NSArray*) maze cell: (struct cell) c distance: (int) distance
{
    unsigned int i;
    unsigned int x = c.x;
    unsigned int y = c.y;
    struct cell up = {x, y - distance};
    struct cell rt = {x + distance, y};
    struct cell dw = {x, y + distance};
    struct cell lt = {x - distance, y};
    struct cell d[4]  = {dw, rt, up, lt};
    unsigned int size = 0;
    
    struct cellString cells;
    cells.cells = malloc(4 * sizeof(cell));
    
    for(i = 0; i < 4; i++){ //each dir
        if(d[i].x > 0 && d[i].x < width && d[i].y > 0 && d[i].y < height){ //maze borders
            unsigned int mazeCellCurrent = (int)maze[d[i].y][d[i].x];
            struct cell     cellCurrent     = d[i];
            if(mazeCellCurrent != P_ALL && mazeCellCurrent != 0){ //not visited, not wall
                cells.cells[size] = cellCurrent; //write to array
                size++;
            }
        }
    }
    cells.size = size;
    return cells;
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
