#!/bin/bash
echo "Started at $(date)"

SDCARD_DIR=${SDCARD_DIR:-"/Volumes/Untitled/DCIM/100MEDIA"}

cd "$SDCARD_DIR"

CAPTURED_DATE=${CAPTURED_DATE:-$(stat -t %Y%m%d $(ls -ltr -1 *.MP4 | head -1) | cut -d\  -f11 | sed 's/"//g')}
INPUT_MEDIA_META="/tmp/${CAPTURED_DATE}.txt"
SSD_PATH=${SSD_PATH:-"/Volumes/SanDisk Ultra II 960GB"}
OUTPUT_TITLE=${OUTPUT_TITLE:-${CAPTURED_DATE}卓球}
OUTPUT_FILE_PATH=${OUTPUT_FILE_PATH:-${SSD_PATH}/${OUTPUT_TITLE}.mkv}

find "$SDCARD_DIR" -type f -name "*.MP4" | perl -nE 'print "file $_"' > "${INPUT_MEDIA_META}"

if [[ -f "${OUTPUT_FILE_PATH}" ]]
then
    echo "Skipping. File already exists: '${OUTPUT_FILE_PATH}'"
else
    echo "Concatenating movies to '${OUTPUT_FILE_PATH}'. Input media meta data '${INPUT_MEDIA_META}'."
    time ffmpeg -safe 0 -f concat -i "${INPUT_MEDIA_META}" -c copy "${OUTPUT_FILE_PATH}"
fi

CLIENTS_SECRETS=${CLIENTS_SECRETS:-"/Users/Vaduz/Codes/youtube-upload/client_secrets.json"}
VIDEO_PRIVACY=${VIDEO_PRIVACY:-unlisted}

echo "Executing: youtube-upload --client-secrets=${CLIENTS_SECRETS} --title=${OUTPUT_TITLE} --privacy=${VIDEO_PRIVACY} \"${OUTPUT_FILE_PATH}\""
youtube-upload --client-secrets=${CLIENTS_SECRETS} --title=${OUTPUT_TITLE} --privacy=${VIDEO_PRIVACY} "${OUTPUT_FILE_PATH}"

echo "Finished at $(date)"
