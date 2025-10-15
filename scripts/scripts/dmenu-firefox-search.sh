#!/bin/bash

Term="$(echo "" | dmenu -p "Search something in google:")"
if [ ! -z "$TERM" ]; then
	firefox --new-window https://www.google.com/search?q="${Term}"
fi
