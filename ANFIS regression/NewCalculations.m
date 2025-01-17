clc;
clear;
close all;

load GENFIS3Output.mat
GENFIS3outputs = ans;

aa = find(GENFIS3outputs(:)<0);
GENFIS3outputs(aa, :) = 0;