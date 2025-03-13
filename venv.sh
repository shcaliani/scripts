🟨🟨 VENV  

||| criando uma venv dentro do diretório do projeto

'verificar se é preciso atualizar o pip [ver pip_dicas]'
python3.10 -m venv .venv     'no macos'
python     -m venv .venv     'no windows'
'no pycharm - clique na pasta do projeto, e ele atualizara a pasta e fara o updating'
 
||| deletando uma venv - criar outra para, por exemplo, atualizar a versão do Python

rm -rf .venv  
deactivate           'no terminal'

||| começando um projeto

1. cria o diretório
2. abre o diretório no VSCode
3. cria e ativa a Venv 
    |python3.10 -m venv venv
    |source venv/bin/activate
    [ na linha de comando VSCode <selecionar interpretador> = visualiza no rodapé ]
4. instala todas as libs que precisará
    |pip install pandas
5. cria o arquivo do script
    |touch nome_arq.py
Go!   
