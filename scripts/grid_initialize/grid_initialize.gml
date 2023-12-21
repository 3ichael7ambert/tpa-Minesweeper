function grid_initialize() {
	//
	// grid_initialize()
	//
	// Initializes a grid. Placed in a function so that it can be called
	// again when changing the grid dimensions and number of mines
	//

	// Updates smiley location and resets it in case grid dimensions are changed
	smiley_x = start_x + (floor(grid_width*16/2) - 12);
	smiley_y = start_y - 24;
	smile = 0;

	// Resets the rest of the variables as a new game has started
	win   = 0;
	flags = mine_max;
	time = 0;
	timer = 0;
	start = false;

	// This loop simply initializes a default value for each square of the grid. All
	// squares are initially set to be mine-free, and then the mines are placed
	// down below. The control expression in the loop subtracts 1 from the product
	// of the grid width and height, because the arrays start with an index of 0,
	// not 1
	for ( i = 0; i <= grid_width*grid_height - 1; i += 1 ) 
	{
	  grid[i,0] = false; // Sets square to mine-free
	  grid[i,1] = 0;     // Sets subimage for each grid section
	  grid[i,2] = 0;     // Sets how many mines are adjacent to each square
	  grid[i,3] = false; // No squares have been clicked or count towards winning
	}
  
	  // Randomly places mines
	  mines = 0;
  
	  while ( mines < mine_max )
	  {
	    for ( i = 0; i <= grid_width*grid_height - 1; i += 1 )
	    {
	      // Basically, this randomly places mines on the grid until the number of
	      // specified mines has been reached. The probability of a square becoming
	      // a mine is based on the size of the grid so that a large grid will not
	      // have all the mines placed towards the top of the grid, which would
	      // be the case with a lower probability. This keeps the mines uniformly
	      // spread throughout the grid (if you could call random placement uniform)
	      if ( mines < mine_max && random(grid_width*grid_height) < 2 && grid[i,0] != true )
	      {
	        grid[i,0] = true;
	        mines += 1;
	      }
	    }
	  }
  
	  // Sets how many mines are adjacent to each square
	  for ( i = 0; i <= grid_width*grid_height-1; i += 1 )
	  {
	    set_adjacent(i);
	  }



}
