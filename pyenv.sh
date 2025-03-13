🟨🟨 PYENV 

Gerencia o ambiente por diretório para segregar as versões do Python.
Evita assim alterar o Python do Kernel
A chamada para cada diretório é direcionada pelo .python-version

⭕ COMANDOS

🔶 versão python instalada (kernel)

> python --version (num diretório que não tenha o .python-version gerado pelo pyenv

> pyenv brew update && brew upgrade                 | atualiza a versão do brew + upgrade

🔶 pyenv                                            

> pyenv                                             | versão do pyenv e lista de comandos
> pyenv install --list                              | lista todas as versões disponíveis no pyenv para installar
> pyenv versions                                    | versão do python instalada no diretório
> pyenv local 3.11.4 (exemplo)                      | registra no .python-version do diretório a versão a ser utilizada 
> pyenv install 3.12.2                              | instala no pyenve da home do usuário a versão indicada do python


⭕ BREW INSTALADOR PYVENV

🔶 brew install

Brew update : atualiza a lista
Brew upgrade : atualiza os pacotes

Pyenv : local + versão na pasta
Pyenv : versions
Pyenv Install + número da versão
Pyenv install —List : ver versões existentes

🔶 brew update 

pyenv brew update && brew upgrade                 | atualiza a versão do brew + upgrade

⭕ EXPORT

# PyEnv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# end
