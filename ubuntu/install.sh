#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

bash $DIR/install-stuff.sh
bash $DIR/configure-stuff.sh

exit 0
