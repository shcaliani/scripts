🟨🟨 SHELL 

⭕️ COMANDOS

ls -la  | lista arquivos diretório
ls      | lista arquivos
ll      | lista arquivos do diretório
df      | Mostra a quantidade de espaço usada no disco rígido.
top     | Mostra o uso da memória.
cd      | Acessa uma determinada pasta (diretório)
mkdir   | Cria um diretório.
rmdir   | Apaga um diretorio vazio
rm -r   | Remove diretório não vazio
rm      | Remove um arquivo
cat     | Abre um arquivo.
cp      | Copia arquivos
diff    | Compara o conteúdo de dois arquivos ASCII
mv      | Move um arquivo
uniq    | Reporta ou apaga linhas repetidas num arquivo
wc      | Conta linhas, palavras e mesmo caracteres num arquivo
fold    | Encurta, ou seja, faz um fold das linhas longas para caberem no dispositivo de output
head    | Mostra as primeiras linhas de um arquivo, como por exemplo com head -10 a.txt, ou usado como filtro para mostrar apenas os primeiros x resultados de outro comando
ping    | Pingar um determinado host
jobs    | Permite-nos visualizar jobs em execução, quando corremos uma aplicação em background,
kill    | Mata um processo, como por exemplo kill -kill 100 ou kill -9 100 ou kill -9 %1
bg      | Coloca um processo suspenso em background
date    | Exibe a data e hora
history | Lista os últimos comandos usados, muito útil para lembrar também de que comandos foram usados
who     | Mostra-nos quem está logado no sistema
sleep 9 | Aguarda o tempo que indicar
touch   | Criar arquivos
time    | Na frente do comando, monitorar o tempo de execução nas dimensões [time xx.sh ou time ls]
cut     | Corta o texto conforme definiçao [cut -c2]
ps      | Lista os processos      [ps | cut -c7]

⭕️ ALIAS

Editar  | nano ~/.zshrc

_Listagem
alias ll="ls -lah"
alias la="ls -A"
alias l="ls -CF"

_Navegação
alias ..="cd .."          | sobe 1 nível
alias ...="cd ../.."      | sobe 2 níveis
alias ....="cd ../../.."  | sobe 3 níveis
alias ~="cd ~"            | volta para home

_Git
alias gs="git status"
alias ga="git add"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gp="git push"
alias gl="git log --oneline --graph --decorate --all"
alias gco="git checkout"
alias gb="git branch"

_Processos e Sistema
alias psg="ps aux | grep"   # busca processos
:Para zsh
alias topcpu='ps -Ao pid,pcpu,comm | sort -nrk 2 | head -20'
alias topmem='ps -Ao pid,ppid,pcpu,pmem,comm | sort -nrk 4 | head -20'
:Para linux
alias topcpu="ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head"
alias topmem="ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head"
alias free="vm_stat"         # equivalente ao free no Linux

_Visualização
alias c="clear"           | limpa terminal
alias h="history"         | mostra histórico
alias j="jobs -l"         | processos em background

# end
