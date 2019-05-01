## Useful bash stuff

### delete all stuff excluding regex

`git branch --merged| egrep -v "(^\*|master|develop)" | xargs git branch -d`
