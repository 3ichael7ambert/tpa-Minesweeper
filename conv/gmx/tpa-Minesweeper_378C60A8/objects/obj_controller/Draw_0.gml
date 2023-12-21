/* NOTE: MOST OF THE IMMEDIATE FOLLOWING CODE IS PARTIAL TO THE HUD RATHER THAN THE
         GAME MECHANICS. SKIP TO LINE 69 TO GET TO THE MAIN PART OF THE ACTUAL
         PROGRAM */

// Deals with timer
if ( smile == 0 && start == true )
{
  timer += 1;
}

// Increases time every second
if ( timer == room_speed )
{
  timer = 0;
  time += 1;
}

// Draws time on screen
draw_set_color(c_red);
draw_set_font(fnt_main);
draw_set_halign(fa_right);
draw_text(start_x + grid_width*16 - 2,start_y-20,string_hash_to_newline(time));

// Draws number of remaining flags
draw_set_color(c_red);
draw_set_font(fnt_main);
draw_set_halign(fa_left);
draw_text(start_x+2,start_y-20,string_hash_to_newline(flags));

// Draws smiley face above grid
draw_sprite(spr_smiley,smile,smiley_x,smiley_y);

// If you click the smiley face
if ( position_boundary(mouse_x,mouse_y,smiley_x,smiley_y,24,24) && mouse_check_button_pressed(mb_left) )
{
  // Restart game with most recent settings
  grid_width = last_gw;
  grid_height = last_gh;
  mouse_max = last_mm;
  grid_initialize();
}

// Clears keyboard string if you press backspace
if ( keyboard_check_pressed(vk_backspace) )
{
  keyboard_string = "";
}

// Turns debug mode on/off
if ( keyboard_string == "debugon" && debug == false )
{
  debug = true;
  keyboard_string = "";
  sub_str += "#Debug mode on";
}
if ( keyboard_string == "debugoff" && debug == true )
{
  debug = false;
  keyboard_string = "";
  sub_str = string_replace(sub_str,"#Debug mode on","");
}

// Draws substring under game board
draw_set_halign(fa_left);
draw_set_color(c_black);
draw_set_font(fnt_sub);
draw_text(start_x+4,start_y+grid_height*16+4,string_hash_to_newline(sub_str));

/* MAIN PROGRAM STARTS HERE */

// The rest of the code in this event is contained within
// the following for loop. This allows dealing with each
// square individually for every aspect of the following code


var i;

for ( i = 0; i <= grid_width*grid_height - 1; i += 1 )
{

  
  // Creates a grid with the given dimentions assigned to the grid variables
  var xx, yy;
    xx[i] = start_x + i mod grid_width * 16;
    yy[i] = start_y + floor(i/grid_width) * 16;
    draw_sprite(spr_square,grid[i,1],xx[i],yy[i]);
  
  // Adds to win for every non-mine square you click! In other words, each
  // time you click an empty square you are closer to winning until all empty
  // squares have been clicked
  if ( grid[i,0] == false && grid[i,1] == grid[i,2] + 2 && grid[i,3] == false )
  {
    grid[i,3] = true; // Keeps statements from reiterating within the for loop
    win += 1;
  }
  
  // Checks if you win. The win variable simply is incremented by 1 for each
  // square you click, and thus you win the game when the number of non-mine
  // squares clicked is equal to the number of total squares minus the number
  // of squares that are mines
  if ( win == grid_width*grid_height - mine_max )
  {
    smile = 2; // Winning smiley face
    
    // This simply sets all mine blocks to flags in case you click all normal
    // squares before flagging the mines
    if ( grid[i,0] == true && grid[i,1] != 12 )
    { 
      grid[i,1] = 12; 
      flags -= 1;
    }
  }
  
  
  // If you are hovering over an unclicked square
  if ( position_boundary(mouse_x,mouse_y,xx[i],yy[i],16,16) && grid[i,1] == 0 && smile == 0 )
  {
    grid[i,1] = 1; // Set that squares subimage to the highlighted square subimage
  }

  // If the previously hovered square is no longer covered by the mouse
  if ( !position_boundary(mouse_x,mouse_y,xx[i],yy[i],16,16) && grid[i,1] == 1 )
  {
    grid[i,1] = 0; // Change it back to its normal subimage
  }
  
  // If you are hovering over any unclicked square...
  if ( position_boundary(mouse_x,mouse_y,xx[i],yy[i],16,16) && ( grid[i,1] == 0 ||
       grid[i,1] == 1 || grid[i,1] == 12 || grid[i,1] == 13 ) )
  {
    // ... and then you click that unclicked square...
    if ( mouse_check_button_pressed(mb_left) && grid[i,1] < 2 && smile == 0 )
    {
      // Starts timer once you click the first block
      if ( !start )
      {
        start = true;
      }
      
      // If the square clicked is a mine...
      if ( grid[i,0] == true ) 
      {
        // If it is your first click, move the mine. This prevents you from clicking
        // a mine on your first click
        if ( win == 0 )
        {
          mines -= 1;
          
          // Simply randomly replaces the mine on an empty square
          while ( mines < mine_max )
          {
            var p;
            for ( p = 0; p <= grid_width*grid_height - 1; p += 1 )
            {
              if ( mines < mine_max && random(grid_width*grid_height) < 2 && grid[p,0] == false && p != i )
              {
                grid[p,0] = true;
                mines += 1;
                break;
              }
            }
          }
          
          // Resets how many mines are adjacent to the square that was originally
          // a mine
          grid[i,0] = false;
          set_adjacent(i);
          // Sets the subimage for the grid space to the number of adjacent mines
          // plus 2, as, if you look at spr_square, the subimages for revealed 
          // squares starts at 2, not 0
          grid[i,1] = grid[i,2] + 2;
        }
        // If the clicked square was a mine, but not your first click...
        else
        {
          grid[i,1] = 15;        // ...set the subimage to red (clicked) mine
          smile = 1; // Makes the smiley face sad :(
          var s;
          for ( s = 0; s <= grid_width*grid_height - 1; s += 1 )
          {
            // If the square is a mine and is not the one you clicked and is
            // not flagged...
            if ( grid[s,0] == true && grid[s,1] != 15 && grid[s,1] != 12 )
            {
              grid[s,1] = 11; // ...set square to mine subimage
            }
          
            // If the square is not a mine but you flagged it...
            if ( grid[s,0] == false && grid[s,1] == 12 )
            {
              grid[s,1] = 14; // ...set subimage to 14, flagged square that is not a mine
            }
          }
        }
      }
      // If it is not a mine
      else
      {
        grid[i,1] = grid[i,2] + 2; // Sets the proper subimage. Adds 2 because
                                   // the subimages for empty squares starts 
                                   // at subimage 2 (stated above on lines 168-170)
      }
      
      // If there are no mines adjacent to the square...
      if ( grid[i,2] == 0 )
      {
        grid_reveal(); // Reveal all the adjacent squares
      }
    }
    
    // If you right click...
    if ( mouse_check_button_pressed(mb_right) && smile == 0 )
    {
      switch ( grid[i,1] ) 
      {
        // Both 0 and 1 are an unclicked block, so both cases do the same thing:
        // If it is a question mark, change it back to an unclicked block
        case 0:
          grid[i,1] = 12;
          flags -= 1;
          break;
        case 1:
          grid[i,1] = 12;
          flags -= 1;
          break;
        // If it is a flag, change it to a question mark
        case 12:
          grid[i,1] = 13;
          flags += 1;
          break;
        // If it is a question mark, change it to a flag
        case 13:
          grid[i,1] = 0;
          break;
      }
      
    }
  }
  
  // Allows custom game
  if ( keyboard_check_pressed(ord("C")) )
  {
    var t;
      t = show_question("Make a custom grid and restart?");
    if ( t == true )
    {
      do
      {
        // I simply used the absolute value function here for an easy way to
        // get rid of negative numbers entered
        grid_height = abs(get_integer("Enter grid height",9));
        last_gh     = grid_height;
        grid_width = abs(get_integer("Enter grid width",9));
        last_gw    = grid_width;
        mine_max = abs(get_integer("Enter number of mines",10));
        last_mm  = mine_max;
        if ( grid_height == 0 || grid_width == 0 || mine_max > grid_height*grid_width - 1 )
        {
          show_message("Grid must be at least 1x1 and there cannot be more mines than there are cells.");
        }
      }
      // Makes user repeat the process if an invalid number is entered
      until !( grid_height == 0 || grid_width == 0 || mine_max > grid_height*grid_width - 1 )
      grid_initialize();
    }
  }
      
  
  // Debug mode 
  
  if ( debug == true )
  {
  
    // Shows all squares
    if ( keyboard_check_pressed(ord("T")) )
    {
      if ( grid[i,0] == true )  // If the square is a mine...
        {
          grid[i,1] = 11;        // ...set the subimage to the mine
        }
        else
        {
          grid[i,1] = grid[i,2] + 2; // Sets the proper subimage. Adds 2 because
                                     // the subimages for the number of mines
                                     // starts at subimage 2
        }
    }
    
    // Restarts game
    if ( keyboard_check_pressed(ord("R")) )
    {
      game_restart();
    }
  
  }
  /* Notes */
  /* 
    Subimage index:
      0  = unclicked block, not hovered
      1  = unclicked block, hovered
      2  = clicked block, empty
      3  = clicked block, 1
      4  = clicked block, 2
      5  = clicked block, 3
      6  = clicked block, 4
      7  = clicked block, 5
      8  = clicked block, 6
      9  = clicked block, 7
      10 = clicked block, 8
      11 = clicked block, mine
      12 = flagged block
      13 = question block
      14 = flagged, not a mine
      15 = clicked mine
  */
  
}

/* */
/*  */
