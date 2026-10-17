#!/usr/bin/env bash

set -euo pipefail

FILE="$1"

DIR="$(dirname "$FILE")"
NAME="$(basename "$FILE")"
BASE="${NAME%.*}"

case "$FILE" in
    *.c)
        COMPILER="gcc"
        ;;
    *.cpp|*.cc|*.cxx)
        COMPILER="g++"
        ;;
    *)
        echo "File type not supported : $FILE"
        exit 1
        ;;
esac

OUTPUT="$DIR/$BASE"

echo "Compilation of $NAME..."

"$COMPILER" \
    -Wall \
    -Wextra \
    -g \
    "$FILE" \
    -o "$OUTPUT"

echo "Compilation done."

"$HOME/.local/bin/konsole-run" \
    "cd $(printf '%q' "$DIR") && $(printf '%q' "$OUTPUT")"