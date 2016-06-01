#!/bin/zsh

for p in ./*/;
do
  BRANCH=$(git --git-dir="$p.git" rev-parse --abbrev-ref HEAD)
  echo "Treating $p"
  echo "  On branch $BRANCH"
  git --git-dir="$p.git" fetch --prune && git --git-dir="$p.git" --work-tree="$p" pull origin "$BRANCH"
;
done
