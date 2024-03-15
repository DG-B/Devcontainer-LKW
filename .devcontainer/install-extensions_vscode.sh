#!/bin/bash

#### tl;dr (siehe unten)
#
# Dieses Skript in der WSL Umgebung ausführen um in VSCode in WSL Extensions zu installieren:
# Stellen Sie sicher, dass Sie dieses Skript innerhalb der WSL-Umgebung und nicht in einer lokalen Windows-Shell ausführen. 
# Sie können ein Terminal in Ihrer WSL-Umgebung öffnen, indem Sie wsl in der Befehlszeile eingeben oder das WSL-Terminal über das Startmenü öffnen.
# Bitte beachten Sie, dass der VS Code CLI in Ihrem Systempfad verfügbar sein muss, damit das Skript funktioniert. 
# Sie können das überprüfen, indem Sie code --version in einem Terminal innerhalb Ihrer WSL-Umgebung eingeben. 
# Bei korrekter Ausführung sollte dies die Versionsnummer Ihrer VS Code-Installation zurückgeben.
#
# Speichern Sie das Skript in einer Datei und führen Sie es im Terminal aus.
# Das Skript liest jede Zeile in der Datei und verwendet den VS Code CLI-Befehl code --install-extension, um die Erweiterungen zu installieren.
####

# -> tl;dr
# Ausführung (in VS Code Konsole im WSL): bash .devcontainer/install-extensions_vscode.sh 

extensions="ms-python.python 
            ms-python.pylint 
            mhutchie.git-graph 
            donjayamanne.githistory 
            DavidAnson.vscode-markdownlint 
            yzhang.markdown-all-in-one
            shd101wyy.markdown-preview-enhanced"

for extension in $extensions; do
    # Installiere die Erweiterung mit dem vscode CLI
    code --install-extension $extension
done
