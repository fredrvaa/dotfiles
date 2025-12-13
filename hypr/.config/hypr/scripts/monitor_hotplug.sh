#!/bin/bash

if hyprctl monitors | grep -q "DP-1"; then
    hyprctl keyword monitor "eDP-1, disable, ,"
else
    hyprctl keyword monitor "eDP-1, highres, auto, 1.5"
fi

