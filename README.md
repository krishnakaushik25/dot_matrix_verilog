# dot_matrix

## PROJECT DESCRIPTION: 

Basically, this is just analogous to the RC car with a controller. Here, in place of a car, we have an LED matrix (4x4) on which the only one LED is lit at any time and a control input which controls the motion of that LED. 

If we consider a virtual controller with four buttons viz. up, down, left and right and if we push the up button the LED starts moving in the upward direction. If we push the left button then the motion of LED changes to left direction.

In a similar way, for the down and right button also. The motion is continuous, i.e., if lit LED reaches the edge of the matrix, it again starts from the opposite side of the same row/column. And if we leave the controller without pushing any button, the LED in the matrix won't move. (And the speed of the LED can be controlled by varying the clock frequency) 


The entire functional code is written in verilog which is there in dot_matrix.v file.
