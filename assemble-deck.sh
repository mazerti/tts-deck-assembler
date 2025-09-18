#!/bin/bash

# Check if at least two images are provided (including the output name)
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 image1.jpg image2.jpg ... output_image.jpg"
    exit 1
fi

# Get the output image name (last argument)
output_image=$(pwd)"/${!#}"
inputs=("$@")
unset 'inputs[-1]'

# Get the number of images (excluding the last argument)
num_images=$(($# - 1))

read -r W H <<< "$(identify -format "%w %h" "$inputs")"

# Calculate the optimal number of rows and columns
cols=$(echo "scale=0; $(echo "scale=2; sqrt($num_images * $W * $H) + 0.999" | bc ) / $W " | bc ) 
rows=$(echo "scale=0; ($(echo "scale=2; $num_images / $cols" | bc) + 0.999) / 1 " | bc)

# Create a temporary directory for the processed images
temp_dir=$(mktemp -d)
trap "rm -rf $temp_dir" EXIT

# Create the grid layout
for img in "${inputs[@]}"; do
    cp "$img" "$temp_dir/"
done

# Create the final image using convert
cd "$temp_dir"

# Create rows of images using +append
row_images=()
for ((i=0; i<num_images; i+=cols)); do
    convert "${inputs[@]:$i:cols}" +append "row_$((i/cols)).png"
    row_images+=("row_$((i/cols)).png")

done

# Now append the rows vertically using -append
convert "${row_images[@]}" -append $output_image

echo "Grid image created as $output_image"
