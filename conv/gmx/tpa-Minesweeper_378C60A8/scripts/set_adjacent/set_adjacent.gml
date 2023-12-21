//
// set_adjacent(index)
//
// sets the number of mines adjacent to square index
//

var i;

  i = argument0;
  
  // First checks whether the checking square is a mine. If it is, we do not care
  // how many other mines are adjacent to it, and thus the script only applies
  // to the squares that are not mines
  if ( grid[i,0] == false )
  {
    // Upper left square
    if ( i >= grid_width + 1 && i mod grid_width != 0 )
    {
      // If the upper left square is a mine
      if ( grid[i-(grid_width+1),0] == true ) grid[i,2] += 1;
    }
      
    // Upper square
    if ( i >= grid_width )
    {
      if ( grid[i-grid_width,0] == true ) grid[i,2] += 1;
    }
      
    // Upper right square
    if ( i >= grid_width - 1 && (i + 1) mod grid_width != 0 )
    {
      if ( grid[i-(grid_width-1),0] == true ) grid[i,2] += 1;
    }
      
    // Left square
    if ( i >= 1 && i mod grid_width != 0 )
    {
      if ( grid[i-1,0] == true ) grid[i,2] += 1;
    }
      
    // Right square
    if ( i <= grid_width*grid_height - 2 && (i+1) mod grid_width != 0 ) // Subtract 2 because i starts at 0, not 1
    {
      if ( grid[i+1,0] == true ) grid[i,2] += 1;
    }
      
    // Lower left square
    if ( i <= grid_width*grid_height - grid_width - 2 && i mod grid_width != 0 )
    {
      if ( grid[i+(grid_width-1),0] == true ) grid[i,2] += 1;
    }
      
    // Lower square
    if ( i <= grid_width*grid_height - grid_width - 1 )
    {
      if ( grid[i+(grid_width),0] == true ) grid[i,2] += 1;
    }
      
    // Lower right square
    if ( i <= grid_width*grid_height - (grid_width + 1 ) - 1 && (i+1) mod grid_width != 0)
    {
      if ( grid[i+(grid_width+1),0] == true ) grid[i,2] += 1;
    }
      
      /* Note: the reason for the modular division checks is so that a square that's
         all the way on the left border, for example, does not count a mine to the
         left of it (in the program's terms, i-1), which would really be the square
         that is all the way on the right border in the row above. They aren't
         actually touching, and thus the modular division checks if the square is
         on the left border, in which case 'i mod grid_width' is used, or the
         right border, in which case '(i+1) mod grid_width' is used. The index of 
         the left border will always be divisible by the grid width, except for
         the case of the upper-left corner (with an index of 0), but this doesn't
         matter because dividing zero by anything will always yield no remainder */ 
         
      
    }
