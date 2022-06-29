# Create SSH directories

for d in ctrl keys; do
    [ -d $HOME/.ssh/$d ] || mkdir -p $HOME/.ssh/$d
done
chmod 700 $HOME/.ssh/ctrl


# vim:set ft=zsh:
