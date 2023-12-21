//
// position_boundary(x1,y1,x2,y2,w,h)
//
// Returns if point (x1,y1) is in the boundary starting at (x2,y2) with the
// desired width and height
//

// Initializes variables that will be used in the script
x1 = argument0;
y1 = argument1;
x2 = argument2;
y2 = argument3;
w = argument4;
h = argument5;

// This returns if the point is in the indicated boundary
if ( x1 >= x2 && x1 < x2 + w && y1 >= y2 && y1 < y2 + h )
  {
    return (true);
  }
else
  {
    return (false);
  }
