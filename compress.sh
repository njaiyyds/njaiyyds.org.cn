#!/bin/bash

# macOS
compress_image() {
  local filepath=$1
  local target_size=$2
  local quality=85

  mogrify -strip -interlace Plane -sampling-factor 4:2:0 -quality $quality "$filepath"

  local filesize=$(stat -f%z "$filepath")

  while [ $filesize -gt $target_size ]; do
    quality=$((quality - 5))
    if [ $quality -le 0 ]; then
      echo "Cannot compress $filepath to below $target_size bytes without unacceptable quality loss."
      break
    fi
    mogrify -strip -interlace Plane -sampling-factor 4:2:0 -quality $quality "$filepath"
    filesize=$(stat -f%z "$filepath")
  done
}


export -f compress_image

# Find and compress images
find ./public -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) -exec bash -c 'compress_image "$0" 524288' {} \;

echo "Compression completed."
