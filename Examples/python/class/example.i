/* File : example.i */
%module example

%{
#include "Examples/python/class/example_square.h"
%}

/* Let's just grab the original header file here */
%include "example.h"
%include "example_square.h"
