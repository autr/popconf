#!/bin/bash 

for i in {0..3}
do
	ffplay /dev/video$i &
done