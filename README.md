# Easy SSH
#### Shortcut for connecting to your different servers via ssh. Add all your servers and simply connect to them with a name.

### Install :
<p>Just pass this lines in your shell :</p>

```bash
git clone https://github.com/HadiDotSh/easy-ssh && cd easy-ssh && bash install.sh
```
<p>Then, add an alias to your bashrc/zshrc file like :</p>

```bash
vim ~/.bashrc   # Or ~/.zshrc
# And add :
alias essh="bash ~/.essh/essh.sh"
# Save and exit the file, then reload your bashrc or zshrc :
source ~/.bashrc # Or ~/.zshrc
```

<p>You can now add your first shortcuts with : "essh add ${Choose A Name}"</p>

### Arguments :

```bash
${server_name}          Connect to the server
list                    list servers
add ${server_name}      Add a new server
info ${server_name}     Get server's info
remove ${server_name}   Remove a server
help                    Show brief help
```

<p>See also: Easy SCP (https://github.com/hadidotsh/easy-scp)</p>
