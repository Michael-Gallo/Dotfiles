#!/bin/sh 


$@ ; pkill -RTMIN+10 someblocks
