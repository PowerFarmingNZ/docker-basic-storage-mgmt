#!/bin/bash
echo "Running first-run"

#Add MC configs
if [ $UPLOAD_SOURCE ]; then
    mc config host add "source-backup" "$UPLOAD_SOURCE" "$UPLOAD_SOURCE_KEY" "$UPLOAD_SOURCE_SECRET" S3v4
fi
if [ $UPLOAD_DEST ]; then
    mc config host add "dest-backup" "$UPLOAD_DEST" "$UPLOAD_DEST_KEY" "$UPLOAD_DEST_SECRET" S3v4
fi
