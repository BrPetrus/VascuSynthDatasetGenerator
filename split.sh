#!/bin/bash

split() {
    # Load all image folders from subdirectories
    folders=( $(find . -type d -name 'image*' | grep -v "imageNames.txt") )

    # Shuffle the array
    shuffled_folders=($(echo "${folders[@]}" | tr ' ' '\n' | shuf))

    # Split the data
    total=${#shuffled_folders[@]}
    train_size=$((total * 80 / 100))
    train_set=("${shuffled_folders[@]:0:train_size}")
    test_set=("${shuffled_folders[@]:train_size}")

    echo "Train Set: ${train_set[@]}"
    echo "Test Set: ${test_set[@]}"

    # Move the data
    if ! [[ -d dataset ]]; then mkdir dataset; fi
    if ! [[ -d "dataset/training" ]]; then mkdir "dataset/training"; fi
    if ! [[ -d "dataset/test" ]]; then mkdir "dataset/test"; fi
    for folder in "${train_set[@]}"; do
        cp -r "$folder" "dataset/training/$(basename $(dirname $folder))_$(basename $folder)"
    done
    for folder in "${test_set[@]}"; do
        cp -r "$folder" "dataset/test/$(basename $(dirname $folder))_$(basename $folder)"
    done
}

split
