#!/bin/bash -i

ENV_FILEPATH=".env"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "[initializeCommand] ENV_FILEPATH=$ENV_FILEPATH"
echo "[initializeCommand] localWorkspaceFolder=$SCRIPT_DIR"

# Create .devcontainer/.env if it does not already exists
if [ ! -e "$ENV_FILEPATH" ]; then
    echo "[initializeCommand] '$ENV_FILEPATH' does not exist, creating it"
    touch $ENV_FILEPATH
fi 

source $ENV_FILEPATH

# Set localWorkspaceFolder environment variable if not already set
if [ -z "${localWorkspaceFolder}" ]; then 
    echo -e "\nlocalWorkspaceFolder=$SCRIPT_DIR/..\n" >> $ENV_FILEPATH
fi