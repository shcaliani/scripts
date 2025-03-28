🟨🟨 VENV  


⭕️ INICIANDO UM PROJETO no VSCode

1. cria o diretório
2. abre o diretório no VSCode
3. cria e ativa a Venv 
    $ python3.10 -m venv venv               # criando venv (inclusive a pasta)
    $ source .venv/bin/activate             # ativando venv    
    # na linha de comando VSCode <selecionar interpretador> = visualiza no rodapé ]
4. instala todas as libs que precisará
    $ pip install pandas
5. cria o arquivo do script
    $ touch nome_arq.py
    Go!   


⭕️ INICIANDO UM PROJETO NO TERMINAL

Cria o diretório
    $ mkdir <nome pasta>
Entra no diretório
    $ cd <nome pasta>

🔶 Criando a venv
    $ python3    -m venv .venv                           # no Windows : criando venv (inclusive a pasta venv)
    $ python3.10 -m venv .venv                           # no MacOs : criando venv (inclusive a pasta venv)
    $ ls                                                 # lista diretórios
    > drwxr-xr-x 6 sergio staff 192B 2 Set 2024 venv     # prompt com diretório criado

🔶 Ativando a venv
    $ source ./venv/bin/activate
    > (venv) sergio :<nome pasta> (main*) $
# Após executar o activate, esse indicador desaparece.

🔶 Desabilitando a venv
$ rm -rf .venv  
$ deactivate   
# Ao executar deactivate, você retorna ao ambiente Python global do seu sistema. 
# Isso significa que o interpretador Python e os pacotes instalados no ambiente virtual não estarão mais ativos.
# Após executar deactivate, esse indicador desaparece.

🔶 Alterando permissões
> ls -l venv/bin/activate 
# verifica as permissões atuais do arquivo. 
# A saída mostrará algo como -rw-r--r--. 
# As primeiras 10 letras representam as permissões. 
# Se as letras "x" não estiverem presentes, o arquivo não tem permissão de execução.

Concedendo permissão de execução
$ chmod +x venv/bin/activate 
# Adiciona permissões de execução ao arquivo. 

# end
