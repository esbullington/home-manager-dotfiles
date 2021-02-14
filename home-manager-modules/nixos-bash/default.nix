{ pkgs, ... }:


{

xdg.configFile."bash".source = ../../configs/bash;

programs.bash.enable = true;

programs.bash.initExtra = ''
  # XDG config
  export XDG_DATA_HOME=$HOME/.local/share
  export XDG_CONFIG_HOME=$HOME/.config
  export LC=$LANG
  
  if [ -f ~/.config/bash/bash_main ]; then
    . ~/.config/bash/bash_main
  fi

'';


}
