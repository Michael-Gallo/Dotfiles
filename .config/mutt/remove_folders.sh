#!/bin/bash

#removes folders that get autoimported into my personal email that do not exist

bad_boxes=(
        "\"=weekly\"" "\"=daily\"" "\"=Junk\""
        "\"=auto.archive\" ""\"=auto.delete\""
)
for i in ${bad_boxes[@]}; do
        sed -i "s/$i//g" ./accounts/1*
done
