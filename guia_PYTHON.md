# 🐍 Python — Guia de Referência e Ambiente

> Referência completa para configuração de ambiente Python, comandos essenciais, tipos de dados, bibliotecas recomendadas e fontes confiáveis.

---

## 📋 Índice

- [O que é o Python e como funciona](#-o-que-é-o-python-e-como-funciona)
- [Instalação](#-instalação)
- [Gerenciando versões com pyenv](#-gerenciando-versões-com-pyenv)
- [Ambiente virtual — venv](#-ambiente-virtual--venv)
- [pip — Gerenciador de pacotes](#-pip--gerenciador-de-pacotes)
- [Iniciando um projeto do zero](#-iniciando-um-projeto-do-zero)
- [Tipos de dados](#-tipos-de-dados)
- [Comandos e estruturas essenciais](#-comandos-e-estruturas-essenciais)
- [Bibliotecas essenciais e seguras](#-bibliotecas-essenciais-e-seguras)
- [Referências e fontes confiáveis](#-referências-e-fontes-confiáveis)
- [Complementar — pyenv](#-complementar--pyenv)
- [Complementar — venv detalhado](#-complementar--venv-detalhado)
- [Complementar — pip detalhado](#-complementar--pip-detalhado)

---

## 🧠 O que é o Python e como funciona

Python é uma linguagem de programação interpretada, de alto nível e propósito geral. Criada por Guido van Rossum em 1991, é hoje uma das linguagens mais usadas no mundo — em ciência de dados, automação, desenvolvimento web, inteligência artificial e ensino de programação.

**Como o interpretador funciona:**
- Você escreve código em um arquivo `.py`
- O interpretador CPython lê e converte para bytecode (`.pyc`)
- O bytecode é executado pela máquina virtual Python

**Versões:**
- A versão oficial e mais usada é o **CPython** (implementação de referência)
- Sempre use **Python 3.x** — o Python 2 foi descontinuado em 2020
- A versão mínima recomendada hoje é **Python 3.10+**

**Python do sistema vs Python isolado:**

| | Python do sistema | Python com pyenv + venv |
|---|---|---|
| Risco | Pode quebrar o SO | Isolado, sem risco |
| Versão | Fixa | Qualquer versão |
| Pacotes | Globais | Por projeto |
| Recomendado para | Nada | Tudo |

> **Regra de ouro:** nunca instale pacotes com `pip` no Python do sistema. Use sempre um ambiente virtual.

---

## 💻 Instalação

### macOS — via Homebrew

```bash
# Instalar Homebrew (se não tiver)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar Python
brew install python

# Verificar
python3 --version
which python3
```

### Linux — Ubuntu/Debian

```bash
sudo apt update
sudo apt install python3 python3-pip python3-venv

# Verificar
python3 --version
pip3 --version
```

### Windows

```bash
# Baixe o instalador em https://www.python.org/downloads/
# Marque "Add Python to PATH" durante a instalação

# Verificar no PowerShell ou CMD
python --version
pip --version
```

### Verificando a instalação

```bash
python3 --version            # versão instalada
python3 -c "import sys; print(sys.executable)"  # caminho do interpretador
which python3                # localização do binário (macOS/Linux)
```

---

## 🔀 Gerenciando versões com pyenv

### O que é e por que usar

O **pyenv** permite instalar e alternar entre múltiplas versões do Python sem afetar o Python do sistema operacional. Cada projeto pode usar uma versão diferente, definida pelo arquivo `.python-version` na raiz do diretório.

```
sem pyenv:   projeto A → Python 3.9 (sistema) ← risco
com pyenv:   projeto A → Python 3.9 (isolado)
             projeto B → Python 3.12 (isolado)
```

### Instalação do pyenv

```bash
# macOS — via Homebrew
brew update && brew install pyenv

# Linux — via script oficial
curl https://pyenv.run | bash
```

### Configuração no `~/.zshrc` (ou `~/.bashrc`)

```bash
# Adicione ao final do arquivo
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

```bash
# Aplicar
source ~/.zshrc
```

### Comandos principais

```bash
pyenv                          # exibe a versão e lista de comandos
pyenv install --list           # lista todas as versões disponíveis
pyenv install 3.12.2           # instala uma versão específica
pyenv versions                 # lista versões instaladas
pyenv version                  # versão ativa no diretório atual
pyenv global 3.12.2            # define a versão global (padrão)
pyenv local 3.11.4             # define a versão para o diretório atual
pyenv shell 3.10.0             # define a versão só para a sessão atual
pyenv uninstall 3.11.4         # remove uma versão instalada
pyenv which python             # caminho do Python ativo
```

### O arquivo `.python-version`

```bash
# Criado automaticamente pelo pyenv local
cat .python-version            # exibe a versão definida para o diretório
# Ex: 3.11.4
```

> Ao entrar em um diretório com `.python-version`, o pyenv ativa automaticamente a versão correta.

---

## 📦 Ambiente virtual — venv

### O que é e por que usar

Um **ambiente virtual** é uma cópia isolada do Python com seus próprios pacotes. Garante que cada projeto tenha suas dependências independentes, sem conflito com outros projetos ou com o sistema.

```
projeto-a/
  .venv/          ← pandas 1.5, requests 2.28
projeto-b/
  .venv/          ← pandas 2.0, requests 2.31
```

### Criando e ativando

```bash
# Criar o ambiente virtual na pasta .venv
python3 -m venv .venv

# Ativar (macOS/Linux)
source .venv/bin/activate

# Ativar (Windows)
.venv\Scripts\activate

# Desativar
deactivate

# Remover o ambiente virtual
rm -rf .venv
```

> Quando o ambiente está ativo, o nome `(.venv)` aparece no início do prompt do terminal.

---

## 📦 pip — Gerenciador de pacotes

### Comandos principais

```bash
# Atualizar o pip (sempre faça isso primeiro, dentro da venv)
python -m pip install --upgrade pip

# Instalar pacote
pip install nome-do-pacote
pip install pandas==2.0.3      # versão específica
pip install "pandas>=2.0"      # versão mínima

# Desinstalar
pip uninstall nome-do-pacote

# Listar pacotes instalados
pip list
pip list --outdated            # pacotes com atualizações disponíveis

# Informações sobre um pacote
pip show pandas

# Buscar pacote (depreciado — use pypi.org)
pip search nome                # use https://pypi.org

# Gerar arquivo de dependências
pip freeze > requirements.txt

# Instalar a partir do requirements.txt
pip install -r requirements.txt

# Instalar sem cache (útil em CI/CD)
pip install --no-cache-dir -r requirements.txt
```

> **Segurança:** sempre instale pacotes dentro de uma venv. Nunca use `sudo pip install`.

---

## 🚀 Iniciando um projeto do zero

Fluxo completo combinando **pyenv + venv** do zero até o primeiro script.

### No terminal

```bash
# 1. Criar e entrar na pasta do projeto
mkdir meu-projeto
cd meu-projeto

# 2. Definir a versão do Python com pyenv
pyenv local 3.12.2

# 3. Confirmar a versão ativa
python --version

# 4. Criar o ambiente virtual
python -m venv .venv

# 5. Ativar o ambiente
source .venv/bin/activate      # macOS/Linux
# .venv\Scripts\activate       # Windows

# 6. Atualizar o pip
python -m pip install --upgrade pip

# 7. Instalar dependências
pip install pandas requests

# 8. Salvar as dependências
pip freeze > requirements.txt

# 9. Criar o primeiro script
touch main.py

# 10. Ao terminar, desativar o ambiente
deactivate
```

### No VS Code

```bash
# 1. Abra a pasta do projeto no VS Code
code meu-projeto/

# 2. Abra o terminal integrado (Ctrl+` ou Cmd+`)

# 3. Crie e ative a venv normalmente pelo terminal
python3 -m venv .venv
source .venv/bin/activate

# 4. Selecione o interpretador Python correto
# Cmd+Shift+P → "Python: Select Interpreter" → escolha .venv/bin/python
```

**Configuração automática no VS Code:**

Crie `.vscode/settings.json` na raiz do projeto:

```json
{
    "python.defaultInterpreterPath": ".venv/bin/python",
    "python.terminal.activateEnvironment": true
}
```

> Com essa configuração, o VS Code ativa o ambiente automaticamente ao abrir qualquer terminal integrado no projeto.

### `.gitignore` recomendado

```gitignore
.venv/
__pycache__/
*.pyc
*.pyo
.python-version
.env
.env.local
*.egg-info/
dist/
build/
.pytest_cache/
```

---

## 🔢 Tipos de dados

### Tabela completa

| Categoria | Tipo | Exemplo |
|---|---|---|
| Texto | `str` | `x = "Pycoders"` |
| Numérico | `int` | `x = 17` |
| Numérico | `float` | `x = 17.5` |
| Numérico | `complex` | `x = 7j` |
| Sequência | `list` | `x = ["red", "blue"]` |
| Sequência | `tuple` | `x = ("apple", "banana")` |
| Sequência | `range` | `x = range(6)` |
| Mapeamento | `dict` | `x = {"name": "John"}` |
| Conjunto | `set` | `x = {"apple", "banana"}` |
| Conjunto | `frozenset` | `x = frozenset({"a", "b"})` |
| Booleano | `bool` | `x = True` |
| Binário | `bytes` | `x = b"Pycoders"` |
| Binário | `bytearray` | `x = bytearray(5)` |
| Binário | `memoryview` | `x = memoryview(bytes(5))` |
| Nulo | `NoneType` | `x = None` |

### Verificando e convertendo tipos

```python
type(x)                        # retorna o tipo da variável
isinstance(x, int)             # verifica se x é do tipo int

int("42")                      # str → int
float("3.14")                  # str → float
str(100)                       # int → str
list((1, 2, 3))                # tuple → list
tuple([1, 2, 3])               # list → tuple
set([1, 1, 2, 3])              # list → set (remove duplicatas)
bool(0)                        # → False (0, "", [], None são falsy)
```

---

## 🧱 Comandos e estruturas essenciais

### Variáveis e operadores

```python
# Variáveis (sem declaração de tipo)
nome = "Python"
versao = 3.12
ativo = True

# Operadores aritméticos
x + y    # soma
x - y    # subtração
x * y    # multiplicação
x / y    # divisão (retorna float)
x // y   # divisão inteira
x % y    # módulo (resto)
x ** y   # potência

# Operadores de comparação
x == y   # igual
x != y   # diferente
x > y    # maior
x < y    # menor
x >= y   # maior ou igual
x <= y   # menor ou igual

# Operadores lógicos
x and y
x or y
not x

# Operadores de string
"Python" + " 3"          # concatenação → "Python 3"
"ha" * 3                 # repetição → "hahaha"
f"Versão {versao}"       # f-string (recomendado)
```

### Estruturas de controle

```python
# if / elif / else
if x > 10:
    print("maior")
elif x == 10:
    print("igual")
else:
    print("menor")

# for
for item in lista:
    print(item)

for i in range(5):          # 0, 1, 2, 3, 4
    print(i)

for i, item in enumerate(lista):   # índice + valor
    print(i, item)

# while
while condicao:
    # código
    break                   # sai do loop
    continue                # pula para a próxima iteração

# Compreensão de lista (list comprehension)
quadrados = [x**2 for x in range(10)]
pares = [x for x in range(20) if x % 2 == 0]
```

### Funções

```python
# Definição básica
def saudacao(nome):
    return f"Olá, {nome}!"

# Parâmetro com valor padrão
def potencia(base, expoente=2):
    return base ** expoente

# Argumentos variádicos
def soma(*args):
    return sum(args)

def info(**kwargs):
    for chave, valor in kwargs.items():
        print(f"{chave}: {valor}")

# Função lambda (anônima)
dobro = lambda x: x * 2

# Anotação de tipos (type hints)
def soma(a: int, b: int) -> int:
    return a + b
```

### Classes

```python
class Animal:
    # Atributo de classe
    reino = "Animalia"

    # Construtor
    def __init__(self, nome: str, idade: int):
        self.nome = nome        # atributo de instância
        self.idade = idade

    # Método
    def apresentar(self) -> str:
        return f"{self.nome}, {self.idade} anos"

    # Representação em string
    def __repr__(self) -> str:
        return f"Animal({self.nome!r})"


# Herança
class Cachorro(Animal):
    def __init__(self, nome, idade, raca):
        super().__init__(nome, idade)
        self.raca = raca

    def latir(self):
        return "Au au!"


# Uso
dog = Cachorro("Rex", 3, "Labrador")
print(dog.apresentar())
print(dog.latir())
```

### Tratamento de erros

```python
try:
    resultado = 10 / 0
except ZeroDivisionError:
    print("Divisão por zero!")
except (TypeError, ValueError) as e:
    print(f"Erro: {e}")
else:
    print("Executado se não houve erro")
finally:
    print("Executado sempre")

# Lançar exceção
raise ValueError("Valor inválido")

# Exceção personalizada
class MeuErro(Exception):
    pass
```

### Manipulação de arquivos

```python
# Leitura
with open("arquivo.txt", "r", encoding="utf-8") as f:
    conteudo = f.read()           # lê tudo
    linhas = f.readlines()        # lê como lista de linhas

# Escrita
with open("arquivo.txt", "w", encoding="utf-8") as f:
    f.write("conteúdo\n")

# Append
with open("arquivo.txt", "a", encoding="utf-8") as f:
    f.write("nova linha\n")

# Pathlib (forma moderna e recomendada)
from pathlib import Path

p = Path("arquivo.txt")
conteudo = p.read_text(encoding="utf-8")
p.write_text("novo conteúdo", encoding="utf-8")
p.exists()                        # verifica se existe
p.parent                          # diretório pai
p.stem                            # nome sem extensão
list(Path(".").glob("*.py"))      # lista arquivos .py
```

---

## 📚 Bibliotecas essenciais e seguras

> Todas as bibliotecas listadas são de código aberto, amplamente usadas, mantidas ativamente e disponíveis no [PyPI](https://pypi.org).

---

### Dados e Análise

| Biblioteca | Descrição | Instalação | Link |
|---|---|---|---|
| **pandas** | Manipulação e análise de dados tabulares (DataFrames) | `pip install pandas` | [pandas.pydata.org](https://pandas.pydata.org) |
| **numpy** | Computação numérica com arrays multidimensionais | `pip install numpy` | [numpy.org](https://numpy.org) |
| **polars** | Alternativa ao pandas, mais rápida para grandes volumes | `pip install polars` | [pola.rs](https://www.pola.rs) |
| **openpyxl** | Leitura e escrita de arquivos Excel (.xlsx) | `pip install openpyxl` | [openpyxl.readthedocs.io](https://openpyxl.readthedocs.io) |

---

### Visualização

| Biblioteca | Descrição | Instalação | Link |
|---|---|---|---|
| **matplotlib** | Gráficos estáticos, base da maioria das libs de visualização | `pip install matplotlib` | [matplotlib.org](https://matplotlib.org) |
| **seaborn** | Gráficos estatísticos elegantes sobre matplotlib | `pip install seaborn` | [seaborn.pydata.org](https://seaborn.pydata.org) |
| **plotly** | Gráficos interativos para web e notebooks | `pip install plotly` | [plotly.com/python](https://plotly.com/python) |

---

### Web e APIs

| Biblioteca | Descrição | Instalação | Link |
|---|---|---|---|
| **requests** | Requisições HTTP simples e elegantes | `pip install requests` | [docs.python-requests.org](https://docs.python-requests.org) |
| **httpx** | Alternativa moderna ao requests, suporte a async | `pip install httpx` | [www.python-httpx.org](https://www.python-httpx.org) |
| **fastapi** | Framework web moderno e rápido para APIs REST | `pip install fastapi uvicorn` | [fastapi.tiangolo.com](https://fastapi.tiangolo.com) |
| **flask** | Microframework web leve e flexível | `pip install flask` | [flask.palletsprojects.com](https://flask.palletsprojects.com) |
| **beautifulsoup4** | Parsing e extração de dados de HTML/XML | `pip install beautifulsoup4` | [beautiful-soup-4.readthedocs.io](https://beautiful-soup-4.readthedocs.io) |

---

### Automação

| Biblioteca | Descrição | Instalação | Link |
|---|---|---|---|
| **selenium** | Automação de navegador web | `pip install selenium` | [selenium-python.readthedocs.io](https://selenium-python.readthedocs.io) |
| **playwright** | Automação moderna de browser (mais rápido que selenium) | `pip install playwright` | [playwright.dev/python](https://playwright.dev/python) |
| **schedule** | Agendamento de tarefas em Python puro | `pip install schedule` | [schedule.readthedocs.io](https://schedule.readthedocs.io) |
| **pyautogui** | Automação de mouse e teclado | `pip install pyautogui` | [pyautogui.readthedocs.io](https://pyautogui.readthedocs.io) |

---

### IA e Machine Learning

| Biblioteca | Descrição | Instalação | Link |
|---|---|---|---|
| **scikit-learn** | Machine learning clássico (classificação, regressão, clustering) | `pip install scikit-learn` | [scikit-learn.org](https://scikit-learn.org) |
| **transformers** | Modelos de linguagem e IA (Hugging Face) | `pip install transformers` | [huggingface.co/docs/transformers](https://huggingface.co/docs/transformers) |
| **langchain** | Framework para aplicações com LLMs (ChatGPT, Claude, etc.) | `pip install langchain` | [python.langchain.com](https://python.langchain.com) |
| **openai** | SDK oficial da OpenAI (GPT, DALL-E, Whisper) | `pip install openai` | [platform.openai.com/docs](https://platform.openai.com/docs) |
| **anthropic** | SDK oficial da Anthropic (Claude) | `pip install anthropic` | [docs.anthropic.com](https://docs.anthropic.com) |

---

### Utilitários

| Biblioteca | Descrição | Instalação | Link |
|---|---|---|---|
| **pathlib** | Manipulação de caminhos de arquivo (biblioteca padrão) | nativa | [docs.python.org/pathlib](https://docs.python.org/3/library/pathlib.html) |
| **python-dotenv** | Carrega variáveis de ambiente de arquivos `.env` | `pip install python-dotenv` | [saurabh-kumar.com/python-dotenv](https://saurabh-kumar.com/python-dotenv) |
| **pydantic** | Validação de dados e configurações com type hints | `pip install pydantic` | [docs.pydantic.dev](https://docs.pydantic.dev) |
| **rich** | Output colorido e formatado no terminal | `pip install rich` | [rich.readthedocs.io](https://rich.readthedocs.io) |
| **loguru** | Sistema de logs simples e poderoso | `pip install loguru` | [loguru.readthedocs.io](https://loguru.readthedocs.io) |
| **typer** | Criação de CLIs a partir de funções Python | `pip install typer` | [typer.tiangolo.com](https://typer.tiangolo.com) |

---

### Testes

| Biblioteca | Descrição | Instalação | Link |
|---|---|---|---|
| **pytest** | Framework de testes mais usado em Python | `pip install pytest` | [pytest.org](https://pytest.org) |
| **pytest-cov** | Cobertura de testes com pytest | `pip install pytest-cov` | [pytest-cov.readthedocs.io](https://pytest-cov.readthedocs.io) |

---

### Segurança

| Biblioteca | Descrição | Instalação | Link |
|---|---|---|---|
| **cryptography** | Criptografia de alto nível (AES, RSA, tokens) | `pip install cryptography` | [cryptography.io](https://cryptography.io) |
| **bcrypt** | Hash seguro de senhas | `pip install bcrypt` | [pypi.org/project/bcrypt](https://pypi.org/project/bcrypt) |
| **python-jose** | JSON Web Tokens (JWT) | `pip install python-jose` | [python-jose.readthedocs.io](https://python-jose.readthedocs.io) |

---

## 📚 Referências e fontes confiáveis

### Documentação oficial

| Recurso | Link |
|---|---|
| Documentação oficial Python 3 | [docs.python.org/3](https://docs.python.org/3) |
| Tutorial oficial | [docs.python.org/3/tutorial](https://docs.python.org/3/tutorial) |
| Biblioteca padrão (stdlib) | [docs.python.org/3/library](https://docs.python.org/3/library) |
| PyPI — repositório de pacotes | [pypi.org](https://pypi.org) |
| PEPs (propostas de melhoria) | [peps.python.org](https://peps.python.org) |
| Python Enhancement Proposals | [pep8.org](https://pep8.org) — guia de estilo |

### Livros e tutoriais gratuitos em português

| Recurso | Link |
|---|---|
| Pense Python 2e (Allen Downey) | [penseallen.github.io/PensePython2e](https://penseallen.github.io/PensePython2e) |
| Tutorial Python 2.7 (base, ainda útil) | [turing.com.br/pydoc/2.7/tutorial](http://turing.com.br/pydoc/2.7/tutorial) |

### Sites e cursos recomendados

| Recurso | Link |
|---|---|
| Real Python — tutoriais avançados | [realpython.com](https://realpython.com) |
| Python Requests Guide | [realpython.com/python-requests](https://realpython.com/python-requests) |
| W3Schools Python | [w3schools.com/python](https://www.w3schools.com/python) |
| Exercism — prática de Python | [exercism.org/tracks/python](https://exercism.org/tracks/python) |
| Python.org Beginner's Guide | [wiki.python.org/moin/BeginnersGuide](https://wiki.python.org/moin/BeginnersGuide) |

### Canais e vídeos

| Recurso | Link |
|---|---|
| Classes em Python (YouTube) | [youtube.com/watch?v=gomDSZaay3E](https://www.youtube.com/watch?v=gomDSZaay3E) |
| Corey Schafer — Python Tutorials | [youtube.com/@coreyms](https://www.youtube.com/@coreyms) |
| Hashtag Treinamentos (PT-BR) | [youtube.com/@HashtagTreinamentos](https://www.youtube.com/@HashtagTreinamentos) |

### 🔍 Auditoria Automatizada com `pip-audit`

A melhor forma de automatizar a busca por pacotes maliciosos ou vulneráveis conhecidos no PyPI é utilizando a ferramenta **`pip-audit`**, mantida pela *Open Source Security Foundation* (OpenSSF). 
Ela checa se os pacotes do seu ambiente local constam nos relatórios de vulnerabilidades e malwares conhecidos (**OSV** - *Open Source Vulnerabilities*).
Instale a ferramenta no seu ambiente:

```bash
pip install pip-audit

---

### 🔧 Complementar — pyenv

> Gerenciador de versões do Python por diretório. Evita alterar o Python do sistema operacional.

### Instalação

```bash
# macOS
brew update && brew upgrade
brew install pyenv

# Linux
curl https://pyenv.run | bash
```

### Configuração no `~/.zshrc`

```bash
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

```bash
source ~/.zshrc
```

### Comandos de referência

```bash
pyenv install --list           # lista versões disponíveis
pyenv install 3.12.2           # instala uma versão
pyenv versions                 # versões instaladas
pyenv version                  # versão ativa no diretório atual
pyenv global 3.12.2            # versão padrão global
pyenv local 3.11.4             # versão para o diretório atual → cria .python-version
pyenv shell 3.10.0             # versão só para a sessão atual
pyenv uninstall 3.11.4         # remove versão
pyenv which python             # caminho do Python ativo
brew update && brew upgrade    # atualiza brew e pacotes (macOS)
```

### Como funciona o `.python-version`

```bash
# Ao rodar pyenv local 3.11.4, o pyenv cria:
cat .python-version
# 3.11.4

# A partir daí, ao entrar neste diretório:
python --version
# Python 3.11.4  ← automaticamente a versão correta
```

---

## 🔧 Complementar — venv detalhado

> Ambiente virtual isolado por projeto. Garante que pacotes de um projeto não afetem outros.

### No terminal

```bash
# 1. Entrar na pasta do projeto
cd meu-projeto

# 2. Criar o ambiente virtual
python3 -m venv .venv

# 3. Ativar
source .venv/bin/activate      # macOS/Linux
.venv\Scripts\activate         # Windows

# O prompt muda para:
# (.venv) usuario@maquina meu-projeto $

# 4. Instalar dependências
pip install pandas requests

# 5. Salvar dependências
pip freeze > requirements.txt

# 6. Desativar ao terminar
deactivate

# 7. Remover o ambiente (se necessário)
rm -rf .venv
```

### No VS Code

```bash
# 1. Abrir a pasta no VS Code
code meu-projeto/

# 2. Criar o ambiente pelo terminal integrado (Ctrl+` ou Cmd+`)
python3 -m venv .venv
source .venv/bin/activate

# 3. Selecionar o interpretador
# Cmd+Shift+P (Mac) ou Ctrl+Shift+P (Windows/Linux)
# → "Python: Select Interpreter"
# → Escolha: ./.venv/bin/python
```

**Configuração automática `.vscode/settings.json`:**

```json
{
    "python.defaultInterpreterPath": ".venv/bin/python",
    "python.terminal.activateEnvironment": true
}
```

### Permissões (se necessário)

```bash
# Verificar permissões do activate
ls -l .venv/bin/activate

# Conceder permissão de execução
chmod +x .venv/bin/activate
```

### Restaurando dependências em outro ambiente

```bash
# Em uma nova máquina ou ambiente
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

---

## 🔧 Complementar — pip detalhado

> Gerenciador de pacotes do Python. Instala, atualiza e remove bibliotecas do [PyPI](https://pypi.org).

### Atualização

```bash
# Sempre atualize o pip dentro da venv antes de instalar pacotes
python -m pip install --upgrade pip
```

### Instalação de pacotes

```bash
pip install nome-do-pacote              # versão mais recente
pip install pandas==2.0.3              # versão específica
pip install "pandas>=2.0,<3.0"         # intervalo de versões
pip install pandas numpy matplotlib    # múltiplos pacotes de uma vez
pip install -r requirements.txt        # instala do arquivo de dependências
pip install --no-cache-dir pacote      # instala sem usar cache (CI/CD)
pip install -e .                       # instala o projeto local em modo editável
```

### Consulta e manutenção

```bash
pip list                               # pacotes instalados
pip list --outdated                    # pacotes com atualizações disponíveis
pip show pandas                        # detalhes de um pacote
pip check                              # verifica conflitos de dependências
pip freeze                             # lista com versões exatas (para requirements.txt)
pip freeze > requirements.txt          # salva as dependências
```

### Remoção

```bash
pip uninstall nome-do-pacote           # remove um pacote
pip uninstall -r requirements.txt -y  # remove todos do arquivo
```

### Boas práticas de segurança

```bash
# Nunca instale pacotes no Python do sistema
sudo pip install pacote                # ❌ evite

# Sempre use dentro de uma venv
source .venv/bin/activate
pip install pacote                     # ✅ correto

# Verifique pacotes antes de instalar
# → confirme o nome exato em https://pypi.org
# → desconfie de pacotes com nomes parecidos com libs famosas (typosquatting)

# Audite dependências com pip-audit
pip install pip-audit
pip-audit                              # verifica vulnerabilidades conhecidas
```

---

*Mantido com ❤️ — contribuições são bem-vindas via PR.*
