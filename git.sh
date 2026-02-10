🟨🟨 GIT    

⭕ GIT CONFIG

git config --global user.name "Leonardo Comelli"
git config --list
git config --global core.excludesfile ~/.gitignore      | arquivos a serem ignorados
git config --global user.name "nnn"
git config --global user.email "eee"
git config user.name                                    | para ver o conteúdo da configuração
git config --list                                       | para saber a configuração git

🔶 criar pasta

mkdir nome_pasta                                        | criando uma pasta
cd nome_pasta
git init                                                | inicializa o diretório e encherga todas as mudanças e o .git
cd .git/                                                | possui a head, branches, config...

## criar o arquivo Readme.md na branche master

🔶 tipos arquivos / lifecycle dos arquivos

: untracked = não foi visto pelo git
: unmodified = visto pelo git, mas não modificado
: modified = arquivo modificado
: staged = pronto para levar qdo criada a nova versão


⭕ COMANDOS

🔶 help

git help add
git help commit
git help [qualquer_comando_git]

🔶 check status - diff - log

git status                                              | checa se há arquivos não atualizados

git diff opção_nome_arquivo                             | ver as mudanças antes commit
git diff --name-only                                    | exibe somente os nomes dos arquivos alterados
git diff master                                         | diferença da branch atual para a master
git diff origin/master                                  | diferença com o repositório master remoto

git log                                                 | todas as alterações realizadas em um repositório
git log --graph
git log -p -2                                           | histórico com diff das duas últimas alterações
git log --stat                                          | histórico (hash completa, autor, data, comentário e qtde alt (+/-))
                                                        | %h: Abreviação de hash;  %an: Nome autor; %ar: Data;  %s: Comentário
git log --diff-filter=M -- path                         | histórico modificação de um arquivo
git log --author                                        | mostra somente o autor
git shortlog                                            | quais autores e número de commits
git shortlog -sn                                        | quantidade de comits por autor

🔶 retore

git restore path_arquivo_exeteção                       | desfaz as modificações voltando o arquivo ao estado anterior

🔶 desfaz e reseta

git checkout -- meu_arquivo.txt                         | Desfaz alteração local enquanto arquivo estiver na staged area
git reset HEAD meu_arquivo.txt                          | deve ser utilizado quando o arquivo já foi adicionado na staged area
git reset --soft  _hash_                                | desfaz commit mas deixa o arquivo em staged   - um commit antes
git reset --mixed _hash_                                | desfaz commit e volta antes staged            - um commit antes
git reset --hard  _hash_                                | desfaz commit e tudo o que foi feito          - um commit antes

🔶 remove arq/dir

git rm meu_arquivo.txt                                  | remove arquivo
git rm -r diretorio                                     | remove diretorio

🔶 comandos stash

git stash nome_arquivo                                  | um arquivo em wip, então ele não leva para uma nova branch
git stash list                                          | lista arquivos em modo stash (wip)
git stash clear                                         | libera arquivos 
     
🔶 alias

git config --global alias.sts status
git sts                                                 | visualiza o status - serve para todos os comandos

🔶 tags gerando versões

git tag -a 1.0.0. -m "mensagem"   
git push origin master --tags                           | subindo as tags - acessada no github em 'releases'
git tag                                                 | lista as tags

🔶 apagar branch e tags no diretório remoto

git tag -d 1.0.1                                        | apagando no repositório local
git push origin :1.0.0                                  | apagando no repositório remoto
git push origin :nome_branch



⭕ DESCE : GIT --> LOCAL

🔶 clonar diretório

git clone [url] 
git pull                                                | atualiza diretório local com a nuvem

🔶 desce tudo 

git pull                                                | atualiza diretório local com a nuvem



⭕ SOBE : LOCAL --> GIT

🔶 subindo novo diretório 

git remote add origin git@github.com:nome-usuario.git   | ao criar o repositório no git ele fornece o comando e endereço
git remote                                              | o diretório conectado
git remote -v                                           | dados da conexão
git push -u origin master                               | envia tudo para o repositório remoto

git add --all  
git commit -m "novo dir" 
git push 

🔶 Inicializando novo diretório local no git

cria diretório no Github                                | via browser no Github
git init                                                | no terminal e diretório a ser feito upload
git add .                                               | git status mostra arquivos adicionados
git commit -m "mensagem"                                | git status mostra aquivos comitados
git branch -M main    

