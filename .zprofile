export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export GOENV_ROOT=$HOME/.goenv
export PATH=$GOENV_ROOT/bin:$PATH
export PATH=$HOME/.goenv/bin:$PATH
eval "$(goenv init -)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
if which rbenv > /dev/null; then
    eval "$(rbenv init -)";
fi
