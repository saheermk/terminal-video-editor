#!/bin/bash

# Set up paths
input_dir="$(pwd)"
output_dir="$input_dir/cropped"

# Create cropped output folder
mkdir -p "$output_dir"

# Clear previous concat list
concat_list="$output_dir/concat_list.txt"
> "$concat_list"

echo "🔄 Cropping videos and preparing concat list..."

# Array to hold cropped filenames for cleanup later
cropped_files=()

# Process all supported video formats named as numbers
for file in $(ls | grep -E '^[0-9]+\.(mp4|mkv|mov|avi)$' | sort -n); do
    # Get resolution
    resolution=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height \
                 -of default=noprint_wrappers=1:nokey=1 "$file")
    width=$(echo "$resolution" | sed -n 1p)
    height=$(echo "$resolution" | sed -n 2p)
    new_height=$((height - 50))

    base_name=$(basename "$file")
    # Change extension to .mov for cropped files
    cropped_file="$output_dir/${base_name%.*}.mov"

    echo "➡️  Cropping $file to ${width}x${new_height} → $cropped_file"

    ffmpeg -i "$file" -vf "crop=${width}:${new_height}:0:0" \
           -c:v prores_ks -profile:v 3 -pix_fmt yuv422p10le -c:a copy "$cropped_file"

    echo "file '$cropped_file'" >> "$concat_list"
    cropped_files+=("$cropped_file")
done

# Merge all cropped files into final mov
final_output="$output_dir/final_output.mov"

echo "🎞️  Merging cropped videos → $final_output"

ffmpeg -f concat -safe 0 -i "$concat_list" -c copy "$final_output"

# Remove temporary cropped files
echo "🧹 Cleaning up temporary cropped files..."
for tmp_file in "${cropped_files[@]}"; do
    rm -f "$tmp_file"
done

# Optionally remove the concat list file as well
rm -f "$concat_list"

echo "✅ Done! Final combined video saved to: $final_output"

