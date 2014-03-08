#!/usr/bin/env zsh

source $dots <<- usage
  usage: dots git commitify <options>
  
  options:
    
    -h,--help                   display this message
    -m,--message   <string>     commit message

usage

zparseopts -D -- -help=usage h=usage \
                 -message=message m=message

[ -z "$usage" ] || usage
[ -z "$message" ] && usage

issue=$(dots git issue create -m able -l enhancement "$message")
git add .
git commit -m "$(dots git issue get $issue)"$'\n\nCloses #'$issue'.'
(dots git release > release.md.bak) && mv release.md.bak release.md
git add release.md
git commit --amend -a --no-edit