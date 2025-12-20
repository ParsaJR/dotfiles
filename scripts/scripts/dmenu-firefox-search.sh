#!/bin/bash

Term="$(dmenu -p "Search something in google:")"
if [ ! -z "$Term" ]; then
	firefox --new-window https://www.google.com/search?q="${Term}"
fi
