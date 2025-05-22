#!/bin/bash

Term="$(echo "" | dmenu)"
if [ ! -z $Term ]; then
	firefox --new-window "https://www.google.com/search?q=$Term" 
fi
