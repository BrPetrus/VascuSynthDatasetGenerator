#!/bin/bash

# Creates datasets using VascuSynth with multiple noise profiles
# defined in noiseFiles folder.

set -e

VASCUSYNTH_BIN="/home/xpetrus/DP/VascuSynth/build/VascuSynth"
OUTPUT_DIR="./output/"

for noiseFileRaw in noiseFiles/*; do
    (
        noiseFile=$(basename ${noiseFileRaw})
        echo "Using ${noiseFile}"

        OUT="${OUTPUT_DIR}/${noiseFile}/"
        if ! mkdir -p "$OUT"; then
            echo "Error while creating the directory ${OUT}"
            break
        fi

        # Copy relevant files
        cp p{1..5}.txt paramFiles.txt imageNames.txt testOx.txt testS.txt "${OUT}" &&
        
        cd "$OUT" &&
        ${VASCUSYNTH_BIN} paramFiles.txt imageNames.txt 0.04 &&
        cd ../..
    ) &
done

wait
echo "All tasks are complete"
