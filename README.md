# yitube

## How to use

Put your sdcard and run

    ./yitube.sh

## What does this scirpt do

This script does

  - Concatenates splitted movies to one file by captured order without transcoding
  - Uploads it to YouTube

## Prerequisite

You need `ffmpeg` that is able to get easily by [Homebrew](https://brew.sh/) and [youtube-upload](https://github.com/tokland/youtube-upload).
This script expects captured by Xiaomi's Yi 4k movies.

## How to configure

You can overwrite followings by setting environment variable.

  - SDCARD_DIR : The sdcard movies directory you mounted. Need to include `DCIM/100MEDIA`.
  - OUTPUT_TITLE : The filename of the concatenated movie and title of YouTube page.
  - SSD_PATH : The output file path to store concatenated movie.
  - CLIENTS_SECRETS : The secret key file of Google API required by `youtube-upload`.

Optional settings are:

  - VIDEO_PRIVACY : YouTube privacy setting. You can set `public` or `private`. Default: `unlisted`.
  - OUTPUT_FILE_PATH : Full path of the output movie. Automatically determined by `SSD_PATH` and `OUTPUT_TITLE`. You can overwrite the file extension to change this variable. In default, mkv container is used.
