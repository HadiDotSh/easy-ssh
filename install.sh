#!/bin/bash
# By @HadiDotSh

printf "\e[0;92m- \e[0m\e[1;77mEasy SSH\e[0;96m [By @HadiDotSh]\n\e[0m"
mkdir "${HOME}/.essh"
touch "${HOME}/.essh/known_server"
mv essh.sh "${HOME}/.essh/essh.sh"

printf "\n\e[0;92m? \e[0m\e[1;77mInstallation Done. \e[0;92mDon't forget to add an alias to your bashrc or zshrc :\n\e[0;96malias essh=\"bash ~/.essh/essh.sh\"\n\n\e[0m"
