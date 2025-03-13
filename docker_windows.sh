🟨🟨 DOCKER Windows 

:  executa a sequência deste post no terminal como administrador

https://github.com/codeedu/wsl2-docker-quickstart#docker-engine-docker-nativo-diretamente-instalado-no-wsl2

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

: baixar o wsl
  https://docs.microsoft.com/pt-br/windows/wsl/wsl2-kernel

wsl --set-default-version 2

: na Windows Store
  Baixe o Ubuntu última versão

: no Windows Terminal Server acesse o prompt de comando do Ubuntu

Login:shcaliani
Pass:ubucalxx

: instala o shell
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


: cria o alias

>sergio.caliani
>cd ~  (na raiz)
>Vim bin 

# Aliases
alias ll="ls -lah"
alias docker-up="sudo service docker start"
alias docker-down"sudo service docker stop"

# Entrypoint

:wq   (sai do vim)

: instalar o docker

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo groupadd docker
sudo usermod -aG docker $USER

------------------------------- dia a dia ----------------------------

: subir e descer o Docker

>docker-up
>docker-down

: parar o wsl >  no Power Shell

wsl -l -v

PS c:\Users\xxxnamexxxx> wsl -l -v

wsl --shutdown
PS c:\Users\xxxnamexxxx> wsl --shutdown
PS c:\Users\xxxnamexxxx> wsl -l -v

---
