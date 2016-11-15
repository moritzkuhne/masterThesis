%this is the main file to test the linOptProg class
clear all; clc;

c = [1; -1; 0; 0];
A = [10, -7, -1, 0; 1, .5, 0, 1];
b = [5; 3];

prog = linOptProg;
prog.assignProperty('objectivec',c);
prog.assignProperty('constrainA',A);
prog.assignProperty('constrainb',b);

prog.solveProg();
prog.returnProperty('OpSolution')