🔶 sobe só diretório

git add --all                                           | git add .
git commit -m "mensagem"                                | adiciona todos e comita direto
git push  

🔶 subindo só arquivo

git add nome-arquivo.ext
git commit -m "mensagem"
git push

🔶 tudo numa linha

git add --all && git commit -m "x" && git push


⭕ BRANCHES

git branch                                              | ver a branch logada
git checkout                                            | sai da branch
git checkout <nome_branch>                              | para mudar de branch
git checkout -b <nova branch>                           | sai da branch e cria uma nova
git checkout nome-novo                                  | redefina o branch upstream para o branch local nome-novo
git merge <nome branch> (que não estou logado)          | faz o merge da branch atual com a outra
git push
git checkout -b nome_branch                             | criando um branch
it push -u origin nome_branch                           | sobre branch para repositório remoto

git branch -m nome-novo                                 | alterar nome da branch estando na mesma
git branch -m nome-antigo nome-novo                     | alterar nome da branch estando em outra
git push origin :nome-antigo nome-novo                  | remova branch remoto com o nome antigo e crie o branch novo
git push origin -u nome-novo                            | execute

git branch -d nome_branch                               | exclui branch local se já fez push ou merge com branch remoto
git branch -D nome_branch                               | exclui o branch independente de seu status de push ou merge
git push origin :nome_do_branch_remoto                  | excluir um branch remoto


⭕ UTILIZANDO HASH

🔶 utilizando as hashs

git show _hash_                                         | copia a hash de log e inclui na frente de git show

🔶 revert

git log                                                 | busco o commit que desejo reverter
git revert _hash_


⭕ MERGE

git merge nome_branch_não_master                        | cria um novo commit somando a branch na master
git commit
git push
git log --graph


⭕ REBASE

git rebase nome_branch_não_master                       | não cria um novo comite, mas alinha a branch à frente da master


⭕ PESQUISA BINÁRIA

🔶  Bisect
## localiza commit que esta gerando um bug ou inconsistência entre uma sequência de commits

git bisect start                                        | pequinsa binária
git bisect bad                                          | Marca commit atual como ruim
git bisect good vs-1.1                                  | marca commit de uma tag que esta sem bug/inconsistência
git bisect good                                         | marca o commit como bom
git bisect bad                                          | marca o commit como ruim
git bisect reset                                        | após correção retornar para HEAD


⭕ PROCEDIMENTO NOTEBOOK | GITBASH | LINUX

[botão direito] 
Git BASH 
[abre console]


⭕ EXCLUIR O .DS_Store do main do Git
  ⚠️ ao sincronizar o diretório da máquina com o GitHub
     o arquivo pode entrar no circuíto de sincronização.

     Para evitar, informamos ao Git para não considerá-lo
     porém, não deletar o arquivo, pois o Mac precisa dele.

🔶 remoção forçada (-f)

git rm -f --cached .DS_Store
git status

git add .
git commit -m "Faxina: removendo .DS_Store à força do rastreamento"
git push origin main

---
Ao usar o --cached e ter o .DS_Store no seu .gitignore, você criou o cenário ideal:
No seu Mac: O arquivo existe e o sistema funciona como deveria.
No Git/GitHub: O arquivo não existe mais e o Git foi instruído a "fingir que não o vê", ignorando qualquer alteração futura nele.



⭕⭕⭕

🔶 SITES

https://github.com/fernandomayer/git-rautu/blob/master/1_comandos-basicos.md
https://rogerdudler.github.io/git-guide/index.pt_BR.html
https://gist.github.com/leocomelli/2545add34e4fec21ec16

- Site para Markdown
https://dillinger.io/  

- Modelos para Markdown
https://shields.io/

- Aplicativo para Markdown
https://typora.io/

- Emojis [só copiar que é o próprio código]
https://getemoji.com/

🔶 artigos e referências

Google Fire
https://github.com/google/python-fire

https://medium.com/vtex-lab/por-que-voc%C3%AA-deveria-usar-git-rebase-d75b41e900f2
Por que você deveria usar git rebase
Uma receita para resolver conflitos e ser mais feliz

https://devcontent.com.br/artigos/git-e-github/guia-de-comandos
Comandos diversos

https://gist.github.com/leocomelli/2545add34e4fec21ec16
Comandos e conflitos

## end
