#!/bin/bash

sudo pip install --upgrade pip 

# Installieren aller Dev-Tools
sudo apt update
sudo apt upgrade -y

# DIE Liste von Paketen, die nachfolgend installiert werden
packages="portaudio19-dev libsndfile1"

for package in $packages; do
  # Prüfen, ob das Paket bereits installiert ist
  if dpkg -s $package &> /dev/null; then
    # Wenn ja, eine Nachricht ausgeben
    echo "$package ist bereits installiert."
  else
    # Wenn nicht, das Paket mit apt installieren
    echo "$package wird installiert..."
    sudo apt install -y $package
  fi
done
sudo apt update

# Installiere alle pip Abhängigkeiten -> requirements...
echo '\nInstalliere pip requirements...\n'
pip install --user -r .devcontainer/requirements.txt

### Set Settings

# Setze Passwort für die SSH Verbidnung
sudo passwd -d vscode && echo -e 'qwertz.\nqwertz.' | sudo passwd vscode

# Berechtigungen vergeben: für alle vollen Zugriff auf alles und Unterordner
#sudo chown -R vscode * /workspaces && sudo chmod -R a+rwx /workspaces 
sudo chown -R vscode:vscode /workspaces && sudo chmod -R 777 /workspaces 
