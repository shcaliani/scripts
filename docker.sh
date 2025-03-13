🟨🟨 DOCKER  

⭕ COMANDOS

> docker version                                    | versão do docker
> docker image ls                                   | lista todas as imagens que existem
> docker ps                                         | containers ativos
> docker ps -a                                      | todos os containers que já rodaram
> docker logs <container name ou id>                | logs

> docker run -it ubuntu:latest                      | ultima imagem disponivel no docker hub [https://hub.docker.com/]
> docker run -ps                                    | executa uma imagem de container desatachada do cmd
> docker run -d -p 80:80 --name nginx-docker nginx. | com nome para o container

> docker stop <container id>                        | utilizado quando container não está no terminal
> docker start <id container>                       | reinicializar um container

> docker rm <container name ou id>                  | remover container    
> docker rm <container name ou id> -f               | força a parada e remoção do container
> docker rmi <image name>                           | remover imagem

> docker build .                                    | precisa ter o dockerfile no diretório que cria-se a imagem
> docker build -t <image name> .                    | nomear uma imagem

> docker system prune                               | limpar o system



⭕ PASSO A PASSO

> docker version                  # versão do docker

> docker run -it ubuntu           # executando imagem do ubuntu em qq máquina (dentro do vscode). (-it é um terminal)

# alternativas
> docker run -it ubuntu:latest                       # ultima imagem disponivel no docker hub [https://hub.docker.com/]
> docker run -ps                                     # executa uma imagem de container desatachada do cmd
> docker run -d -p 80:80 --name nginx-docker nginx.  # com nome para o container


> ls                              # exibe o diretório de uma máquina linux

> apt-get update                  # atualizando a imagem do ubuntu (dentro do container)
> apt-get install vim             # instalando editor de texto no container
> vim teste.txt                   # criando um arquivo no ubunto do container
> exit                            # sai do container

🔺 listar containers

▶️ listar containers

🔶 listar containers

♦️ listar containers

⚪️ listar containers


> docker ps                       # containers ativos

> docker ps -a                    # todos os containers que já rodaram

|| parar containers

> docker stop <container id>     # utilizado quando container não está no terminal

|| expor a porta para se conectar com o container

> docker run -d -p 80:80 nginx

# se acessar o browser e acessar ˜localhost" vai visualizar o nginx deste container


|| reinicializar um container     # id ou nome do container

docker start <id container> 

|| logs

> docker logs <container name ou id>

|| remover containers

# de stop no container para remover

> docker rm <container name ou id> 
> docker rm <container name ou id> -f             # força a parada e remoção do container

|| criando uma imagem

|--- arquivo index.js

const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res)  => {
    res.send('ola docker!')
});

app.listen(port, () => {
    console.log('App rodando na porta: ${port}')

|--- arquivo docekerfile

# copiar as dependências 
# se utilizar . no lucar do /usr/src/app ele remete ao workdir
COPY package.json /usr/src/app/

# instalando os pacotes para criar no container
RUN npm install

# copiando tudo o que tem aqui para o workdir
COPY . .

# expor a porta que utilizamos (index.js)
EXPOSE 3000

# executar o comando
CMD ["NODE", "INDEX.JS"]

|| contruindo a imagem

> docker build .                        # precisa ter o dockerfile no diretório que cria-se a imagem

> docker image ls                       # lista todas as imagens que existem

> docker run -p 3000:3000 -d --name  <container name> <id image>

no navegador [localrost:3000
...'ola docker!'

|| nomear uma imagem

> docker build -t <image name> . 

> docker run -d -p 3000:3000 --name node-docker-2  <image name>   # imagem rodando no container node-docker-2

|| remover imagem

# parar o container que está utilizando a imagem

>  docker rmi <image name>

|| remover o que não está se utilizando

> docker system prune

## referência https://www.youtube.com/watch?v=np_vyd7QlXk

⭕⭕⭕

## criando uma imagem

# criando uma imagem se baseando numa imagem node
FROM node                                          

# criar uma pasta para colocar a aplicação
WORKDIR /usr/src/app

# copiar as dependências 
# se utilizar . no lucar do /usr/src/app ele remete ao workdir
COPY package.json /usr/src/app/

# instalando os pacotes para criar no container
RUN npm install

# copiando tudo o que tem aqui para o workdir
COPY . .

# expor a porta que utilizamos (index.js)
EXPOSE 3000

# executar o comando
CMD ["NODE", "INDEX.JS"]

## end
