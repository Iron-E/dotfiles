abbr -a g git

abbr -a ga git add
abbr -a gA git add -A
abbr -a gaa git add -A
abbr -a gap git add --patch

abbr -a gb git rebase
abbr -a gbi git rebase -i
abbr -a gbia git rebase -i --autosquash
abbr -a gbis git rebase --exec 'git commit --amend --no-edit -n -S' -i rebase -i

abbr -a gc git commit
abbr -a gca git commit --amend
abbr -a gcb git absorb
abbr -a gcbr git absorb --and-rebase
abbr -a gcp git cherry-pick

abbr -a gd git diff
abbr -a gdh git diff HEAD
abbr -a gds git diff --stat
abbr -a gdsh git diff --stat HEAD

abbr -a ge git restore

abbr -a gf git fetch
abbr -a gfa git fetch --all

abbr -a gh git show
abbr -a ghe git show HEAD

abbr -a gl git log
abbr -a glg git log --graph --pretty=format:'"%C(#ffb7b7)%h%C(reset bold) %an%C(reset) %s %C(#ff4090)(%cr)%C(bold #ffa6ff)%d%C(reset)"' --abbrev-commit --date=relative

abbr -a gn git branch

abbr -a gp git push
abbr -a gpl git pull
abbr -a gpt gp --tags

abbr -a gr git reset

abbr -a gs git status

abbr -a gt git stash
abbr -a gta git stash apply
abbr -a gtd git stash drop
abbr -a gtl git stash list
abbr -a gto git stash pop
abbr -a gtp git stash --patch
abbr -a gts git stash show

abbr -a gw git switch
abbr -a gwc git switch -c
abbr -a gwd git switch -d
