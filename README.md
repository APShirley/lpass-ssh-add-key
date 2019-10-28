## Load an ssh-key for github from lastpass on Mac OS X

  - Requires lastpass cli (`brew install lastpass-cli`)
  - Usage is simple, add a key called github-ssh-key to your lastpass account. The key should be of type ssh-key in Lastpass. Then simply run the script as detailed below.
  - WARNING: the script **will remove all current ssh keys loaded in the agent without asking** (`ssh-add -D`). 
  - **Obviously you should read any script and understand what it does before running it**.

To run the script:
`bash <(curl https://raw.githubusercontent.com/APShirley/lpass-ssh-add-key/master/add-key.sh)`
