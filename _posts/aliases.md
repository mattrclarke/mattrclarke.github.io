export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

source ~/.profile
eval "$(nodenv init -)"
export PATH="$PATH:/opt/yarn-[version]/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

alias ..="cd .."

alias ep="vim ~/.bash_profile"
alias viewprofile="cat ~/.bash_profile"
alias py="python3 -m http.server "
alias serv="rails s -b 0.0.0.0 -p "
alias build="rake build_schema"
alias seed="rake db:seed"

#-------------------------------------------------------------
# Github Aliases
#-------------------------------------------------------------
alias b="branch"
alias gb="git branch"
alias ggp="git push"
alias ggl="git pull"
alias gaa="git add ."
alias gst="git status"
alias gco="git checkout"
alias gph="git push heroku"

#-------------------------------------------------------------
# Server Aliases
#-------------------------------------------------------------
alias gorails="rails s -b 0.0.0.0 -p 3000"
#-------------------------------------------------------------