#!/bin/bash

# Create output folder
mkdir -p cropped

echo "Cropping 50px from bottom of videos..."

# Loop through videos named as numbers (e.g., 1.mp4, 2.mp4) in numerical order
for file in $(ls | grep -E '^[0-9]+\.mp4$' | sort -n); do
    # Get original resolution
    resolution=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height \
                 -of default=noprint_wrappers=1:nokey=1 "$file")
    
    width=$(echo "$resolution" | sed -n 1p)
    height=$(echo "$resolution" | sed -n 2p)

    # Calculate new height after cropping 50px from bottom
    new_height=$((height - 50))

    # Output file path
    output="cropped/$file"

    echo "Processing $file → $output (crop to ${width}x${new_height})"

    # Run FFmpeg to crop and export losslessly
    ffmpeg -i "$file" -vf "crop=${width}:${new_height}:0:0" -c:v libx264 -crf 0 -preset veryfast -c:a copy "$output"
done

echo "✅ All videos cropped and saved to 'cropped/'"
