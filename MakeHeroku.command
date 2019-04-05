#!/bin/sh

#  MakeHeroku.command
#  
#
#  Created by Thomas Varano on 2/6/19.
#

echo "This is used for creating a heroku environment in flask from scratch."
echo -e "Be careful if you already have code for the site you are setting up.\n"

read -p 'Enter your full project directory (or drag it in): ' root
read -p 'Do you have python 3 installed? (y/n): ' pyinst

# if brew is not installed...
command -v brew >/dev/null 2>&1 || {
    echo "installing homebrew to download packages/tools..."
    echo "do not terminate this process."
    echo "i know it takes a while."

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}\

if [ ${pyinst} = 'n' ]; then
    echo 'updating python... This can take a while.'
    brew install python
    python --version
    echo "python3 and pip installed"
fi

cd ${root}

echo "creating virtual environment..."

python3 -m venv env
source env/bin/activate

echo "installing pip in environment"
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py

#upgrade pip
echo "upgrading pip..."
pip install --upgrade pip

# created python env
echo "created python venv."

pip install flask

# create deploy.py
touch deploy.py

cat <<EOT >> deploy.py
from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")

if __name__ == "__main__":
    app.run(debug=True)

EOT

# create folders.
mkdir templates
mkdir -p static/css
mkdir static/js

touch templates/index.html
touch static/css/style.css

cat <<EOT >> templates/index.html
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="static/css/style.css">
    </head>
    <body>
        <h1>hello world!</h1>
    </body>
</html>

EOT

# local hosting is complete.
echo ""
echo "you now have a working local site."
echo "make sure to activate your venv before running (source env/bin/activate)"
echo "Type q to quit. Type any other letter to continue."

read -rsn1 cont

if [ ${cont} = 'q' ]; then
    echo "exiting"
    exit 0
fi

echo ""
echo "congifuring git."

# if git is not installed...
command -v git >/dev/null 2>&1 || {
    echo "installing git"
    brew install git
}\

read -p "are you logged in with git? (y\n): " gitlogg

if [ ${gitlogg} = "n" ]; then
    read -p "type your github username: " gitusr
    git config --global user.name ${gitusr}
    read -p "type your github email: " giteml
    git config --global user.email ${giteml}
    git config --global credential.helper osxkeychain
fi
echo ""

read -p "Create an empty Github repo and paste its clone URL here.\n" repourl

git init
git add .
git commit -m "initial commit"
git remote add origin ${repourl}
git push -u origin master

echo "now configuring for heroku."

# if heroku is not installed...
command -v heroku >/dev/null 2>&1 || {
    echo "installing heroku CLI"
    brew tap heroku/brew && brew install heroku
}\

echo "login with heroku."
heroku login

echo "Create a heroku project"
read -p "enter its name exactly here: " heroname

echo "setting up heroku app."
echo "please connect your Heroku app with your Github repository"
echo "type any letter when done."
read -rsn1

git remote add heroku git@heroku.com:heroname.git

echo "configuring for heroku..."
echo >Procfile "web: gunicorn deploy:app"

pip install gunicorn

pip freeze > requirements.txt

echo "python-3.7.1" >runtime.txt

echo "setting buildpack."
heroku buildpacks:set heroku/python

git add .
git commit -m "config for heroku"
git push

echo ""
echo "process complete. Check heroku to deploy"
echo "or cmd+double click the following"
echo "https://dashboard.heroku.com/apps/${heroname}"

echo -e "\nMake sure you activate your env (source env/bin/activate) when you run locally."

echo ""

