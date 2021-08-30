#!/bin/bash
# Easy SSH
# By @HadiDotSh
known_server="${HOME}/.essh/known_server"

connect(){
    username=${2}
    IP=${3}
    port=${4}
    rsa=${5}
    if [[ "${rsa}" == "true" ]];then
        ssh ${username}@${IP} -p ${port} -i ${6}
    else
        ssh ${username}@${IP} -p ${port}
    fi
}

info(){
    printf "\e[0;92m- \e[0m\e[1;77m${1}\e[0m"
    printf "\n\e[0;92m+ \e[0m\e[1;77mUsername: \e[0;96m${2}\e[0m"
    printf "\n\e[0;92m+ \e[0m\e[1;77mIP: \e[0;96m${3}\e[0m"
    printf "\n\e[0;92m+ \e[0m\e[1;77mPort: \e[0;96m${4}\e[0m"
    printf "\n\e[0;92m+ \e[0m\e[1;77mRSA: \e[0;96m${5}\e[0m"
    if [[ "${5}" == "true" ]];then
        printf "\n\e[0;92m+ \e[0m\e[1;77mPath: \e[0;96m${6}\e[0m"
    fi
    printf "\n"
}

if [[ ! -d "${HOME}/.essh" ]]; then
    mkdir "${HOME}/.essh"
fi
if [[ ! -f "${known_server}" ]];then
    touch "${known_server}"
fi

while [[ ! -z "${*}" ]];do

    if [[ "${1}" == "add" ]];then
        shift
        printf "\e[0;92m- \e[0m\e[1;77m${1}\e[0;96m [Easy SSH]\e[0m"
        read -p $'\n\e[0;92m+\e[0m\e[1;77m Username: \e[0;96m' username
        read -p $'\e[0;92m+\e[0m\e[1;77m IP: \e[0;96m' IP
        read -p $'\e[0;92m+\e[0m\e[1;77m Port (Default 22): \e[0;96m' port
        if [[ -z "${port}" ]];then
            port="22"
        fi
        printf "\e[0;92m? \e[0m\e[1;77mDo you want to use an RSA key ?\e[0;96m [y/n]\e[0m"
        read -n1 yn
        if [[ $yn == y ]]; then
            rsa="true"
            read -p $'\n\e[0;92m+\e[0m\e[1;77m Path to RSA private key: \e[0;96m' path_rsa
        elif [[ $yn == "n" ]]; then
            rsa="false"
        fi
        printf "\n${1} ${username} ${IP} ${port} ${rsa} ${path_rsa}" >> ${known_server}
        printf "\n\n\e[0;92m✓ \e[0m\e[1;77m${1} Sucessfully Added\e[0m\n"
        exit

    elif [[ "${1}" == "help" ]];then
        printf "\e[0;92m✓ \e[0m\e[1;77mEasy SSH\e[0;96m [By @HadiDotSh]\e[0m"
        printf "\n"
        printf "\n\e[1;77mArguments :\e[0m"
        printf "\n\e[1;92m\${server_name}          \e[0m\e[1;77mConnect to the server\e[0m"
        printf "\n\e[1;92mlist                    \e[0m\e[1;77mlist servers\e[0m"
        printf "\n\e[1;92madd \${server_name}      \e[0m\e[1;77mAdd a new server\e[0m"
        printf "\n\e[1;92minfo \${server_name}     \e[0m\e[1;77mGet server's info\e[0m"
        printf "\n\e[1;92mremove \${server_name}   \e[0m\e[1;77mRemove a server\e[0m"
        printf "\n\e[1;92mhelp                    \e[0m\e[1;77mShow brief help\e[0m"

        printf "\n"
        printf "\n\e[0;92m? \e[0m\e[1;77mMore information\e[0;96m on the github page.\e[0m\n"
        exit

    elif [[ "${1}" == "remove" ]];then
        shift
        server=$( cat "${known_server}" | grep "^${1} " )
        if [[ ! -z "$(cat "${known_server}" | grep "^${1} ")" ]];then
            cat "${known_server}" | sed "/^$1 /d" > "/tmp/delete_${1}"
            mv "/tmp/delete_${1}" "${known_server}"
            printf "\e[0;92m✓ \e[0m\e[1;77m${1} Sucessfully Removed\e[0m\n"
        else
            printf "\e[0;91mx \e[0m\e[1;77m${1} Not Found\e[0m\n"
        fi
        exit 

    elif [[ "${1}" == "list" ]];then
        printf "\e[0;92m? \e[0;90mName ; User ;    IP    ; Port ; RSA ; path/RSA/key\e[0m\n"
        cat "${known_server}"
        printf "\n"
        exit 

    elif [[ "${1}" == "info" ]];then
        shift
        server=$( cat "${known_server}" | grep "^${1} " )
        if [[ ! -z "${server}" ]];then
            info ${server}
        else
            printf "\e[0;91mx \e[0m\e[1;77m${1} Not Found\e[0m\n"
        fi
        exit

    else
        server=$( cat "${known_server}" | grep "^${1} " )
        if [[ ! -z "${server}" ]];then
            connect ${server}
        else
            printf "\e[0;91mx \e[0m\e[1;77m${1} Not Found\e[0m\n"
        fi
        exit
    fi
    
done