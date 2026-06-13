# 🐚 Shell — Guia Completo de Comandos

> Referência completa de comandos Shell, aliases e boas práticas para terminal macOS (zsh) e Linux (bash). Atualizado e expandido.

---

## 📋 Índice

- [Navegação e Diretórios](#-navegação-e-diretórios)
- [Arquivos — Criar, Copiar, Mover e Remover](#-arquivos--criar-copiar-mover-e-remover)
- [Visualização de Conteúdo](#-visualização-de-conteúdo)
- [Busca e Filtragem](#-busca-e-filtragem)
- [Permissões](#-permissões)
- [Processos e Sistema](#-processos-e-sistema)
- [Rede](#-rede)
- [Compactação e Arquivos](#-compactação-e-arquivos)
- [Variáveis e Ambiente](#-variáveis-e-ambiente)
- [Redirecionamento e Pipes](#-redirecionamento-e-pipes)
- [Usuários e Sistema](#-usuários-e-sistema)
- [Data e Tempo](#-data-e-tempo)
- [Alias — Atalhos Personalizados](#-alias--atalhos-personalizados)
- [Configurando o Shell (zshrc / bashrc)](#-configurando-o-shell-zshrc--bashrc)
- [Dicas e Atalhos de Teclado](#-dicas-e-atalhos-de-teclado)
- [Fontes e Referências](#-fontes-e-referências)
- [Complementar — Oh My Zsh](#-complementar--oh-my-zsh)
- [Complementar — btop](#-complementar--btop)

---

## 📁 Navegação e Diretórios

```bash
pwd                         # exibe o diretório atual (Print Working Directory)
cd pasta/                   # acessa um diretório
cd ..                       # sobe um nível
cd ../..                    # sobe dois níveis
cd ~                        # vai para o diretório home
cd -                        # volta para o diretório anterior
cd /                        # vai para a raiz do sistema

ls                          # lista arquivos e pastas
ls -l                       # lista em formato detalhado
ls -a                       # lista incluindo arquivos ocultos (. e ..)
ls -la                      # detalhado + ocultos
ls -lah                     # detalhado + ocultos + tamanho legível (ex: 1.2M)
ls -lt                      # ordena por data de modificação (mais recente primeiro)
ls -lS                      # ordena por tamanho (maior primeiro)
ls -R                       # lista recursivamente (inclui subpastas)
ls *.txt                    # lista apenas arquivos .txt

mkdir nome-pasta            # cria um diretório
mkdir -p pai/filho/neto     # cria diretórios aninhados de uma vez
rmdir nome-pasta            # remove diretório vazio
rm -r pasta/                # remove diretório e todo seu conteúdo
rm -rf pasta/               # remove sem pedir confirmação (⚠️ irreversível)

tree                        # exibe a estrutura em árvore (instalar: brew install tree)
tree -L 2                   # limita a profundidade a 2 níveis
tree -a                     # inclui arquivos ocultos
```

---

## 📄 Arquivos — Criar, Copiar, Mover e Remover

```bash
touch arquivo.txt           # cria arquivo vazio ou atualiza timestamp
touch a.txt b.txt c.txt     # cria múltiplos arquivos de uma vez

cp origem.txt destino.txt   # copia arquivo
cp -r pasta/ destino/       # copia diretório recursivamente
cp -p arquivo.txt backup/   # copia preservando permissões e data

mv arquivo.txt nova-pasta/  # move arquivo para outra pasta
mv nome-antigo.txt novo.txt # renomeia arquivo

rm arquivo.txt              # remove arquivo
rm -i arquivo.txt           # remove pedindo confirmação
rm *.log                    # remove todos os arquivos .log

ln -s origem destino        # cria link simbólico (atalho)
```

---

## 👁️ Visualização de Conteúdo

```bash
cat arquivo.txt             # exibe o conteúdo completo do arquivo
cat -n arquivo.txt          # exibe com número de linhas
cat a.txt b.txt > c.txt     # concatena dois arquivos em um terceiro

less arquivo.txt            # visualiza com scroll (q para sair)
more arquivo.txt            # semelhante ao less, mais simples

head arquivo.txt            # exibe as 10 primeiras linhas
head -20 arquivo.txt        # exibe as 20 primeiras linhas
head -5 arquivo.txt | cat   # primeiros 5 resultados via pipe

tail arquivo.txt            # exibe as 10 últimas linhas
tail -20 arquivo.txt        # exibe as 20 últimas linhas
tail -f arquivo.log         # acompanha o arquivo em tempo real (útil para logs)
tail -f arquivo.log | grep "ERROR"  # monitora apenas erros em tempo real

wc arquivo.txt              # conta linhas, palavras e caracteres
wc -l arquivo.txt           # conta apenas linhas
wc -w arquivo.txt           # conta apenas palavras
wc -c arquivo.txt           # conta apenas caracteres/bytes

diff arquivo1.txt arquivo2.txt        # compara dois arquivos linha a linha
diff -u arquivo1.txt arquivo2.txt     # formato unificado (mais legível)

fold -w 80 arquivo.txt      # quebra linhas longas em 80 caracteres
uniq arquivo.txt            # remove linhas duplicadas consecutivas
uniq -c arquivo.txt         # conta ocorrências de cada linha
sort arquivo.txt            # ordena as linhas alfabeticamente
sort -r arquivo.txt         # ordena em ordem reversa
sort -n numeros.txt         # ordena numericamente
```

---

## 🔍 Busca e Filtragem

```bash
grep "palavra" arquivo.txt          # busca uma palavra no arquivo
grep -i "palavra" arquivo.txt       # busca ignorando maiúsculas/minúsculas
grep -r "palavra" pasta/            # busca recursivamente em uma pasta
grep -n "palavra" arquivo.txt       # exibe o número da linha
grep -v "palavra" arquivo.txt       # exibe linhas que NÃO contêm a palavra
grep -l "palavra" *.txt             # lista apenas os arquivos que contêm a palavra
grep -c "palavra" arquivo.txt       # conta as ocorrências

# Buscar arquivos
find . -name "arquivo.txt"          # busca por nome no diretório atual
find . -name "*.log"                # busca por extensão
find . -type f -name "*.txt"        # apenas arquivos (não pastas)
find . -type d                      # apenas diretórios
find . -mtime -7                    # modificados nos últimos 7 dias
find . -size +1M                    # arquivos maiores que 1MB
find . -name "*.tmp" -delete        # busca e deleta arquivos .tmp

# Filtrar colunas e campos
cut -d":" -f1 /etc/passwd           # exibe o 1º campo separado por ":"
cut -c1-10 arquivo.txt              # exibe os 10 primeiros caracteres de cada linha
awk '{print $1}' arquivo.txt        # exibe a 1ª coluna
awk -F"," '{print $2}' dados.csv    # exibe a 2ª coluna de um CSV

# Substituição de texto
sed 's/antigo/novo/g' arquivo.txt           # substitui no output
sed -i 's/antigo/novo/g' arquivo.txt        # substitui diretamente no arquivo
sed -n '5,10p' arquivo.txt                  # exibe somente as linhas 5 a 10
```

---

## 🔐 Permissões

```bash
ls -l arquivo.txt           # exibe as permissões (ex: -rwxr-xr--)

chmod 755 script.sh         # dono pode tudo, grupo e outros só leitura/execução
chmod 644 arquivo.txt       # dono lê e escreve, grupo e outros só leitura
chmod +x script.sh          # torna o arquivo executável
chmod -x script.sh          # remove a permissão de execução
chmod -R 755 pasta/         # aplica recursivamente

chown usuario arquivo.txt           # muda o dono do arquivo
chown usuario:grupo arquivo.txt     # muda dono e grupo
chown -R usuario:grupo pasta/       # aplica recursivamente

# Tabela de permissões
# 7 = rwx (leitura + escrita + execução)
# 6 = rw- (leitura + escrita)
# 5 = r-x (leitura + execução)
# 4 = r-- (somente leitura)
# 0 = --- (nenhuma permissão)
```

---

## ⚙️ Processos e Sistema

```bash
ps                          # lista processos da sessão atual
ps aux                      # lista todos os processos do sistema
ps aux | grep nome          # filtra processos por nome
ps -Ao pid,pcpu,comm        # PID, CPU% e nome do processo

top                         # monitor de processos em tempo real
htop                        # versão melhorada do top (instalar: brew install htop)
btop                        # interface gráfica no terminal (ver instalação abaixo)

kill PID                    # envia sinal de término ao processo
kill -9 PID                 # força o encerramento (SIGKILL)
kill -9 %1                  # mata o job número 1
killall nome-processo        # mata todos os processos com o nome

jobs                        # lista jobs em execução em background
jobs -l                     # lista com PIDs
bg %1                       # coloca o job 1 em background
fg %1                       # traz o job 1 para foreground
comando &                   # executa um comando já em background
Ctrl+Z                      # suspende o processo atual (manda para background)
Ctrl+C                      # interrompe o processo atual

# ── Instalando o btop ─────────────────────────────
# btop é um monitor de recursos com interface gráfica no terminal
# Exibe CPU, memória, disco, rede e processos de forma visual

# macOS — via Homebrew
brew install btop

# Linux — Ubuntu/Debian
sudo apt update && sudo apt install btop

# Linux — Fedora/RHEL
sudo dnf install btop

# Linux — via compilação (qualquer distro)
git clone https://github.com/aristocratos/btop.git
cd btop
make
sudo make install

# Executar
btop                        # abre o monitor
# Atalhos dentro do btop:
# q          → sai
# F2 / o    → abre as opções
# m          → alterna entre layouts de memória
# p          → ordena por CPU
# e          → ordena por memória
# k          → mata o processo selecionado
# setas      → navega entre processos

# Espaço em disco
df -h                       # espaço usado e disponível por partição (legível)
df -H                       # mesmo, mas em potências de 1000
du -sh pasta/               # tamanho total de uma pasta
du -sh *                    # tamanho de cada item no diretório atual
du -sh * | sort -rh | head  # os 10 maiores itens

# Memória
vmstat                      # estatísticas de memória e swap
vmstat -s                   # resumo do sistema
free -h                     # uso de memória (Linux)
vm_stat                     # equivalente no macOS

# Tempo de execução
time comando                # mede o tempo de execução de um comando
time ls -la
time ./script.sh

# Informações do sistema
uname -a                    # informações do kernel e sistema
uname -m                    # arquitetura (ex: arm64, x86_64)
hostname                    # nome da máquina
uptime                      # há quanto tempo o sistema está ligado
sw_vers                     # versão do macOS
lsb_release -a              # versão do Linux (Ubuntu/Debian)
```

---

## 🌐 Rede

```bash
ping google.com             # verifica conectividade com um host
ping -c 4 google.com        # envia apenas 4 pacotes

curl https://exemplo.com                    # faz uma requisição HTTP GET
curl -I https://exemplo.com                 # apenas os headers da resposta
curl -O https://exemplo.com/arquivo.zip     # baixa um arquivo
curl -L https://exemplo.com                 # segue redirecionamentos
curl -X POST -d "dados" https://api.com     # requisição POST

wget https://exemplo.com/arquivo.zip        # baixa arquivo (Linux)

ifconfig                    # configurações de rede (macOS)
ip addr                     # configurações de rede (Linux)
netstat -an                 # conexões de rede ativas
lsof -i :8080               # qual processo está usando a porta 8080
ss -tuln                    # portas abertas (Linux)

nslookup google.com         # consulta DNS
dig google.com              # consulta DNS detalhada
traceroute google.com       # rota dos pacotes até o destino
whois google.com            # informações do domínio

ssh usuario@host            # conecta a um servidor remoto via SSH
ssh -p 2222 usuario@host    # SSH em porta específica
scp arquivo.txt usuario@host:/destino/  # copia arquivo via SSH
```

---

## 📦 Compactação e Arquivos

```bash
# tar
tar -czf arquivo.tar.gz pasta/          # compacta em .tar.gz
tar -xzf arquivo.tar.gz                 # descompacta .tar.gz
tar -czf arquivo.tar.gz -C /caminho .   # compacta a partir de um caminho
tar -tf arquivo.tar.gz                  # lista o conteúdo sem extrair

# zip
zip arquivo.zip arquivo.txt             # compacta em .zip
zip -r arquivo.zip pasta/               # compacta pasta em .zip
unzip arquivo.zip                       # descompacta .zip
unzip -l arquivo.zip                    # lista conteúdo sem extrair
unzip arquivo.zip -d destino/           # descompacta em pasta específica

# gzip
gzip arquivo.txt                        # compacta (substitui o original)
gzip -d arquivo.txt.gz                  # descompacta
gunzip arquivo.txt.gz                   # equivalente ao gzip -d
```

---

## 🌍 Variáveis e Ambiente

```bash
echo $HOME                  # exibe o valor da variável HOME
echo $PATH                  # exibe os diretórios do PATH
echo $SHELL                 # exibe o shell atual
echo $USER                  # exibe o usuário atual
printenv                    # lista todas as variáveis de ambiente
printenv HOME               # exibe uma variável específica

# Definir variável (apenas na sessão atual)
MINHA_VAR="valor"
echo $MINHA_VAR

# Exportar variável (disponível para processos filhos)
export MINHA_VAR="valor"

# Adicionar ao PATH permanentemente (no ~/.zshrc ou ~/.bashrc)
export PATH="$HOME/.local/bin:$PATH"

# Variáveis úteis
$HOME                       # /Users/seu-usuario (macOS) ou /home/seu-usuario (Linux)
$PWD                        # diretório atual
$OLDPWD                     # diretório anterior
$?                          # código de saída do último comando (0 = sucesso)
$$                          # PID do processo atual
$0                          # nome do script em execução
```

---

## 🔀 Redirecionamento e Pipes

```bash
# Pipes — encadeia a saída de um comando como entrada do próximo
ls -la | grep ".txt"        # filtra arquivos .txt
ps aux | grep python        # filtra processos python
cat arquivo.txt | sort | uniq   # ordena e remove duplicatas
history | grep git          # busca comandos git no histórico

# Redirecionamento de saída
echo "texto" > arquivo.txt  # escreve no arquivo (sobrescreve)
echo "texto" >> arquivo.txt # adiciona ao arquivo (append)
ls -la > lista.txt          # salva o resultado do ls no arquivo

# Redirecionamento de erro
comando 2> erros.txt        # redireciona erros para arquivo
comando 2>/dev/null         # descarta erros (suprime mensagens de erro)
comando > saida.txt 2>&1    # redireciona saída e erros para o mesmo arquivo

# Redirecionamento de entrada
sort < arquivo.txt          # usa arquivo como entrada
mysql -u root -p db < dump.sql  # importa SQL de arquivo

# Encadeamento de comandos
cmd1 && cmd2                # executa cmd2 somente se cmd1 teve sucesso
cmd1 || cmd2                # executa cmd2 somente se cmd1 falhou
cmd1 ; cmd2                 # executa cmd2 independente do resultado do cmd1
```

---

## 👤 Usuários e Sistema

```bash
who                         # mostra usuários logados
whoami                      # exibe o usuário atual
id                          # exibe UID, GID e grupos do usuário
groups                      # lista os grupos do usuário atual
last                        # histórico de logins

sudo comando                # executa com permissão de superusuário
sudo !!                     # repete o último comando com sudo
su - usuario                # muda para outro usuário

# Gerenciamento de pacotes
# macOS (Homebrew)
brew install nome           # instala um pacote
brew uninstall nome         # desinstala
brew update                 # atualiza o Homebrew
brew upgrade                # atualiza todos os pacotes
brew list                   # lista pacotes instalados
brew search nome            # busca um pacote
brew info nome              # informações sobre um pacote

# Linux (apt — Debian/Ubuntu)
sudo apt update             # atualiza a lista de pacotes
sudo apt upgrade            # atualiza os pacotes instalados
sudo apt install nome       # instala um pacote
sudo apt remove nome        # desinstala
sudo apt search nome        # busca um pacote

# Linux (dnf — Fedora/RHEL)
sudo dnf install nome
sudo dnf remove nome
sudo dnf update
```

---

## 📅 Data e Tempo

```bash
date                        # exibe data e hora atual
date "+%d/%m/%Y"            # formata: dia/mês/ano
date "+%H:%M:%S"            # formata: hora:minuto:segundo
date "+%Y-%m-%d_%H-%M-%S"   # formato para nomes de arquivo

cal                         # exibe o calendário do mês atual
cal 2025                    # exibe o calendário do ano

sleep 5                     # aguarda 5 segundos
sleep 0.5                   # aguarda meio segundo

# Medir tempo de execução
time comando
time sleep 2
```

---

## 🔧 Alias — Atalhos Personalizados

Adicione os aliases no arquivo `~/.zshrc` (macOS/zsh) ou `~/.bashrc` (Linux/bash).

### Listagem

```bash
alias ll="ls -lah"          # listagem detalhada com tamanho legível
alias la="ls -A"            # lista incluindo ocultos (sem . e ..)
alias l="ls -CF"            # lista em colunas
alias lt="ls -lth"          # ordena por data de modificação
alias lS="ls -lSh"          # ordena por tamanho
```

### Navegação

```bash
alias ..="cd .."            # sobe 1 nível
alias ...="cd ../.."        # sobe 2 níveis
alias ....="cd ../../.."    # sobe 3 níveis
alias ~="cd ~"              # vai para home
alias desk="cd ~/Desktop"   # atalho para Desktop
alias docs="cd ~/Documents" # atalho para Documents
alias proj="cd ~/Projects"  # atalho para pasta de projetos
```

### Git

```bash
alias gs="git status"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit -v"
alias gcm="git commit -m"
alias gca="git commit -v -a"
alias gp="git push"
alias gpl="git pull"
alias gl="git log --oneline --graph --decorate --all"
alias gco="git checkout"
alias gb="git branch"
alias gba="git branch -a"
alias gd="git diff"
alias gds="git diff --staged"
alias gst="git stash"
alias gstp="git stash pop"
```

### Processos e Sistema

```bash
# macOS (zsh)
alias topcpu='ps -Ao pid,pcpu,comm | sort -nrk 2 | head -20'
alias topmem='ps -Ao pid,ppid,pcpu,pmem,comm | sort -nrk 4 | head -20'
alias free="vm_stat"            # equivalente ao free do Linux
alias psg="ps aux | grep"       # busca processos por nome

# Linux (bash)
alias topcpu="ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head"
alias topmem="ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head"
alias psg="ps aux | grep"
```

### Visualização e Terminal

```bash
alias c="clear"             # limpa o terminal
alias h="history"           # mostra o histórico
alias j="jobs -l"           # lista jobs em background
alias path='echo -e ${PATH//:/\\n}'  # exibe PATH um por linha
alias now='date "+%Y-%m-%d %H:%M:%S"'  # data e hora formatada
```

### Segurança — Confirmação em operações perigosas

```bash
alias rm="rm -i"            # pede confirmação antes de remover
alias cp="cp -i"            # pede confirmação antes de sobrescrever
alias mv="mv -i"            # pede confirmação antes de sobrescrever
```

### Utilitários

```bash
alias myip="curl -s ifconfig.me"          # exibe seu IP público
alias ports="lsof -i -P -n | grep LISTEN" # lista portas abertas
alias reload="source ~/.zshrc"             # recarrega as configurações do shell
alias zshconfig="nano ~/.zshrc"            # abre o arquivo de config do zsh
alias hosts="sudo nano /etc/hosts"         # abre o arquivo hosts
alias diskspace="df -h | grep -v tmpfs"    # uso de disco legível
alias foldersize="du -sh * | sort -rh"     # tamanho de cada pasta
```

---

## 🛠️ Configurando o Shell (zshrc / bashrc)

```bash
# Abrir o arquivo de configuração
nano ~/.zshrc               # editor nano
code ~/.zshrc               # VS Code
vim ~/.zshrc                # vim

# Aplicar as alterações sem reiniciar o terminal
source ~/.zshrc             # zsh
source ~/.bashrc            # bash

# Verificar qual shell está ativo
echo $SHELL
which zsh
which bash

# Mudar o shell padrão
chsh -s /bin/zsh            # muda para zsh
chsh -s /bin/bash           # muda para bash
```

**Estrutura recomendada do `~/.zshrc`:**

```bash
# ── PATH ──────────────────────────────────────────
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"

# ── VARIÁVEIS DE AMBIENTE ─────────────────────────
export EDITOR="code --wait"
export LANG="pt_BR.UTF-8"

# ── ALIAS ─────────────────────────────────────────
alias ll="ls -lah"
alias gs="git status"
alias c="clear"

# ── FUNÇÕES ───────────────────────────────────────
mkcd() { mkdir -p "$1" && cd "$1"; }    # cria pasta e entra nela
extract() {                              # descompacta qualquer formato
  case "$1" in
    *.tar.gz)  tar -xzf "$1" ;;
    *.zip)     unzip "$1" ;;
    *.tar.bz2) tar -xjf "$1" ;;
    *)         echo "Formato não suportado" ;;
  esac
}

# ── HISTÓRICO ─────────────────────────────────────
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups    # não salva duplicatas
```

### Função `halias` — listagem categorizada dos aliases

Adicione ao `~/.zshrc` logo após os aliases. Digite `halias` no terminal para ver todos os atalhos organizados por categoria.

```bash
halias() {
  echo ""
  echo "── LISTAGEM ──────────────────────────────────────"
  alias ll la l lt lS 2>/dev/null

  echo ""
  echo "── NAVEGAÇÃO ─────────────────────────────────────"
  alias .. ... .... desk docs proj 2>/dev/null
  alias '~' 2>/dev/null

  echo ""
  echo "── GIT ───────────────────────────────────────────"
  alias gs ga gaa gc gcm gca gp gpl gl gco gb gba gd gds gst gstp 2>/dev/null

  echo ""
  echo "── PROCESSOS E SISTEMA ───────────────────────────"
  alias topcpu topmem psg free diskspace foldersize ports myip 2>/dev/null

  echo ""
  echo "── TERMINAL ──────────────────────────────────────"
  alias c h j path now reload zshconfig hosts 2>/dev/null

  echo ""
  echo "── SEGURANÇA ─────────────────────────────────────"
  alias rm cp mv 2>/dev/null

  echo ""
  echo "$(alias | wc -l | tr -d ' ') aliases ativos  ·  use  alias | grep <termo>  para filtrar"
  echo ""
}
```

---

## ⌨️ Dicas e Atalhos de Teclado

| Atalho | Ação |
|---|---|
| `Ctrl+C` | Interrompe o comando em execução |
| `Ctrl+Z` | Suspende o processo (manda para background) |
| `Ctrl+D` | Sai do terminal / encerra a sessão |
| `Ctrl+L` | Limpa a tela (equivale ao `clear`) |
| `Ctrl+A` | Move o cursor para o início da linha |
| `Ctrl+E` | Move o cursor para o final da linha |
| `Ctrl+U` | Apaga tudo antes do cursor |
| `Ctrl+K` | Apaga tudo depois do cursor |
| `Ctrl+W` | Apaga a palavra anterior |
| `Ctrl+R` | Busca reversa no histórico de comandos |
| `↑ / ↓` | Navega pelo histórico de comandos |
| `Tab` | Autocomplete de comandos e caminhos |
| `Tab Tab` | Mostra todas as opções de autocomplete |
| `!!` | Repete o último comando |
| `!git` | Repete o último comando que começou com `git` |
| `sudo !!` | Repete o último comando com sudo |
| `Ctrl+A` + `Ctrl+K` | Limpa a linha inteira |

---

## 📚 Fontes e Referências

| Recurso | Link |
|---|---|
| Manual oficial (man pages) | `man nome-do-comando` no terminal |
| ExplainShell — explica cada parte do comando | [explainshell.com](https://explainshell.com) |
| TLDR Pages — man pages simplificadas | [tldr.sh](https://tldr.sh) — `brew install tldr` |
| SS64 — referência de comandos por OS | [ss64.com](https://ss64.com) |
| Shell Check — valida scripts shell | [shellcheck.net](https://www.shellcheck.net) |
| Homebrew (macOS) | [brew.sh](https://brew.sh) |
| Bash Scripting Guide | [tldp.org/LDP/Bash-Beginners-Guide](https://tldp.org/LDP/Bash-Beginners-Guide/html/) |
| Zsh Documentation | [zsh.sourceforge.io](https://zsh.sourceforge.io/Doc/) |

---

## ⚡ Referência Rápida

```bash
# Os comandos que você vai usar 90% do tempo
ls -lah                     # lista arquivos com detalhes
cd pasta/ | cd ..           # navega entre diretórios
mkdir | rm -r               # cria ou remove pasta
cp | mv | rm                # copia, move ou remove arquivo
cat | less | head | tail    # lê conteúdo de arquivos
grep "texto" arquivo        # busca texto
find . -name "*.txt"        # busca arquivos
ps aux | grep nome          # encontra processo
kill -9 PID                 # mata processo
df -h | du -sh *            # uso de disco
chmod +x script.sh          # torna executável
source ~/.zshrc             # recarrega configurações
history | grep comando      # busca no histórico
```

---

*Mantido com ❤️ — contribuições são bem-vindas via PR.*

---

## 🎨 Complementar — Oh My Zsh

> Oh My Zsh é um framework open source para gerenciar a configuração do Zsh. Adiciona temas, plugins e atalhos que tornam o terminal muito mais produtivo e visual.

---

### Instalação

**Pré-requisitos**

```bash
# Verificar se o Zsh está instalado
zsh --version

# Instalar o Zsh (se necessário)
sudo apt install zsh           # Ubuntu/Debian
brew install zsh               # macOS

# Instalar dependências
sudo apt install wget git      # Ubuntu/Debian

# Instalar fontes Powerline (necessárias para temas com ícones)
sudo apt install powerline fonts-powerline
```

**Instalar o Oh My Zsh**

```bash
# Via curl (recomendado)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Via wget (alternativa)
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

**Definir o Zsh como shell padrão**

```bash
chsh -s $(which zsh)
# Feche e reabra o terminal para aplicar
```

---

### Configuração

```bash
# Arquivo principal de configuração
nano ~/.zshrc

# Verificar o shell ativo
echo $SHELL

# Aplicar alterações sem reiniciar o terminal
source ~/.zshrc
```

---

### Temas

```bash
# Alterar o tema — edite a linha ZSH_THEME no ~/.zshrc
ZSH_THEME="robbyrussell"                         # padrão — simples e limpo
ZSH_THEME="agnoster"                             # popular — exige fonte Powerline
ZSH_THEME="powerlevel10k/powerlevel10k"          # mais completo (ver instalação abaixo)
ZSH_THEME="af-magic"                             # colorido e informativo
ZSH_THEME="random"                               # tema aleatório a cada sessão

# Após alterar, aplique
source ~/.zshrc
```

**Instalar o Powerlevel10k (tema mais popular)**

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Defina no ~/.zshrc
ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.zshrc

# O assistente de configuração inicia automaticamente
# Para reconfigurar manualmente
p10k configure
```

---

### Plugins

```bash
# Ativar plugins — edite a linha plugins no ~/.zshrc
plugins=(git z sudo web-search copypath jsontools)

# Plugins nativos mais úteis (já incluídos no Oh My Zsh)
# git        → aliases de git (gs, gp, gl...)
# z          → navega para pastas frequentes com: z nome-pasta
# sudo       → pressione ESC ESC para adicionar sudo ao comando anterior
# web-search → pesquisa no terminal: google "termo"
# copypath   → copia o caminho atual para a área de transferência
# jsontools  → formata e valida JSON no terminal
```

**Plugins externos recomendados**

```bash
# zsh-autosuggestions — sugere comandos enquanto você digita
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting — destaca comandos em tempo real
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Ative os dois no ~/.zshrc
plugins=(git z sudo zsh-autosuggestions zsh-syntax-highlighting)

source ~/.zshrc
```

---

### Atualização e Manutenção

```bash
omz update                    # atualiza o Oh My Zsh
omz version                   # versão instalada
omz reload                    # recarrega as configurações

# Desinstalar
uninstall_oh_my_zsh
```

---

### Referências

| Recurso | Link |
|---|---|
| Site oficial | [ohmyz.sh](https://ohmyz.sh) |
| Repositório GitHub | [github.com/ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) |
| Lista de temas | [github.com/ohmyzsh/ohmyzsh/wiki/Themes](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes) |
| Lista de plugins | [github.com/ohmyzsh/ohmyzsh/wiki/Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins) |
| Powerlevel10k | [github.com/romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k) |
| Tutorial em vídeo | [youtube.com/watch?v=bs1-Wxb_KIc](https://www.youtube.com/watch?v=bs1-Wxb_KIc) |

---

## 📊 Complementar — btop

> btop é um monitor de recursos com interface gráfica no terminal. Exibe CPU, memória, disco, rede e processos de forma visual e interativa, em tempo real.

---

### Instalação

```bash
# macOS — via Homebrew
brew install btop

# Ubuntu/Debian
sudo apt update && sudo apt install btop

# Fedora/RHEL
sudo dnf install btop

# Arch Linux
sudo pacman -S btop

# Linux — via compilação (qualquer distro)
git clone https://github.com/aristocratos/btop.git
cd btop
make
sudo make install
```

---

### Executar e Navegar

```bash
btop                          # abre o monitor
```

| Atalho | Ação |
|---|---|
| `q` | sai do btop |
| `F2` ou `o` | abre as opções de configuração |
| `m` | alterna entre layouts de memória |
| `p` | ordena processos por CPU |
| `e` | ordena processos por memória |
| `k` | mata o processo selecionado |
| `f` | filtra processos por nome |
| `+` / `-` | aumenta ou reduz o intervalo de atualização |
| `setas` | navega entre processos e painéis |
| `Esc` | fecha menus e filtros |

---

### Configuração

```bash
# Arquivo de configuração (criado automaticamente na primeira execução)
~/.config/btop/btop.conf

# Temas disponíveis em
~/.config/btop/themes/

# Temas da comunidade
git clone https://github.com/aristocratos/btop.git
# Os temas ficam em btop/themes/
```

---

### Atualização e Desinstalação

```bash
# macOS
brew upgrade btop

# Ubuntu/Debian
sudo apt upgrade btop

# Via compilação
cd btop
git pull
make
sudo make install

# Desinstalar (via compilação)
sudo make uninstall
```

---

### Referências

| Recurso | Link |
|---|---|
| Repositório oficial | [github.com/aristocratos/btop](https://github.com/aristocratos/btop) |
| Temas da comunidade | [github.com/aristocratos/btop/tree/main/themes](https://github.com/aristocratos/btop/tree/main/themes) |
| Homebrew | [formulae.brew.sh/formula/btop](https://formulae.brew.sh/formula/btop) |

---

*Mantido com ❤️ — contribuições são bem-vindas via PR.*
