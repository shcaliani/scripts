# 🤖 Claude Code — Guia de Comandos

> Referência completa dos principais comandos do Claude Code, conceitos essenciais, @-mentions e dicas de uso. Atualizado para 2026.

---

## 📋 Índice

- [Quando Usar Cada Recurso do Claude](#-quando-usar-cada-recurso-do-claude)
- [Conceitos Essenciais](#-conceitos-essenciais)
  - [Context (Contexto)](#context-contexto)
  - [CLAUDE.md — Memória do Projeto](#claudemd--memória-do-projeto)
  - [Skills — Habilidades Especializadas](#skills--habilidades-especializadas)
  - [MCPs — Model Context Protocol](#mcps--model-context-protocol)
- [Onde Instalar o Claude Code](#-onde-instalar-o-claude-code)
- [Claude Dispatch — Controle pelo Celular](#-claude-dispatch--controle-pelo-celular)
- [Comandos de Sessão](#-comandos-de-sessão)
- [Configuração](#-configuração)
- [Memória e Contexto](#-memória-e-contexto)
- [Trabalho e Workflows](#-trabalho-e-workflows)
- [@-Mentions](#-mentions)
- [Atalhos de Teclado](#-atalhos-de-teclado)
- [CLI — Flags úteis](#-cli--flags-úteis)
- [Comandos Personalizados](#-comandos-personalizados)
- [Dicas Rápidas](#-dicas-rápidas)
- [Fontes Confiáveis](#-fontes-confiáveis)

---

## 🧩 Conceitos Essenciais

### Context (Contexto)

O **contexto** é tudo que o Claude Code carrega na memória durante uma sessão: o histórico da conversa, os arquivos referenciados via `@-mentions`, o conteúdo do `CLAUDE.md`, as skills ativas e os resultados de ferramentas executadas.

**Por que isso importa:**
- O Claude Code tem um limite de tokens por sessão (janela de contexto). Quando o contexto fica muito longo, o agente começa a "esquecer" partes anteriores da conversa.
- Use `/compact` para compressar o histórico e liberar espaço sem perder o essencial.
- Use `/cost` para monitorar o quanto do contexto já foi consumido.

**Regra prática:** contexto menor = respostas mais precisas e menos custosas. Não adicione arquivos desnecessários ao contexto.

---

### CLAUDE.md — Memória do Projeto

O `CLAUDE.md` é um arquivo Markdown que funciona como **memória persistente do projeto**. O Claude Code o lê automaticamente ao iniciar uma sessão na pasta onde ele está localizado.

**Para que serve:**
- Definir o contexto do projeto (tecnologias, arquitetura, objetivos)
- Estabelecer padrões de código que o agente deve seguir
- Listar comandos frequentes do projeto (`npm run dev`, `make build`, etc.)
- Registrar decisões de arquitetura e convenções da equipe

**Onde ficam localizados:**

| Arquivo | Localização | Escopo |
|---|---|---|
| Memória global | `~/.claude/CLAUDE.md` | Aplicado em todos os projetos |
| Memória do projeto | `./CLAUDE.md` (raiz do repo) | Aplicado apenas neste projeto |
| Memória de subpasta | `./src/CLAUDE.md` | Aplicado quando Claude acessa esta pasta |

> O Claude lê todos os `CLAUDE.md` relevantes na hierarquia de diretórios, do global ao mais específico.

**Exemplo de `CLAUDE.md`:**

```markdown
# Contexto do projeto
Aplicação de e-commerce em Next.js com banco PostgreSQL.
API REST no backend (Node.js + Express). Deploy na Vercel.

# Padrões de código
- TypeScript estrito em todo o projeto
- Componentes funcionais com hooks (sem classes)
- Testes com Jest + Testing Library
- Commits no padrão Conventional Commits

# Comandos úteis
- `npm run dev` — inicia o servidor local
- `npm test` — roda os testes
- `npm run lint` — verifica o código

# Decisões de arquitetura
- Autenticação via JWT com refresh token
- Cache com Redis para sessões de usuário
- Uploads de imagem via AWS S3
```

**Como criar:**

```bash
# Gerar automaticamente via Claude Code
/init

# Ou criar manualmente
touch CLAUDE.md
```

---

### Skills — Habilidades Especializadas

**Skills** são pacotes de instruções que ensinam o Claude Code a executar tarefas específicas de forma confiável e padronizada. Cada skill é uma pasta contendo um arquivo `SKILL.md` (com instruções em YAML + Markdown) e, opcionalmente, scripts de suporte.

**Para que servem:**
- Padronizar tarefas complexas (ex: criar um `.docx`, gerar uma planilha Excel formatada, produzir um PDF)
- Encapsular conhecimento especializado (ex: auditoria de segurança, geração de testes, design de componentes)
- Garantir que o agente siga sempre o mesmo processo, independente de como a tarefa é pedida

**Como funcionam:**
O Claude escaneia as skills disponíveis no início de cada sessão, carregando apenas ~100 tokens por skill (metadados). Quando uma tarefa relevante é solicitada, a skill completa é carregada automaticamente — sem que você precise invocá-la manualmente.

**Onde ficam localizadas:**

| Localização | Escopo |
|---|---|
| `~/.claude/skills/` | Skills globais (todos os projetos) |
| `./.claude/skills/` | Skills do projeto atual |
| Repositório oficial da Anthropic | Skills pré-construídas e mantidas pela equipe |

**Como instalar skills:**

```bash
# Instalar skills oficiais via plugin marketplace
/plugin install document-skills@anthropic-agent-skills

# Ou clonar o repositório oficial e copiar as skills
git clone https://github.com/anthropics/skills
cp -r skills/public/pdf ~/.claude/skills/
```

**Como criar uma skill personalizada:**

```bash
mkdir -p ~/.claude/skills/minha-skill
cat > ~/.claude/skills/minha-skill/SKILL.md << 'EOF'
---
name: minha-skill
description: Gera um relatório de análise de dados em formato padronizado
---

# Instruções
Ao gerar um relatório de análise:
1. Carregue os dados do arquivo indicado
2. Calcule as métricas principais (média, mediana, desvio padrão)
3. Identifique outliers e anomalias
4. Gere um resumo executivo em português
5. Salve o resultado como `relatorio_YYYY-MM-DD.md`
EOF
```

**Repositórios de Skills:**

- 🔗 [github.com/anthropics/skills](https://github.com/anthropics/skills) — Skills oficiais da Anthropic
- 🔗 [github.com/hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) — Coleção da comunidade
- 🔗 [github.com/travisvn/awesome-claude-skills](https://github.com/travisvn/awesome-claude-skills) — Lista curada de skills

---

### MCPs — Model Context Protocol

**MCPs (Model Context Protocol)** são servidores que funcionam como "pontes" entre o Claude Code e sistemas externos. Eles permitem que o agente acesse, leia e interaja com ferramentas, APIs e bancos de dados fora do seu ambiente local.

**Para que servem:**
- Conectar o Claude a serviços externos (Gmail, Google Drive, Calendário, Slack, Notion, GitHub, etc.)
- Dar ao agente acesso a bancos de dados, APIs internas e sistemas legados
- Estender as capacidades do Claude sem precisar escrever código de integração do zero

**Como adicionar um MCP:**

```bash
# Adicionar um servidor MCP via linha de comando
claude mcp add <nome> <comando-do-servidor>

# Exemplo: adicionar o MCP do GitHub
claude mcp add github npx @modelcontextprotocol/server-github

# Ver MCPs conectados
/mcp

# Gerenciar MCPs dentro de uma sessão
/mcp list
/mcp remove <nome>
```

**Configuração via arquivo (`~/.claude/settings.json`):**

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "seu-token-aqui"
      }
    },
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "/home/usuario"]
    }
  }
}
```

**Repositório oficial de MCPs:**
- 🔗 [github.com/modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers) — Servidores MCP oficiais
- 🔗 [modelcontextprotocol.io](https://modelcontextprotocol.io) — Documentação do protocolo

---

## 💻 Onde Instalar o Claude Code

O Claude Code está disponível em múltiplas plataformas. Todas compartilham o mesmo motor, os mesmos modelos e as mesmas skills.

### Terminal (macOS / Linux / WSL)

A forma primária e mais completa de usar o Claude Code.

```bash
# Instalação via script oficial
curl -fsSL https://claude.ai/install.sh | sh

# Ou via npm
npm install -g @anthropic-ai/claude-code

# Verificar instalação
claude --version

# Iniciar
cd meu-projeto
claude
```

### VS Code (Extensão oficial)

Integração nativa com painel lateral, diff inline e leitura automática de erros do editor.

1. Abra o VS Code
2. Pressione `Cmd+Shift+X` (Mac) ou `Ctrl+Shift+X` (Windows/Linux)
3. Busque por **"Claude Code"** (publicado pela Anthropic)
4. Clique em **Install**
5. O Claude Code detecta automaticamente o projeto aberto

🔗 [marketplace.visualstudio.com](https://marketplace.visualstudio.com/items?itemName=anthropic.claude-code)

### JetBrains (Plugin Beta)

Funciona em IntelliJ IDEA, PyCharm, WebStorm, GoLand, Android Studio e outros.

1. Abra sua IDE JetBrains
2. Vá em **Settings → Plugins → Marketplace**
3. Busque por **"Claude Code [Beta]"** (publicado pela Anthropic PBC)
4. Clique em **Install** e reinicie a IDE
5. Abra o terminal integrado e rode `claude`

🔗 [plugins.jetbrains.com](https://plugins.jetbrains.com/plugin/claude-code)

### Claude in Chrome (Extensão)

Permite que o Claude Code interaja com o navegador durante o desenvolvimento — acessa abas abertas, lê o console, executa testes visuais e navega por páginas.

```bash
# Após instalar a extensão, referencie o browser no Claude Code
@browser acesse localhost:3000 e verifique os erros no console
```

1. Instale a extensão **Claude in Chrome** (versão 1.0.36+) na Chrome Web Store
2. No Claude Code (terminal ou VS Code), use `@browser` para acionar o navegador

🔗 [chromewebstore.google.com](https://chromewebstore.google.com) — busque por "Claude for Chrome"

### Aplicativo Desktop (macOS / Windows)

O Claude Desktop é a interface gráfica para uso geral do Claude, incluindo o modo **Cowork** para automação de tarefas no computador.

🔗 [claude.ai/download](https://claude.ai/download)

---

## 📱 Claude Dispatch — Controle pelo Celular

O **Dispatch** é o recurso que permite enviar tarefas para o Claude Code a partir do celular. Você manda uma mensagem pelo app do Claude (iOS ou Android) e o agente executa a tarefa no seu computador — abrindo arquivos, rodando código, navegando na web e atualizando projetos enquanto você está longe da máquina.

**Como funciona:**
1. Instale o app **Claude** no celular (iOS ou Android)
2. No computador, inicie uma sessão do Claude Code com Remote Control ativo
3. No app do celular, abra o Claude e envie a tarefa desejada
4. O Claude Code recebe a mensagem, executa no seu computador local e te responde

**Exemplo de uso:**
```
[No celular, pelo app do Claude]
"Refatore o módulo de autenticação para usar JWT e rode os testes.
Me avise quando terminar."

→ O Claude Code executa tudo no computador e envia o resultado de volta para o app.
```

**Canais suportados:**
Além do app, o Dispatch também aceita tarefas via **Telegram**, **Discord** e **iMessage**, encaminhando mensagens diretamente para a sessão ativa do Claude Code.

**Instalação do app:**

| Plataforma | Link |
|---|---|
| iOS (iPhone / iPad) | [anthropic.com/ios](https://anthropic.com/ios) — App Store |
| Android | [anthropic.com/android](https://anthropic.com/android) — Google Play |

> Disponível em research preview para planos **Pro** e **Max**.

---

## 🗺️ Quando Usar Cada Recurso do Claude

O ecossistema Claude tem múltiplas superfícies de trabalho. Escolher a certa faz toda a diferença no resultado. A regra geral é simples:

> **Chat** → você conversa. **Projeto** → você organiza. **Cowork** → você delega. **Code** → você desenvolve. **Design** → você visualiza.

---

### 💬 Chat (claude.ai)

**O que é:** A conversa direta com o Claude, sem contexto persistente entre sessões. Cada nova conversa começa do zero.

**Use quando:**
- Precisa de uma resposta rápida ou análise pontual
- Quer rascunhar um texto, e-mail ou ideia
- Está explorando um tema e ainda não sabe o que quer
- Precisa resumir, traduzir ou revisar algo específico
- A tarefa é isolada e não faz parte de um projeto maior

**Não use quando:** a tarefa exige contexto acumulado de conversas anteriores ou envolve múltiplos arquivos do seu computador.

**Analogia:** Claude como parceiro de conversa. Você é o gerente, ele é o assistente.

---

### 📁 Projeto (Projects)

**O que é:** Um espaço de trabalho persistente dentro do Claude.ai que agrupa conversas relacionadas, mantém arquivos de referência, instruções personalizadas e memória contínua sobre aquele contexto.

**Use quando:**
- Trabalha em algo recorrente (cliente fixo, produto em andamento, pesquisa de longo prazo)
- Precisa que o Claude já saiba quem você é e qual é o contexto toda vez que abre uma conversa
- Quer organizar múltiplas conversas sob o mesmo tema
- Está colaborando em equipe e todos precisam do mesmo contexto base

**Não use quando:** a tarefa é pontual e não precisa de contexto acumulado.

**Analogia:** Uma pasta de trabalho com instruções fixas na capa — o Claude sempre lê antes de começar.

---

### 🖥️ Cowork (Claude Desktop)

**O que é:** Modo de automação de desktop disponível no app Claude para Mac e Windows. O Claude age diretamente no seu computador — abre arquivos, organiza pastas, preenche planilhas, lê documentos locais e executa tarefas enquanto você faz outra coisa.

**Use quando:**
- Quer delegar uma tarefa completa, não apenas uma resposta
- A tarefa envolve arquivos reais no seu computador (PDFs, planilhas, pastas)
- Precisa de um resultado concreto (ex: "organize esses 50 PDFs por data e gere um resumo de cada um")
- Quer trabalhar em segundo plano enquanto o Claude executa

**Não use quando:** só precisa de uma resposta rápida ou análise de texto — o Chat é mais ágil.

**Analogia:** Você é o cliente, o Claude é a equipe inteira. Você descreve o entregável e vai viver sua vida.

---

### 💻 Claude Code

**O que é:** Agente de desenvolvimento que roda no terminal (ou no VS Code / JetBrains). Tem acesso total ao repositório, escreve código, roda testes, faz commits e abre PRs de forma autônoma.

**Use quando:**
- Está desenvolvendo software e quer um agente que entende o codebase completo
- Precisa refatorar, depurar, gerar testes ou implementar features
- Quer automatizar fluxos de desenvolvimento (revisão → commit → PR)
- A tarefa exige leitura e escrita em múltiplos arquivos do repositório

**Não use quando:** a tarefa não é de desenvolvimento — use Chat ou Cowork para tarefas gerais.

**Analogia:** Um dev sênior que conhece todo o seu repositório e trabalha autonomamente no terminal.

---

### 🎨 Claude Design *(research preview)*

**O que é:** Produto experimental do Anthropic Labs lançado em abril de 2026. Oferece um canvas visual onde você descreve o que quer e o Claude gera protótipos interativos, slides, wireframes, landing pages e materiais de marketing — com exportação para PDF, PPTX, HTML e Canva.

**Use quando:**
- Precisa prototipar uma interface ou tela rapidamente
- Quer criar uma apresentação, one-pager ou deck sem abrir o PowerPoint
- Está explorando direções visuais antes de enviar para um designer
- Quer gerar materiais de marketing (landing page, peças para redes sociais)
- Precisa de um wireframe para passar para o Claude Code implementar

**Não use quando:** o resultado final precisa ser código de produção — nesse caso, passe o protótipo do Design para o Claude Code.

**Analogia:** Um designer de exploração rápida que te entrega a primeira versão para refinar.

---

### 📊 Tabela de Decisão Rápida

| Situação | Recurso ideal |
|---|---|
| Tenho uma dúvida rápida ou quero um rascunho | **Chat** |
| Trabalho num projeto recorrente e quero contexto persistente | **Projeto** |
| Tenho arquivos no computador e quero delegar uma tarefa | **Cowork** |
| Quero desenvolver, refatorar ou depurar código | **Code** |
| Preciso criar um protótipo, slide ou visual | **Design** |
| Quero enviar uma tarefa pelo celular e deixar executando | **Dispatch + Cowork/Code** |
| Tenho uma tarefa técnica repetitiva que quero automatizar | **Skill personalizada** |
| Preciso conectar o Claude a um sistema externo (Gmail, Drive, etc.) | **MCP** |

---

### 🔀 Fluxos Combinados Recomendados

Os melhores resultados geralmente vêm da combinação de recursos:

```
Pesquisa e esboço     →  Chat
Contexto persistente  →  Projeto
Prototipagem visual   →  Design
Implementação         →  Code
Organização de arquivos →  Cowork
Controle pelo celular →  Dispatch
```

**Exemplo prático — lançamento de produto:**
1. **Chat** → brainstorming e definição do escopo
2. **Projeto** → centraliza briefing, referências e decisões
3. **Design** → cria wireframes e deck de apresentação
4. **Code** → implementa as telas com base nos wireframes
5. **Cowork** → organiza os arquivos gerados e prepara a documentação
6. **Dispatch** → você acompanha o progresso pelo celular

---

## 🔄 Comandos de Sessão

| Comando | Descrição |
|---|---|
| `/help` | Lista todos os comandos disponíveis na versão instalada |
| `/clear` | Limpa a tela e o contexto da conversa |
| `/compact` | Comprime o histórico para economizar tokens quando o contexto estiver longo |
| `/cost` | Mostra o uso de tokens e custo acumulado da sessão |
| `/exit` ou `/quit` | Encerra a sessão |
| `/resume` | Retoma uma sessão anterior |
| `/logout` | Faz logout da conta |
| `/login` | Faz login novamente |

---

## ⚙️ Configuração

| Comando | Descrição |
|---|---|
| `/config` | Abre o painel de configurações |
| `/model` | Troca o modelo no meio da sessão (`opus`, `sonnet`, `haiku`) |
| `/permissions` | Gerencia quais ferramentas o Claude pode usar sem pedir confirmação |
| `/mcp` | Lista, adiciona ou remove servidores MCP conectados |
| `/hooks` | Inspeciona e gerencia os hooks configurados |
| `/status` | Mostra informações da conta, modelo ativo e ambiente |
| `/theme` | Altera o tema de cores do terminal |
| `/fast` | Ativa o modo rápido (Sonnet com output mais veloz) |

---

## 🧠 Memória e Contexto

| Comando | Descrição |
|---|---|
| `/init` | Gera um arquivo `CLAUDE.md` para o repositório atual |
| `/memory` | Edita os arquivos de memória global e do projeto |
| `/add-dir <caminho>` | Concede ao agente acesso a uma pasta adicional |
| `#<texto>` | Adiciona um fato à memória de forma rápida, direto no prompt |

---

## 🛠️ Trabalho e Workflows

| Comando | Descrição |
|---|---|
| `/review` | Faz uma revisão de código da branch atual |
| `/security-review` | Roda uma auditoria de segurança nas mudanças pendentes |
| `/pr` | Gera uma pull request a partir do trabalho atual |
| `/commit` | Faz stage e commit com mensagem gerada automaticamente |
| `/todos` | Exibe a lista de tarefas que o agente está rastreando |
| `/bug` | Reporta um bug à Anthropic com o contexto da sessão |

---

## @ Mentions

Use @-mentions para referenciar arquivos, pastas e URLs diretamente no prompt, sem precisar copiar e colar o conteúdo.

| Sintaxe | Descrição |
|---|---|
| `@arquivo.py` | Inclui um arquivo específico no contexto |
| `@src/componentes/` | Inclui uma pasta inteira no contexto |
| `@https://exemplo.com` | Busca e inclui o conteúdo de uma URL |
| `@CLAUDE.md` | Referencia explicitamente o arquivo de memória do projeto |
| `@browser` | Aciona o Claude in Chrome para interagir com o navegador |

**Exemplos de uso:**

```
Refatore @src/auth/login.ts seguindo os padrões de @src/auth/register.ts

Baseado na documentação em @https://docs.meusite.com/api, crie um cliente HTTP

Revise @src/components/ e identifique componentes sem testes

@browser acesse localhost:3000 e verifique erros no console
```

---

## ⌨️ Atalhos de Teclado

| Atalho | Ação |
|---|---|
| `Enter` | Envia o prompt |
| `Shift+Enter` | Insere uma nova linha no prompt |
| `Ctrl+C` | Interrompe o Claude (para a resposta atual) |
| `Ctrl+C` (duas vezes) | Sai do Claude Code |
| `Ctrl+D` | Sai quando o prompt está vazio |
| `Ctrl+L` | Limpa a tela (mantém o histórico) |
| `Ctrl+R` | Busca reversa no histórico de prompts |
| `↑ / ↓` | Navega pelo histórico de prompts |
| `Tab` | Autocomplete de comandos, caminhos e @-mentions |
| `Esc` | Cancela o input atual |
| `Esc Esc` | Abre o histórico de prompts |

---

## 🖥️ CLI — Flags úteis

Use estas flags ao iniciar o Claude Code pelo terminal:

```bash
# Iniciar sessão interativa na pasta atual
claude

# Executar uma tarefa e sair (modo não-interativo)
claude "corrija o bug de login"

# Continuar a última sessão
claude -c

# Retomar uma sessão específica
claude -r <session-id>

# Escolher o modelo
claude --model opus
claude --model sonnet
claude --model haiku

# Modo não-interativo, imprime o resultado no stdout
claude --print "gere uma descrição de PR"

# Mostrar as chamadas de ferramentas em tempo real
claude --verbose

# Modo somente leitura (planejamento sem execução)
claude --permission-mode plan

# Liberar acesso a uma pasta adicional
claude --add-dir ../pasta-irmã

# Restringir as ferramentas disponíveis
claude --allowed-tools Bash,Read,Edit
```

**Piping funciona nos dois sentidos:**

```bash
cat erro.log | claude "o que está errado aqui?"
claude --print "gere uma descrição de PR" | gh pr create --body-file -
```

---

## 🧩 Comandos Personalizados

Crie seus próprios comandos adicionando arquivos Markdown em `~/.claude/commands/` (global) ou `.claude/commands/` (por projeto).

**Exemplo — criar o comando `/ship`:**

```bash
mkdir -p ~/.claude/commands
cat > ~/.claude/commands/ship.md << 'EOF'
Revise o diff atual. Rode os testes. Se os testes passarem,
faça commit com uma mensagem clara e envie para a main.
EOF
```

Agora `/ship` executa esse workflow completo sempre que você precisar.

**Outros exemplos:**

```markdown
# ~/.claude/commands/revisar-pr.md
Revise o código da branch atual focando em:
- Segurança e vulnerabilidades
- Performance e gargalos
- Cobertura de testes
- Clareza e manutenibilidade
Gere um relatório estruturado com prioridades.
```

```markdown
# ~/.claude/commands/doc.md
Gere documentação completa para o arquivo ou função indicada,
incluindo descrição, parâmetros, retorno e exemplos de uso.
```

---

## 💡 Dicas Rápidas

- Digite `/` dentro de qualquer sessão para ver o **autocomplete** com todos os comandos disponíveis — MCPs e plugins conectados adicionam novos comandos automaticamente.
- Use `/compact` antes de iniciar tarefas longas para liberar espaço de contexto.
- Use `#fato importante` para salvar decisões do projeto na memória sem interromper o fluxo.
- O `/init` deve ser o **primeiro comando** em qualquer projeto novo — ele cria o `CLAUDE.md` com o contexto do repositório.
- Use `/cost` regularmente para acompanhar o uso de tokens e evitar surpresas na fatura.
- Combine `/review` + `/pr` para um fluxo completo de revisão e abertura de PR sem sair do terminal.
- Skills e MCPs conectados adicionam novos slash commands — use `/mcp` e `/plugins` para ver o que está disponível.

---

## 🔗 Fontes Confiáveis

### Documentação Oficial Anthropic

| Recurso | Link |
|---|---|
| Documentação do Claude Code | [docs.anthropic.com/claude-code](https://docs.anthropic.com/en/docs/claude-code/overview) |
| Referência completa da CLI | [docs.anthropic.com/claude-code/cli](https://docs.anthropic.com/en/docs/claude-code/cli-reference) |
| Remote Control / Dispatch | [docs.anthropic.com/claude-code/remote-control](https://docs.anthropic.com/en/docs/claude-code/remote-control) |
| Notas de versão (releases) | [docs.anthropic.com/release-notes](https://docs.anthropic.com/en/release-notes/claude-apps) |
| Central de ajuda | [support.claude.com](https://support.claude.com) |
| Blog da Anthropic | [anthropic.com/news](https://www.anthropic.com/news) |

### Repositórios Oficiais GitHub

| Repositório | Descrição |
|---|---|
| [anthropics/claude-code](https://github.com/anthropics/claude-code) | Repositório principal do Claude Code |
| [anthropics/skills](https://github.com/anthropics/skills) | Skills oficiais pré-construídas |
| [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) | Plugins oficiais gerenciados pela Anthropic |
| [modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers) | Servidores MCP oficiais |

### Comunidade e Recursos Extras

| Recurso | Link |
|---|---|
| Model Context Protocol | [modelcontextprotocol.io](https://modelcontextprotocol.io) |
| Skills da comunidade | [github.com/hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) |
| Lista curada de Skills | [github.com/travisvn/awesome-claude-skills](https://github.com/travisvn/awesome-claude-skills) |
| Claude Directory (cheat sheets) | [claudedirectory.org](https://www.claudedirectory.org) |
| Subreddit r/ClaudeAI | [reddit.com/r/ClaudeAI](https://www.reddit.com/r/ClaudeAI) |

### Apps para Download

| Plataforma | Link |
|---|---|
| Claude Desktop (Mac / Windows) | [claude.ai/download](https://claude.ai/download) |
| Claude para iOS | [anthropic.com/ios](https://anthropic.com/ios) |
| Claude para Android | [anthropic.com/android](https://anthropic.com/android) |
| Claude in Chrome | [Chrome Web Store](https://chromewebstore.google.com) — busque "Claude for Chrome" |

---

*Mantido com ❤️ — contribuições são bem-vindas via PR.*
