function s(){
  # Get a list of all available SSH clients from the ~/.ssh/config file and pass them to fzf
  selected_client=$(grep -E "^Host\s+" ~/.ssh/config | awk '{print $2}' | fzf)

  # Check if a selection was made
  if [ -n "$selected_client" ]; then
      # Connect to the selected SSH client
      ssh "$selected_client"
  else
      echo "No SSH client selected. Exiting."
  fi
}
