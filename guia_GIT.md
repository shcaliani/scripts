# 🐙 Git — Guia Completo de Comandos

> Referência completa de comandos Git: configuração, versionamento, branches, merge, rebase e muito mais. Atualizado e expandido.

---

## 📋 Índice

- [Configuração Inicial](#-configuração-inicial)
- [Ciclo de Vida dos Arquivos](#-ciclo-de-vida-dos-arquivos)
- [Criando um Repositório](#-criando-um-repositório)
- [Status, Diff e Log](#-status-diff-e-log)
- [Adicionando e Commitando](#-adicionando-e-commitando)
- [Desfazendo Alterações](#-desfazendo-alterações)
- [Stash — Trabalho em Progresso](#-stash--trabalho-em-progresso)
- [Branches](#-branches)
- [Merge e Rebase](#-merge-e-rebase)
- [Tags e Versões](#-tags-e-versões)
- [Repositório Remoto](#-repositório-remoto)
- [Fluxos Completos](#-fluxos-completos)
- [Alias — Atalhos Personalizados](#-alias--atalhos-personalizados)
- [Hash e Revert](#-hash-e-revert)
- [Bisect — Pesquisa Binária](#-bisect--pesquisa-binária)
- [Arquivo .gitignore](#-arquivo-gitignore)
- [Removendo .DS_Store do Rastreamento](#-removendo-ds_store-do-rastreamento)
- [Comandos Úteis Extras](#-comandos-úteis-extras)
- [Fontes e Referências](#-fontes-e-referências)

---

## ⚙️ Configuração Inicial

Configure sua identidade antes de usar o Git. Essas informações aparecem em todos os commits.

```bash
# Definir nome e e-mail global
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"

# Verificar uma configuração específica
git config user.name

# Listar todas as configurações ativas
git config --list

# Definir editor padrão (ex: VS Code)
git config --global core.editor "code --wait"

# Definir arquivo global de itens ignorados
git config --global core.excludesfile ~/.gitignore

# Ativar cores no terminal
git config --global color.ui auto

# Configurar o comportamento padrão do push (recomendado)
git config --global push.default current
```

---

## 🔄 Ciclo de Vida dos Arquivos

Todo arquivo em um repositório Git passa pelos seguintes estados:

| Estado | Descrição |
|---|---|
| **Untracked** | Arquivo novo, ainda não visto pelo Git |
| **Unmodified** | Arquivo rastreado, sem alterações desde o último commit |
| **Modified** | Arquivo rastreado que foi alterado |
| **Staged** | Arquivo preparado para entrar no próximo commit |

```
Untracked → [git add] → Staged → [git commit] → Unmodified
Unmodified → [editar] → Modified → [git add] → Staged
```

---

## 📁 Criando um Repositório

### Novo repositório local

```bash
mkdir nome-do-projeto
cd nome-do-projeto
git init                        # inicializa o repositório Git
```

### Clonar repositório existente

```bash
git clone https://github.com/usuario/repositorio.git
git clone https://github.com/usuario/repositorio.git nome-pasta-local
git clone git@github.com:usuario/repositorio.git     # via SSH
```

---

## 🔍 Status, Diff e Log

### Status

```bash
git status                      # resumo do estado atual
git status -s                   # versão compacta (short)
```

### Diff — ver alterações

```bash
git diff                        # alterações ainda não staged
git diff --staged               # alterações que estão em staged (prontas para commit)
git diff --name-only            # apenas nomes dos arquivos alterados
git diff master                 # diferença da branch atual para a master
git diff origin/master          # diferença com o repositório remoto
git diff HEAD~1                 # diferença em relação ao commit anterior
git diff hash1 hash2            # diferença entre dois commits específicos
```

### Log — histórico de commits

```bash
git log                         # histórico completo
git log --oneline               # histórico resumido (uma linha por commit)
git log --oneline --graph       # histórico em forma de grafo
git log --graph --all           # grafo de todas as branches
git log -p -2                   # diff das duas últimas alterações
git log --stat                  # estatísticas de arquivos alterados por commit
git log --author="Nome"         # filtra por autor
git log --since="2 weeks ago"   # commits das últimas 2 semanas
git log --until="2024-01-01"    # commits até uma data
git log --grep="palavra"        # busca por palavra no commit message
git log --diff-filter=M -- path # commits que modificaram um arquivo específico
git log --follow arquivo.txt    # histórico de um arquivo, incluindo renomeações

git shortlog                    # commits agrupados por autor
git shortlog -sn                # quantidade de commits por autor

# Formato personalizado
git log --pretty=format:"%h | %an | %ar | %s"
# %h = hash abreviada | %an = autor | %ar = data relativa | %s = mensagem
```

---

## ✅ Adicionando e Commitando

```bash
# Adicionar arquivos ao staged
git add nome-arquivo.ext        # arquivo específico
git add .                       # todos os arquivos novos e modificados
git add --all                   # todos, incluindo deletados
git add -p                      # adiciona interativamente (hunk a hunk)

# Commitar
git commit -m "mensagem clara e objetiva"
git commit -am "mensagem"       # add + commit (apenas arquivos já rastreados)
git commit --amend -m "nova mensagem"  # corrige o último commit (não usar após push)
git commit --amend --no-edit    # adiciona mudanças ao último commit sem alterar a mensagem
git push                        # atualiza

# Remover arquivos
git rm arquivo.txt              # remove do disco e do rastreamento
git rm --cached arquivo.txt     # remove apenas do rastreamento (mantém no disco)
git rm -r diretorio/            # remove diretório recursivamente
```

---

## ↩️ Desfazendo Alterações

### Antes do staged

```bash
git restore arquivo.txt         # descarta alterações no arquivo (novo padrão)
git checkout -- arquivo.txt     # forma antiga (mesmo efeito)
```

### Depois do staged (antes do commit)

```bash
git restore --staged arquivo.txt   # retira do staged, mantém as alterações
git reset HEAD arquivo.txt         # forma antiga (mesmo efeito)
```

### Depois do commit

```bash
# Reset — reescreve o histórico (cuidado com commits já publicados)
git reset --soft  <hash>        # desfaz o commit, mantém em staged
git reset --mixed <hash>        # desfaz o commit, volta ao working directory (padrão)
git reset --hard  <hash>        # desfaz o commit e descarta todas as alterações

# Revert — cria um novo commit desfazendo as alterações (seguro para uso público)
git revert <hash>               # reverte um commit específico
git revert HEAD                 # reverte o último commit
git revert HEAD~3..HEAD         # reverte os últimos 3 commits

# Recuperar arquivo deletado
git checkout <hash> -- arquivo.txt

# Voltar o repositório para um estado específico sem perder o histórico
git checkout <hash>             # modo "detached HEAD"
```

> ⚠️ Nunca use `git reset --hard` em commits que já foram publicados no repositório remoto.

---

## 📦 Stash — Trabalho em Progresso

O stash salva temporariamente alterações não commitadas sem precisar fazer um commit.

```bash
git stash                       # salva o estado atual (working + staged)
git stash push -m "descrição"   # salva com uma descrição
git stash list                  # lista todos os stashes salvos
git stash apply                 # aplica o stash mais recente (mantém na lista)
git stash pop                   # aplica o stash mais recente e remove da lista
git stash apply stash@{2}       # aplica um stash específico
git stash drop stash@{0}        # remove um stash específico
git stash clear                 # remove todos os stashes
git stash show -p               # exibe o diff do stash mais recente
git stash branch nome-branch    # cria uma branch a partir do stash
```

---

## 🌿 Branches

```bash
# Listar branches
git branch                      # branches locais
git branch -r                   # branches remotas
git branch -a                   # todas (locais + remotas)
git branch -v                   # com o último commit de cada

# Criar branch
git branch nome-branch          # cria sem mudar
git checkout -b nome-branch     # cria e já muda para ela
git switch -c nome-branch       # forma moderna (Git 2.23+)

# Mudar de branch
git checkout nome-branch
git switch nome-branch          # forma moderna

# Renomear branch
git branch -m nome-novo                         # renomeia a branch atual
git branch -m nome-antigo nome-novo             # renomeia de outra branch
git push origin :nome-antigo nome-novo          # remove o remoto antigo e sobe o novo
git push origin -u nome-novo                    # atualiza o upstream

# Excluir branch
git branch -d nome-branch       # exclui se já fez merge
git branch -D nome-branch       # força exclusão independente do merge
git push origin --delete nome-branch  # exclui branch remota
git push origin :nome-branch    # forma alternativa para excluir remota

# Definir upstream (rastreamento remoto)
git branch --set-upstream-to=origin/nome-branch
git push -u origin nome-branch  # sobe e define upstream ao mesmo tempo
```

---

## 🔀 Merge e Rebase

### Merge — une branches criando um commit de merge

```bash
git checkout main
git merge nome-branch           # une a branch na main com commit de merge
git merge --no-ff nome-branch   # força commit de merge mesmo em fast-forward
git merge --squash nome-branch  # comprime todos os commits da branch em um só

# Em caso de conflito
git status                      # mostra arquivos em conflito
# (edite os arquivos resolvendo os conflitos)
git add .
git commit                      # finaliza o merge
git merge --abort               # cancela o merge em andamento
```

### Rebase — realinha commits sem criar commit de merge

```bash
git checkout minha-feature
git rebase main                 # move os commits da feature para depois do topo da main
git rebase --interactive HEAD~3 # rebase interativo dos últimos 3 commits (squash, edit, drop...)
git rebase --abort              # cancela o rebase
git rebase --continue           # continua após resolver conflito
```

> **Merge vs Rebase:**
> - `merge` preserva o histórico exato, bom para branches compartilhadas
> - `rebase` deixa o histórico linear, bom para branches locais antes de fazer PR

---

## 🏷️ Tags e Versões

```bash
# Criar tag
git tag v1.0.0                              # tag leve
git tag -a v1.0.0 -m "Versão 1.0.0"        # tag anotada (recomendada)
git tag -a v1.0.0 <hash> -m "mensagem"     # tag em commit específico

# Listar e inspecionar
git tag                                     # lista todas as tags
git tag -l "v1.*"                           # filtra tags por padrão
git show v1.0.0                             # detalhes da tag

# Publicar tags
git push origin v1.0.0                     # sobe uma tag específica
git push origin --tags                     # sobe todas as tags

# Excluir tags
git tag -d v1.0.1                          # exclui localmente
git push origin --delete v1.0.1            # exclui no remoto
git push origin :v1.0.0                    # forma alternativa para remoto
```

---

## ☁️ Repositório Remoto

```bash
# Conectar ao remoto
git remote add origin https://github.com/usuario/repo.git
git remote add origin git@github.com:usuario/repo.git   # via SSH

# Ver remotos
git remote                      # lista os remotos
git remote -v                   # com URLs de fetch e push
git remote show origin          # detalhes completos do remoto

# Alterar URL do remoto
git remote set-url origin nova-url

# Remover remoto
git remote remove origin

# Buscar e baixar
git fetch origin                # baixa as mudanças sem aplicar
git fetch --all                 # busca todos os remotos
git pull                        # fetch + merge da branch atual
git pull --rebase               # fetch + rebase (histórico mais limpo)

# Subir alterações
git push                        # sobe a branch atual para o upstream
git push origin nome-branch     # sobe branch específica
git push -u origin nome-branch  # sobe e define o upstream
git push --force-with-lease     # força push com segurança (verifica se não há novos commits remotos)
git push origin --tags          # sobe todas as tags
```

---

## 🚀 Fluxos Completos

### Inicializando novo projeto e subindo para o GitHub

```bash
# 1. Crie o repositório no GitHub (via browser)

# 2. No terminal, dentro da pasta do projeto:
git init
git add .
git commit -m "primeiro commit"
git branch -M main
git remote add origin https://github.com/usuario/repo.git
git push -u origin main
```

### Subindo atualizações do dia a dia

```bash
git add --all
git commit -m "descrição do que foi feito"
git push
```

### Tudo em uma linha

```bash
git add --all && git commit -m "mensagem" && git push
```

### Subindo apenas um arquivo

```bash
git add nome-arquivo.ext
git commit -m "mensagem"
git push
```

### Fluxo com feature branch

```bash
git checkout -b feature/nova-funcionalidade   # cria branch da feature
# (desenvolve e faz commits)
git checkout main
git pull                                       # garante que a main está atualizada
git merge feature/nova-funcionalidade          # une a feature
git push
git branch -d feature/nova-funcionalidade      # limpa branch local
git push origin --delete feature/nova-funcionalidade  # limpa branch remota
```

---

## 🔧 Alias — Atalhos Personalizados

```bash
# Criando aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm "commit -m"
git config --global alias.lg "log --oneline --graph --all"
git config --global alias.undo "reset HEAD~1 --mixed"
git config --global alias.last "log -1 HEAD"

# Usando
git st                          # equivale a git status
git co nome-branch              # equivale a git checkout nome-branch
git lg                          # log compacto com grafo
git undo                        # desfaz o último commit mantendo as alterações
git last                        # exibe o último commit
```

---

## 🔎 Hash e Revert

```bash
# Inspecionar um commit pelo hash
git show <hash>                 # exibe detalhes e diff do commit
git show <hash>:arquivo.txt     # exibe o estado do arquivo naquele commit

# Copiar um commit de outra branch (cherry-pick)
git cherry-pick <hash>          # aplica um commit específico na branch atual
git cherry-pick <hash1>..<hash2> # aplica um range de commits

# Revert — desfaz com segurança (cria novo commit)
git log                         # encontra o hash do commit a reverter
git revert <hash>               # reverte o commit específico
git revert HEAD                 # reverte o último commit
```

---

## 🔬 Bisect — Pesquisa Binária de Bugs

Localiza qual commit introduziu um bug usando busca binária no histórico.

```bash
git bisect start                # inicia a pesquisa
git bisect bad                  # marca o commit atual como ruim (com bug)
git bisect good v1.1            # marca um commit/tag conhecido como bom (sem bug)

# Git vai navegando automaticamente — a cada passo você informa:
git bisect good                 # o commit atual não tem o bug
git bisect bad                  # o commit atual tem o bug

# Git identifica o commit culpado
git bisect reset                # volta ao HEAD após encontrar o problema
```

---

## 🚫 Arquivo .gitignore

O `.gitignore` diz ao Git quais arquivos e pastas devem ser ignorados.

```bash
# Adicionar entradas via terminal
echo ".DS_Store" >> .gitignore
echo ".env" >> .gitignore
echo "node_modules/" >> .gitignore
echo "*.log" >> .gitignore

# Ver o que está sendo ignorado
git status --ignored
git check-ignore -v arquivo.txt  # verifica por que um arquivo está sendo ignorado
```

**Exemplo de `.gitignore` para projetos Node.js / Python:**

```gitignore
# Dependências
node_modules/
.venv/
__pycache__/

# Variáveis de ambiente
.env
.env.local
.env.*.local

# Build
dist/
build/
*.egg-info/

# Logs
*.log
logs/

# Sistema operacional
.DS_Store
Thumbs.db

# IDEs
.vscode/
.idea/
*.swp

# Testes
coverage/
.pytest_cache/
```

> Modelos prontos de `.gitignore` para diversas linguagens: [gitignore.io](https://www.toptal.com/developers/gitignore)

---

## 🍎 Removendo .DS_Store do Rastreamento

O macOS gera `.DS_Store` automaticamente. Se ele entrou no repositório, remova assim:

```bash
# Remove do rastreamento do Git (sem deletar do disco)
git rm -f --cached .DS_Store
git rm -f --cached -r .          # remove todos os .DS_Store recursivamente

# Commitando a remoção
git add .
git commit -m "Faxina: removendo .DS_Store do rastreamento"
git push origin main

# Prevenindo que entre novamente (adicione ao .gitignore)
echo ".DS_Store" >> .gitignore
git add .gitignore
git commit -m "Ignorando .DS_Store"
git push
```

> Após usar `--cached` com o `.DS_Store` no `.gitignore`, você tem o cenário ideal:
> - **No seu Mac:** o arquivo existe e o sistema funciona normalmente
> - **No Git/GitHub:** o arquivo não existe e será ignorado para sempre

---

## 🛠️ Comandos Úteis Extras

### Inspecionar e navegar

```bash
git blame arquivo.txt           # mostra quem alterou cada linha e quando
git grep "palavra"              # busca uma string em todos os arquivos rastreados
git ls-files                    # lista todos os arquivos rastreados

# Salvar o patch de um commit para enviar por e-mail
git format-patch HEAD~1
git am < 0001-commit.patch      # aplica um patch recebido
```

### Limpeza

```bash
git clean -n                    # simula o que seria removido
git clean -f                    # remove arquivos não rastreados
git clean -fd                   # remove arquivos e diretórios não rastreados
git gc                          # coleta lixo e compacta o repositório
git prune                       # remove objetos órfãos
```

### Worktrees — múltiplas branches ao mesmo tempo

```bash
git worktree add ../hotfix hotfix/urgente   # abre outra branch em outra pasta
git worktree list
git worktree remove ../hotfix
```

### Reflog — histórico de tudo, incluindo resets

```bash
git reflog                      # histórico completo de operações (salva por 90 dias)
git checkout HEAD@{3}           # restaura para o estado de 3 operações atrás
```

---

## 📚 Fontes e Referências

### Documentação oficial

| Recurso | Link |
|---|---|
| Documentação oficial Git | [git-scm.com/doc](https://git-scm.com/doc) |
| Pro Git (livro gratuito) | [git-scm.com/book](https://git-scm.com/book/pt-br/v2) |
| Referência de comandos | [git-scm.com/docs](https://git-scm.com/docs) |

### Guias práticos

| Recurso | Link |
|---|---|
| Git Guide (Roger Dudler) | [rogerdudler.github.io/git-guide/index.pt_BR.html](https://rogerdudler.github.io/git-guide/index.pt_BR.html) |
| Comandos básicos | [github.com/fernandomayer/git-rautu](https://github.com/fernandomayer/git-rautu/blob/master/1_comandos-basicos.md) |
| Comandos e conflitos (leocomelli) | [gist.github.com/leocomelli/2545add34e4fec21ec16](https://gist.github.com/leocomelli/2545add34e4fec21ec16) |
| Guia de comandos diversos | [devcontent.com.br/artigos/git-e-github](https://devcontent.com.br/artigos/git-e-github/guia-de-comandos) |
| Por que usar git rebase | [medium.com/vtex-lab](https://medium.com/vtex-lab/por-que-voc%C3%AA-deveria-usar-git-rebase-d75b41e900f2) |
| Gerador de .gitignore | [gitignore.io](https://www.toptal.com/developers/gitignore) |

### Ferramentas para Markdown

| Ferramenta | Link |
|---|---|
| Editor online | [dillinger.io](https://dillinger.io) |
| Badges e shields | [shields.io](https://shields.io) |
| App desktop | [typora.io](https://typora.io) |
| Emojis | [getemoji.com](https://getemoji.com) |

---

## ⌨️ Referência Rápida

```bash
# Os comandos que você vai usar 90% do tempo
git status                      # o que mudou?
git add .                       # prepara tudo
git commit -m "mensagem"        # salva o estado
git push                        # sobe para o remoto
git pull                        # atualiza do remoto
git log --oneline               # histórico resumido
git checkout -b nova-branch     # nova branch
git merge outra-branch          # une branches
git stash / git stash pop       # guarda / recupera trabalho em progresso
```

---

*Mantido com ❤️ — contribuições são bem-vindas via PR.*
