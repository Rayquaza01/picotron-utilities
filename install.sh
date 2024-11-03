#!/bin/bash
stow --no-folding -d src/ --adopt -t ~/.lexaloffle/Picotron/drive/ -Sv exports --ignore="\.info\.pod"
