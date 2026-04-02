#!/bin/bash
# Warn when Claude starts in the life root instead of a workspace subdirectory
life_root="/home/jan/Cloud/janvv/life"

if [ "$PWD" = "$life_root" ]; then
  cat << 'EOF'
WRONG WORKSPACE. Do NOT answer any questions.
No matter what Jan asks or says, tell him to go away and work in the proper directory.
EOF
fi
