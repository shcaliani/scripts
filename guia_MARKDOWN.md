# 📙 MANUAL MARKDOWN

> A extensão padrão de arquivos Markdown é:
.md
>
> Outras extensões que também existem
>.markdown	Alternativa mais “formal”	Menos comum no GitHub
>.mdown	Variação antiga	Rara hoje
>.mkd / .mkdn	Variações históricas	Praticamente em desuso

---

### 🏷️ Código

> Código de linha

Use o comando `python script.py`

> Bloco de código

<pre> ```bash pip install -r requirements.txt ``` </pre>
Você pode indicar a linguagem para destacar sintaxe:

```python
def hello():
    print("Olá")
```

---

### 🏷️ Títulos

| caracteres | efeito | sintaxe |
|------|-----------|------------|
| # | título nível 1 | antes do texto |
| ## | título nível 2 | antes do texto |
| ### | título nível 3 | antes do texto |
| #### | título nível 3 | antes do texto |

<br>

### 🏷️ Grafias

| caracteres | efeito | sintaxe |
|------|-----------|------------|
| ** | **negrito** | antes e depois do texto |
| * | *itálico* | antes e depois do texto |
| *** | ***itálico e negrito*** | antes e depois do texto |
| ~~ | ~~texto riscado~~ | antes e depois do texto |

<br>

### 🏷️ Tabelas

> Utilize `|' para separar as colunas, que serão ajustadas automaticamente

>Alinhamentos:
Utilize par alinhar `:--- esquerda`
                    `---: direita`
                    `:---: centro`

<br>

### 🏷️ Citação (blockquote)

`> Isto é uma observação importante`
> Isto é uma observação importante

<br>


### 🏷️ Badges (opcional, comum em GitHub)

`![Python](https://img.shields.io/badge/Python-3.11-blue)`
![Python](https://img.shields.io/badge/Python-3.11-blue)

<br>

### 🏷️ Listas

> Utilizando `'` ou `1.`
- Item 1
- Item 2
  - Subitem
  - Subitem

1. Primeiro
2. Segundo
3. Terceiro

<br>

### 🏷️ Destacando

> Markdown puro não permite mudar cor de texto.

<!-- 
no HTML seria assim, visível no ReadMe para cores

<span style="color:red">Texto em vermelho</span>
<span style="color:green">Texto em verde</span>
<span style="color:#1E90FF">Texto em azul personalizado</span>
-->

> ou alternativas como:

⚠️ **Atenção:** Execute com cuidado  
✅ **Sucesso:** Operação concluída  
❌ **Erro:** Dependência não encontrada


<br>

### 🏷️ Links
> Link externo

`![Texto alternativo](https://link-da-imagem.com/imagem.png)`
![Texto alternativo](https://link-da-imagem.com/imagem.png)

> Link interno

`[Ir para Instalação](#instalação)`
[Ir para Instalação](#instalação)

> Imagem

`![Texto alternativo](https://link-da-imagem.com/imagem.png)`
![Texto alternativo](https://link-da-imagem.com/imagem.png)

> Imagem local

`![Logo](docs/imagens/logo.png)`
![Logo](docs/imagens/logo.png)

<br>

### 🏷️ Comentário

> Utilizar os recursos do HTML, sendo:
`<!--` para início de comentário
`-->`  para fim de comentário

<br>

### 🏷️ Lembretes
> TODO
> FIXME

<br>

### 🏷️ Detalhes recolhíveis

<details>
<summary>Clique para expandir</summary>

Conteúdo escondido aqui dentro.
Pode ter **Markdown normal**.
</details>

<br>

### 🏷️ HTML e Markdown
>

| código | efeito |
|------|-----------|
| `<br>` | quebra de linha |
| `<sub>` | texto subscrito |
| `<sup>` | texto sobrescrito |
| `<kbd>` | teclas |
| `<details>` | conteúdo recolhível |
| `---` | traço divisor |

> Exemplo
<br>
H<sub>2</sub>O  
x<sup>2</sup>
<br>









### 🏷️ Blocos de diff 
> Ótimo para documentação técnica
> Utilizando ` ```diff e ```markdown `

> Renderiza com cores de adição/remoção.

```diff
+ Linha adicionada
- Linha removida
```

GitHub agora suporta:

```markdown
> [!NOTE]
> Informação importante

> [!WARNING]
> Atenção redobrada

> [!TIP]
> Dica útil
```
