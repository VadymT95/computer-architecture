@echo off

set arg=%lab1
tasm %arg%.asm
tlink %arg%.obj
%arg%.exe