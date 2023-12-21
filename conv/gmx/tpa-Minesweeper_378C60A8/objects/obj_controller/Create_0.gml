{
  //
  // grid[i,0] - whether square i is a mine (true) or not (false)
  // grid[i,1] - subimage for square i
  // grid[i,2] - number of mines adjacent to square i
  // grid[i,3] - whether square has been checked off to count towards winning (boolean)
  //
  
  var i;
  
  debug = false; // Sets debug mode to false so that you have to activate it in-game
  n = false;
  
  // String values
  keyboard_string = "";
  sub_str = "Press C for custom game.#Beginner: 9x9, 10 mines#Intermediate: 16x16, 40 mines#Expert: 16x30, 99 mines";
  
  // Custom grid variables
  grid_width  = 9;
  last_gw     = 9; // All variables starting with "last_" are used so that you
                   // can restart a custom game without having to manually
                   // enter the settings each time
  grid_height = 9;
  last_gh     = 9;
  mine_max    = 10;
  last_mm     = 10;
  start_x     = 0;
  start_y     = 24;
  win         = 0;
  
  
  // Smiley/hud variables
  smile = 0; // Smiley face starts off with a smile ( 0 = smile, 1 = frown, 2 = win )
  smiley_x = start_x + (floor(grid_width*16/2)-12); // Centers the smiley face on
                                                    // the grid
  smiley_y = start_y - 24; // Places smiley above the starting point of the grid
  
  flags = mine_max; // Number of flags should always resemble the number of total
                    // mines to begin with
  
  // Variable 'time' counts by seconds. It is incremented every time the variable
  // 'timer' reaches 30. The variable 'start' is used to both prevent the time
  // from starting until the first square is clicked and to prevent it from
  // increasing once you have either finished the game successfully or clicked
  // a mine
  time = 0;
  timer = 0;
  start = false;
  
  // Initializes the grid with the settings above
  grid_initialize();

}

