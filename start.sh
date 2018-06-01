#!/bin/bash

docker run -v $DOWNLOAD_FOLDER:/downloads -v $VIDEO_FOLDER:/videos -p 80:8080 strom:latest
