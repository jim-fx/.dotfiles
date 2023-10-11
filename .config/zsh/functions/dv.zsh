function dv(){
  tmux splitw -v -p20
  tmux splitw -h
  # tmux splitw -p90
  # tmux splitw -dp22 # 20/90
  # tmux splitw -h
  # tmux selectp -t'{right}'
  # tmux splitw -p80
  # tmux splitw -p56 # (15+15+15)/80
  # tmux splitw -p50
  tmux selectp -t'{top-left}'
  nvim .
}
