||| Acesse a pasta do Projeto

cd caminho/da/sua/pasta

||| Criando o ambiente virtual

python -m venv .venv

||| Ativando o ambiente

source .venv/bin/activate 

||| Desativando o ambiente

deactivate


> Importante:
  Quando o ambiente está ativo, o nome (.venv) 
  aparecerá no início da linha do seu terminal.
  
  
||| Comandos úteis

> instalar um pacote
  pip install nome-do-pacote

> ver o que está instalado
  pip list
  
> gerar lista de dependências
  pip freeze > requirements.txt


||| No VSCode

|| Configuração automática

Para garantir que o VS Code sempre lembre disso e até já abra o terminal com o ambiente ativado, 
você pode criar um arquivo de configuração no projeto:

Crie uma pasta chamada .vscode na raiz do seu projeto (se não existir).

Dentro dela, crie um arquivo chamado settings.json.

Cole o seguinte conteúdo:

JSON
{
    "python.defaultInterpreterPath": ".venv/bin/python",
    "python.terminal.activateEnvironment": true
}


// end
