#!/bin/bash

function pause { 
	echo '(continue)'
	read -n 1 -s 
}

echo one

pause

echo two

pause

echo three

pause