{ ... }:

{
  programs.fish = {
    # Expansion abbreviations
    shellAbbrs = {
      g = "git";
      gst = "git status";
      gco = "git checkout";
      nr = "nh os switch";
    };

    # Standard command aliases
    shellAliases = {
      # SSH Shortcuts
      homeserver = "kitten ssh jaylen@192.168.50.232";
      homelabtop = "kitten ssh jaylen@192.168.50.32";
      homeserverb = "kitten ssh root@192.168.50.188";
      deployserver = "kitten ssh jaylen@192.168.50.192";
      
      # Core overrides
      icat = "kitten icat";
      cd = "z";
      ls = "eza --icons=always --color=always --group-directories-first";
      la = "eza --icons=always --color=always --group-directories-first -a";
      ll = "eza --icons=always --color=always --group-directories-first -lh";
      lt = "eza --icons=always --color=always --group-directories-first --tree";
      
      # Tools
      jsmem = "sudo smem -rs swap -n | python3 -c 'import sys, json; lines = [l.split() for l in sys.stdin.read().strip().split(\"\\n\")]; print(json.dumps([dict(zip(lines[0], row)) for row in lines[1:]]))'";
    };
  };
}