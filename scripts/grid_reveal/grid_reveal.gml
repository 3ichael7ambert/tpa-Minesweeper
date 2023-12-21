function grid_reveal() {
	//
	// grid_reveal()
	//
	// Reveals all squares adjacent to empty squares
	//

	var i;

	// This loop must be repeated otherwise it may not reveal the maximum number of
	// squares possible. You can test this by placing two slashes ( // ) in front
	// the repeat statement and clicking an empty square on a rather large grid
	// with relatively few mines. Most likely, only a small portion of what can
	// be revealed will actually be revealed
	repeat ( max(grid_width,grid_height) )
	{
	for ( i = 0; i <= grid_width*grid_height - 1; i += 1 )
	{
	  // If the square is clicked and not adjacent to any mines...
	  if ( grid[i,1] == 2 )
	  {
	      // Upper left square
	      if ( i >= grid_width + 1 && i mod grid_width != 0 )
	      {
	        // Don't reveal if it has a flag on it
	        if ( grid[i-(grid_width+1),1] == 0  )
	        {
	          grid[i-(grid_width+1),1] = grid[i-(grid_width+1),2] + 2;
	        }
	      }
      
	      // Upper square
	      if ( i >= grid_width )
	      {
	        if ( grid[i-grid_width,1] == 0 )
	        {
	          grid[i-grid_width,1] = grid[i-grid_width,2] + 2;
	        }
	      }
      
	      // Upper right square
	      if ( i >= grid_width - 1 && (i + 1) mod grid_width != 0 )
	      {
	        if ( grid[i-(grid_width-1),1] == 0 )
	        {
	          grid[i-(grid_width-1),1] = grid[i-(grid_width-1),2] + 2;
	        }
	      }
      
	      // Left square
	      if ( i >= 1 && i mod grid_width != 0 )
	      {
	        if ( grid[i-1,1] == 0 )
	        {
	          grid[i-1,1] = grid[i-1,2] + 2;
	        }
	      }
      
	      // Right square
	      if ( i <= grid_width*grid_height - 2 && (i+1) mod grid_width != 0 ) // Subtract 2 because i starts at 0, not 1
	      {
	        if ( grid[i+1,1] == 0 )
	        {
	          grid[i+1,1] = grid[i+1,2] + 2;
	        }
	      }
      
	      // Lower left square
	      if ( i <= grid_width*grid_height - grid_width - 2 && i mod grid_width != 0 )
	      {
	        if ( grid[i+(grid_width-1),1] == 0 )
	        {
	          grid[i+(grid_width-1),1] = grid[i+(grid_width-1),2] + 2;
	        }
	      }
      
	      // Lower square
	      if ( i <= grid_width*grid_height - grid_width - 1 )
	      {
	        if ( grid[i+(grid_width),1] == 0 )
	        {
	          grid[i+(grid_width),1] = grid[i+(grid_width),2] + 2;
	        }
	      }
      
	      // Lower right square
	      if ( i <= grid_width*grid_height - (grid_width + 1 ) - 1 && (i+1) mod grid_width != 0)
	      {
	        if ( grid[i+(grid_width+1),1] == 0 )
	        {
	          grid[i+(grid_width+1),1] = grid[i+(grid_width+1),2] + 2;
	        }
	      }
	  }
	}
	}



}
