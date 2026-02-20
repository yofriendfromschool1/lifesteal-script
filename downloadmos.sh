#!/bin/bash

# Define the download directory
DOWNLOAD_DIR="$HOME/Downloads"
# Define the file containing the list of URLs
URL_FILE="$HOME/urls.txt"

# Create the download directory if it doesn't exist
mkdir -p "$DOWNLOAD_DIR"

# Check if the URL file exists
if [ ! -f "$URL_FILE" ]; then
    echo "URL file not found: $URL_FILE"
    exit 1
fi

echo "Starting file downloads to $DOWNLOAD_DIR..."

# Loop through each URL in the file and download it
while IFS= read -r url; do
    # Skip empty lines or lines starting with a comment (#)
    [[ "$url" =~ ^[[:space:]]*# ]] && continue
    [[ -z "$url" ]] && continue
    
    echo "Downloading: $url"
    # Use wget with the -P option to specify the directory prefix
    wget -P "$DOWNLOAD_DIR" "$url"
    # Alternatively, use curl with the -O (uppercase O) and --output options
    # curl -O --output "$DOWNLOAD_DIR/$(basename "$url")" "$url"
done < "$URL_FILE"

echo "Download script finished."