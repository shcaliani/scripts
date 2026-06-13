# 🐳 Docker — Guia Completo

> Referência completa para uso do Docker: instalação, comandos, Dockerfile, Docker Compose, volumes, redes, boas práticas e segurança.

---

## 📋 Índice

- [O que é o Docker e como funciona](#-o-que-é-o-docker-e-como-funciona)
- [Instalação](#-instalação)
- [Comandos essenciais](#-comandos-essenciais)
- [Dockerfile — criando imagens](#-dockerfile--criando-imagens)
- [Docker Compose](#-docker-compose)
- [Volumes — persistência de dados](#-volumes--persistência-de-dados)
- [Redes](#-redes)
- [Boas práticas e segurança](#-boas-práticas-e-segurança)
- [Referências e fontes confiáveis](#-referências-e-fontes-confiáveis)
- [Complementar — Docker no Windows com WSL2](#-complementar--docker-no-windows-com-wsl2)

---

## 🧠 O que é o Docker e como funciona

Docker é uma plataforma para criar, distribuir e executar aplicações em **containers** — ambientes isolados e portáteis que contêm tudo que a aplicação precisa para rodar: código, runtime, bibliotecas e configurações.

### Containers vs Máquinas Virtuais

| | Máquina Virtual | Container Docker |
|---|---|---|
| Isolamento | Sistema operacional completo | Processo isolado no SO host |
| Tamanho | Gigabytes | Megabytes |
| Inicialização | Minutos | Segundos |
| Recursos | Alto consumo | Compartilha kernel do host |
| Portabilidade | Limitada | Total |

### Conceitos essenciais

| Conceito | Descrição |
|---|---|
| **Imagem** | Template somente leitura com tudo para rodar a aplicação. Base dos containers. |
| **Container** | Instância em execução de uma imagem. Isolado, efêmero e reproduzível. |
| **Dockerfile** | Arquivo de instruções para construir uma imagem personalizada. |
| **Docker Hub** | Repositório público de imagens. [hub.docker.com](https://hub.docker.com) |
| **Volume** | Mecanismo de persistência de dados fora do container. |
| **Rede** | Canal de comunicação entre containers. |
| **Docker Compose** | Ferramenta para definir e rodar múltiplos containers via YAML. |
| **Registry** | Repositório de imagens (público ou privado). |

### Como funciona o fluxo

```
Dockerfile → docker build → Imagem → docker run → Container
                                ↑
                           Docker Hub
                        (imagens prontas)
```

---

## 💻 Instalação

### macOS — Docker Desktop

```bash
# Via Homebrew (recomendado)
brew install --cask docker

# Ou baixe diretamente em
# https://www.docker.com/products/docker-desktop

# Verificar instalação
docker --version
docker compose version
```

### Linux — Ubuntu/Debian

```bash
# Remover versões antigas
sudo apt remove docker docker-engine docker.io containerd runc

# Instalar via script oficial (recomendado para dev)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Adicionar seu usuário ao grupo docker (evita usar sudo)
sudo groupadd docker
sudo usermod -aG docker $USER

# Aplicar sem reiniciar
newgrp docker

# Verificar
docker --version
docker run hello-world
```

### Windows — via Docker Desktop

```bash
# 1. Baixe o Docker Desktop em
#    https://www.docker.com/products/docker-desktop

# 2. Habilite o WSL2 como backend durante a instalação

# 3. Verifique no PowerShell
docker --version
docker run hello-world
```

> Para uso no WSL2 sem Docker Desktop, veja a seção **Complementar — Docker no Windows com WSL2**.

### Verificando a instalação

```bash
docker --version              # versão do Docker
docker compose version        # versão do Compose
docker info                   # informações detalhadas do sistema
docker run hello-world        # teste básico de funcionamento
```

---

## ⚙️ Comandos essenciais

### Versão e informações

```bash
docker --version              # versão instalada
docker version                # versão cliente e servidor
docker info                   # informações completas do sistema
docker stats                  # uso de recursos em tempo real (CPU, memória)
```

### Imagens

```bash
# Listar
docker image ls               # lista imagens locais
docker images                 # alias para image ls

# Baixar
docker pull ubuntu            # baixa a imagem mais recente
docker pull ubuntu:22.04      # versão específica
docker pull node:20-alpine    # imagem leve do Node.js

# Inspecionar
docker image inspect ubuntu   # detalhes da imagem
docker history ubuntu         # camadas da imagem

# Construir
docker build .                          # constrói a partir do Dockerfile no diretório atual
docker build -t nome:tag .              # com nome e tag
docker build -t minha-app:1.0 .        # exemplo com versão

# Remover
docker rmi nome-imagem                  # remove imagem
docker rmi nome-imagem -f               # força a remoção
docker image prune                      # remove imagens sem uso (dangling)
docker image prune -a                   # remove todas as imagens não usadas por containers
```

### Containers — criar e executar

```bash
# Executar
docker run ubuntu                         # cria e executa (modo attach)
docker run -it ubuntu                     # modo interativo com terminal (-i = input, -t = tty)
docker run -it ubuntu:22.04 bash         # com versão e comando
docker run -d nginx                       # modo detached (background)
docker run -d -p 80:80 nginx             # mapeia porta host:container
docker run -d -p 8080:80 --name meu-nginx nginx  # com nome personalizado
docker run --rm ubuntu echo "olá"        # remove o container ao finalizar
docker run -e VARIAVEL=valor nginx       # define variável de ambiente
docker run -v /host:/container nginx     # monta volume

# Executar comando em container existente
docker exec -it <id ou nome> bash        # abre terminal no container ativo
docker exec <id ou nome> ls /app         # executa comando pontual
```

### Containers — listar

```bash
docker ps                     # containers em execução
docker ps -a                  # todos os containers (incluindo parados)
docker ps -q                  # apenas os IDs dos containers ativos
docker ps -aq                 # IDs de todos os containers
```

### Containers — parar, iniciar e reiniciar

```bash
docker stop <id ou nome>      # para o container graciosamente (SIGTERM)
docker stop $(docker ps -q)   # para todos os containers ativos

docker kill <id ou nome>      # força a parada imediata (SIGKILL)

docker start <id ou nome>     # inicia um container parado
docker restart <id ou nome>   # reinicia o container
docker pause <id ou nome>     # pausa o container
docker unpause <id ou nome>   # retoma o container pausado
```

### Containers — inspecionar e logs

```bash
docker logs <id ou nome>              # logs do container
docker logs -f <id ou nome>           # logs em tempo real (follow)
docker logs --tail 50 <id ou nome>    # últimas 50 linhas de log
docker logs --since 1h <id ou nome>   # logs da última hora

docker inspect <id ou nome>           # informações detalhadas (JSON)
docker top <id ou nome>               # processos rodando no container
docker diff <id ou nome>              # arquivos alterados no container
```

### Containers — remover

```bash
docker rm <id ou nome>                # remove container parado
docker rm <id ou nome> -f             # força parada e remoção
docker rm $(docker ps -aq)            # remove todos os containers parados
docker container prune                # remove todos os containers parados (com confirmação)
```

### Limpeza geral

```bash
docker system prune                   # remove containers, redes e imagens não usados
docker system prune -a                # remove tudo, incluindo imagens usadas
docker system prune -a --volumes      # remove tudo incluindo volumes
docker system df                      # uso de espaço em disco pelo Docker
```

---

## 📄 Dockerfile — criando imagens

O **Dockerfile** é o arquivo de instruções para construir uma imagem personalizada. Fica na raiz do projeto.

### Instruções principais

| Instrução | Descrição |
|---|---|
| `FROM` | Imagem base (obrigatória, sempre a primeira) |
| `WORKDIR` | Define o diretório de trabalho dentro do container |
| `COPY` | Copia arquivos do host para o container |
| `ADD` | Similar ao COPY, suporta URLs e descompactação |
| `RUN` | Executa comandos durante o build da imagem |
| `CMD` | Comando padrão ao iniciar o container (sobrescrito pelo `docker run`) |
| `ENTRYPOINT` | Ponto de entrada fixo do container |
| `EXPOSE` | Documenta a porta que o container usa |
| `ENV` | Define variáveis de ambiente |
| `ARG` | Variáveis disponíveis apenas durante o build |
| `VOLUME` | Cria um ponto de montagem para volumes |
| `USER` | Define o usuário para execução |
| `LABEL` | Metadados da imagem |

### Exemplo — aplicação Node.js

```dockerfile
# Imagem base — use versões específicas, não "latest"
FROM node:20-alpine

# Metadados
LABEL maintainer="seu@email.com"
LABEL version="1.0"

# Diretório de trabalho dentro do container
WORKDIR /usr/src/app

# Copia apenas o package.json primeiro (otimiza o cache de layers)
COPY package*.json ./

# Instala dependências
RUN npm ci --only=production

# Copia o restante do código
COPY . .

# Expõe a porta da aplicação (documentação)
EXPOSE 3000

# Usuário não-root por segurança
USER node

# Comando de inicialização
CMD ["node", "index.js"]
```

### Exemplo — aplicação Python

```dockerfile
FROM python:3.12-slim

WORKDIR /app

# Copia o requirements primeiro (cache de layers)
COPY requirements.txt .

# Instala dependências sem cache
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

USER nobody

CMD ["python", "main.py"]
```

### Construir e executar

```bash
# Construir a imagem
docker build -t minha-app:1.0 .

# Listar imagens
docker image ls

# Executar o container
docker run -d -p 3000:3000 --name minha-app minha-app:1.0

# Acessar no navegador
# http://localhost:3000
```

### `.dockerignore`

Crie na raiz do projeto para evitar copiar arquivos desnecessários:

```dockerignore
node_modules/
.venv/
__pycache__/
*.pyc
.env
.env.*
.git/
.gitignore
*.log
dist/
build/
README.md
.DS_Store
```

### Boas práticas no Dockerfile

```dockerfile
# ✅ Use imagens Alpine ou Slim (menores e mais seguras)
FROM python:3.12-slim          # ✅
FROM python:3.12               # ❌ imagem maior que o necessário

# ✅ Combine RUN para reduzir camadas
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

# ✅ Copie o arquivo de dependências antes do código
COPY requirements.txt .        # ✅ aproveita cache se o código mudar
COPY . .

# ✅ Use USER não-root
USER nobody

# ✅ Especifique versões exatas
FROM node:20.11.0-alpine       # ✅
FROM node:latest               # ❌ imprevisível
```

---

## 🗂️ Docker Compose

O **Docker Compose** permite definir e rodar múltiplos containers com um único arquivo YAML. Ideal para ambientes de desenvolvimento com múltiplos serviços.

### Exemplo — app + banco de dados

```yaml
# docker-compose.yml
version: "3.9"

services:

  app:
    build: .                          # constrói a partir do Dockerfile local
    container_name: minha-app
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgresql://user:senha@db:5432/meubanco
    depends_on:
      - db
    volumes:
      - .:/usr/src/app               # monta o código local (hot reload)
      - /usr/src/app/node_modules    # preserva node_modules do container
    restart: unless-stopped

  db:
    image: postgres:16-alpine
    container_name: meu-postgres
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: senha
      POSTGRES_DB: meubanco
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data   # persiste os dados
    restart: unless-stopped

volumes:
  postgres_data:
```

### Exemplo — app Python + Redis

```yaml
version: "3.9"

services:

  web:
    build: .
    ports:
      - "8000:8000"
    environment:
      - REDIS_URL=redis://redis:6379
    depends_on:
      - redis

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

volumes:
  redis_data:
```

### Comandos principais

```bash
# Subir os serviços
docker compose up                     # foreground (logs visíveis)
docker compose up -d                  # background (detached)
docker compose up --build             # reconstrói as imagens antes de subir
docker compose up --build -d          # reconstrói e sobe em background

# Parar os serviços
docker compose stop                   # para sem remover
docker compose down                   # para e remove containers e redes
docker compose down -v                # para, remove containers, redes e volumes

# Status e logs
docker compose ps                     # status dos serviços
docker compose logs                   # logs de todos os serviços
docker compose logs -f app            # logs em tempo real do serviço "app"
docker compose logs --tail 50         # últimas 50 linhas

# Executar comandos
docker compose exec app bash          # terminal no serviço "app"
docker compose exec db psql -U user   # acessa o psql no serviço "db"
docker compose run --rm app pytest    # executa comando pontual e remove o container

# Rebuild
docker compose build                  # constrói as imagens sem subir
docker compose pull                   # atualiza as imagens do registry
```

---

## 💾 Volumes — persistência de dados

Por padrão, dados criados dentro de um container são perdidos ao removê-lo. **Volumes** resolvem isso persistindo dados fora do ciclo de vida do container.

### Tipos de volumes

| Tipo | Sintaxe | Quando usar |
|---|---|---|
| **Named volume** | `volume_nome:/caminho` | Dados persistentes gerenciados pelo Docker |
| **Bind mount** | `/host/path:/container/path` | Compartilhar código-fonte durante dev |
| **tmpfs** | `--tmpfs /caminho` | Dados temporários em memória |

### Comandos

```bash
# Criar e listar
docker volume create meu-volume
docker volume ls
docker volume inspect meu-volume

# Usar volume ao rodar container
docker run -d -v meu-volume:/dados ubuntu
docker run -d -v $(pwd):/app -p 3000:3000 node   # bind mount do diretório atual

# Remover
docker volume rm meu-volume
docker volume prune                               # remove volumes não usados
```

### No Docker Compose

```yaml
services:
  db:
    image: postgres:16-alpine
    volumes:
      - postgres_data:/var/lib/postgresql/data   # named volume (persistente)
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql  # bind mount (arquivo local)

volumes:
  postgres_data:                                 # declara o volume nomeado
```

---

## 🌐 Redes

Redes permitem que containers se comuniquem entre si de forma isolada.

### Tipos de rede

| Tipo | Descrição |
|---|---|
| `bridge` | Padrão. Containers se comunicam pelo nome na mesma rede. |
| `host` | Container usa a rede do host diretamente. |
| `none` | Sem rede. Container completamente isolado. |
| `overlay` | Para clusters com Docker Swarm. |

### Comandos

```bash
# Criar e listar
docker network create minha-rede
docker network ls
docker network inspect minha-rede

# Conectar container a uma rede
docker run -d --network minha-rede --name app minha-imagem
docker network connect minha-rede container-existente
docker network disconnect minha-rede container-existente

# Remover
docker network rm minha-rede
docker network prune              # remove redes não usadas
```

### Comunicação entre containers

```bash
# Containers na mesma rede se comunicam pelo nome do serviço
# Ex: do container "app", acessar o banco "db":
psql -h db -U user meubanco       # "db" é o nome do serviço no Compose

# Containers em redes diferentes NÃO se comunicam por padrão
# Para conectar, use docker network connect ou defina redes no Compose
```

---

## 🔒 Boas práticas e segurança

### Imagens

```dockerfile
# ✅ Use imagens oficiais do Docker Hub
FROM python:3.12-slim              # ✅ oficial
FROM algumuser/python-custom       # ❌ desconhecido

# ✅ Prefira imagens Alpine ou Slim
FROM node:20-alpine                # ~50MB
FROM node:20                       # ~1GB

# ✅ Sempre especifique a versão — nunca use latest em produção
FROM postgres:16.2-alpine          # ✅
FROM postgres:latest               # ❌

# ✅ Use multi-stage build para imagens menores
FROM node:20-alpine AS builder
WORKDIR /app
COPY . .
RUN npm ci && npm run build

FROM node:20-alpine AS production
COPY --from=builder /app/dist ./dist
CMD ["node", "dist/index.js"]
```

### Segurança em runtime

```dockerfile
# ✅ Nunca rode como root
USER nobody                        # Linux genérico
USER node                          # imagens Node.js

# ✅ Leia apenas o necessário (filesystem read-only)
# docker run --read-only minha-app

# ✅ Limite recursos do container
# docker run --memory="512m" --cpus="1.0" minha-app
```

### Variáveis de ambiente

```bash
# ✅ Use arquivos .env (nunca versione segredos)
docker run --env-file .env minha-app

# ✅ No Compose, use .env na raiz do projeto
# O Compose carrega automaticamente variáveis de .env
```

```yaml
# docker-compose.yml — referencie variáveis sem hardcode
services:
  db:
    environment:
      POSTGRES_PASSWORD: ${DB_PASSWORD}   # lido do .env
```

```bash
# .env (nunca commitar no git)
DB_PASSWORD=minha-senha-secreta
```

### `.gitignore` para projetos Docker

```gitignore
.env
.env.*
*.log
docker-compose.override.yml
```

### Checklist de segurança

```bash
# Verificar vulnerabilidades na imagem
docker scout cves minha-imagem         # Docker Scout (integrado)
# ou
docker run --rm aquasec/trivy image minha-imagem   # Trivy (open source)

# Verificar configurações do Dockerfile
docker run --rm -i hadolint/hadolint < Dockerfile   # Hadolint (linter)
```

---

## 📚 Referências e fontes confiáveis

### Documentação oficial

| Recurso | Link |
|---|---|
| Documentação oficial Docker | [docs.docker.com](https://docs.docker.com) |
| Docker Hub — repositório de imagens | [hub.docker.com](https://hub.docker.com) |
| Dockerfile reference | [docs.docker.com/reference/dockerfile](https://docs.docker.com/reference/dockerfile) |
| Docker Compose reference | [docs.docker.com/compose](https://docs.docker.com/compose) |
| Docker Scout (segurança) | [docs.docker.com/scout](https://docs.docker.com/scout) |
| Play with Docker (sandbox online) | [labs.play-with-docker.com](https://labs.play-with-docker.com) |

### Tutoriais e cursos

| Recurso | Link |
|---|---|
| Tutorial em vídeo (referência) | [youtube.com/watch?v=np_vyd7QlXk](https://www.youtube.com/watch?v=np_vyd7QlXk) |
| Docker para desenvolvedores (Full Cycle) | [github.com/codeedu/wsl2-docker-quickstart](https://github.com/codeedu/wsl2-docker-quickstart) |
| Trivy — scanner de vulnerabilidades | [github.com/aquasecurity/trivy](https://github.com/aquasecurity/trivy) |
| Hadolint — linter para Dockerfile | [github.com/hadolint/hadolint](https://github.com/hadolint/hadolint) |

---

## 🪟 Complementar — Docker no Windows com WSL2

> Instala o Docker Engine diretamente no WSL2 sem precisar do Docker Desktop.

### 1. Habilitar WSL2 no Windows

Execute no **PowerShell como administrador:**

```powershell
# Habilitar WSL
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Habilitar Plataforma de Máquina Virtual
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Reiniciar o Windows
# Após reiniciar, defina o WSL2 como padrão
wsl --set-default-version 2
```

### 2. Instalar o kernel do WSL2

Baixe e instale o pacote de atualização do kernel:
[docs.microsoft.com/pt-br/windows/wsl/wsl2-kernel](https://docs.microsoft.com/pt-br/windows/wsl/wsl2-kernel)

### 3. Instalar o Ubuntu na Microsoft Store

- Abra a **Microsoft Store**
- Busque por **Ubuntu** (versão mais recente)
- Clique em **Instalar**
- Abra o Ubuntu e configure usuário e senha

### 4. Instalar o Docker Engine no Ubuntu (WSL2)

No terminal do Ubuntu:

```bash
# Instalar via script oficial
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Adicionar seu usuário ao grupo docker
sudo groupadd docker
sudo usermod -aG docker $USER

# Aplicar sem reiniciar
newgrp docker
```

### 5. Instalar o Oh My Zsh (opcional, recomendado)

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 6. Configurar aliases no `~/.zshrc`

```bash
# Abrir o arquivo de configuração
vim ~/.zshrc

# Adicionar os aliases
alias ll="ls -lah"
alias docker-up="sudo service docker start"
alias docker-down="sudo service docker stop"

# Salvar e sair do vim
# Esc → :wq → Enter

# Aplicar
source ~/.zshrc
```

### 7. Dia a dia — subir e parar o Docker

```bash
# No terminal Ubuntu (WSL2)
docker-up                     # inicia o serviço Docker
docker-down                   # para o serviço Docker

# Verificar status
sudo service docker status
```

### 8. Gerenciar o WSL pelo PowerShell

```powershell
# Listar distribuições instaladas
wsl -l -v

# Parar todas as distribuições WSL
wsl --shutdown

# Verificar após shutdown
wsl -l -v
```

### Referência completa

| Recurso | Link |
|---|---|
| Docker Engine no WSL2 (Full Cycle) | [github.com/codeedu/wsl2-docker-quickstart](https://github.com/codeedu/wsl2-docker-quickstart) |
| Documentação WSL2 (Microsoft) | [docs.microsoft.com/pt-br/windows/wsl](https://docs.microsoft.com/pt-br/windows/wsl) |

---

*Mantido com ❤️ — contribuições são bem-vindas via PR.*
