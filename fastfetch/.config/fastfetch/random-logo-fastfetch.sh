#!/bin/bash

# fastfetch --kitty-icat logo/k8s.png
LOGO=$(ls ~/.config/fastfetch/logo/* | shuf -n1)
kitten icat --align=left --place 30x20@0x0 $LOGO | fastfetch --raw - --logo-width 30
