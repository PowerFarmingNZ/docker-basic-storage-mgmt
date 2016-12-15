#!/bin/bash
echo "Executing Copy Backup"

export UPLOAD_SOURCE_FOLDER=$UPLOAD_SOURCE_FOLDER
export UPLOAD_SOURCE=$UPLOAD_SOURCE
export UPLOAD_SOURCE_BUCKET=$UPLOAD_SOURCE_BUCKET
export UPLOAD_SOURCE_KEY=$UPLOAD_SOURCE_KEY
export UPLOAD_SOURCE_SECRET=$UPLOAD_SOURCE_SECRET

export UPLOAD_DEST_FOLDER=$UPLOAD_DEST_FOLDER
export UPLOAD_DEST=$UPLOAD_DEST
export UPLOAD_DEST_BUCKET=$UPLOAD_DEST_BUCKET
export UPLOAD_DEST_KEY=$UPLOAD_DEST_KEY
export UPLOAD_DEST_SECRET=$UPLOAD_DEST_SECRET
#Needs overwrite/force/remove to cater for files removed and clean up
#TODO: remove insecure once HTTPS set up correctly
export UPLOAD_OPTIONS='--quiet --force --remove --insecure'

/app/scripts/mc-mirror-src2dest.sh 

/app/scripts/post-copy-complete.sh $@
