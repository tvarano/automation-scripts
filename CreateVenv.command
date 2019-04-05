#!/bin/sh

#  CreateVenv.command
#  
#
#  Created by Thomas Varano on 2/6/19.
#  

read -p 'Enter your full project directory (or drag it in): ' root
read -p 'Do you have python? (y/n): ' py-inst

if [ ${py-inst} = 'n' ]
then
    echo 'installing python... This takes a while.'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install python
    python --version
    echo "python3 and pip installed"
fi

cd ${root}

python3 -m venv env
source env/bin/activate

echo 'done'
