# devcontainer

Für die einfache und konsistente Entwicklung wird eine einheitliche Umgebung zu Verfügung gestellt. Die Pakete die zur Entwicklung notwendig sind, werden in den jeweiligen Listen gepflegt (siehe unten).

## tl;dr

Die Entwicklungsumgebung ist vollständig containerisiert. Docker Desktop muss hochgefahren sein & laufen BEVOR man das Skript ausführt!

`.\setup_env.ps1  -name "NAME"`

Wenn die Parameter nicht mit angegeben werden, wird der default Wert benutzt:

Param | Funktion | Type | Default
--- | --- | --- | ---
name | Name des WSL | String | kraftwerk

Mit der Ausführung wird ein Container mittels `devcontainer` erstellt und anschliessend in ein Subsystem konvertiert. Darin sind Dev Sachen enthalten, wie apt und pip packages und kleine Konfigurationen des Containers / Subsystems für einen entspannten Umgang.
Die dependencies Flag installiert notwendige Abhängigkeiten des Systems, das sind Node.js, npm und devcontainer-cli.

## Zusätzliche Infos

Es werden Systempackages (per apt-get) installiert, diese sind in einem devcontainer-feature umgesetzt. Zum Hinzufügen / Entfernen die Liste in dem Skript `.devcontainer/local-features/features/install.sh` anpassen.
Softwarepakete über pip werden im Erstellungsprozess am Ende der Kreation des Containers installiert. Für Anpassungen die Liste `.devcontainer/requirements.txt` bearbeiten.
Änderungen werden erst beim Neubauen wirksam.

### Rebuilden
Die Pakete können im WSL wie gewohnt erweitert werden. Falls das WSL neu erstellt werden soll: WSL und Container von vorherigen Aufsetzen mit dem Skript setup_env.ps1 **MÜSSEN** entfernt werden! Anonsten kommt es zu Konflikten...

### Hilfreiche Code Sachen

#### devcontainer.json

"remoteEnv": {
    // uncomment to pass your github token to container
    //"GH_TOKEN":"${localEnv:GH_TOKEN}"
},

-> features:
//"ghcr.io/devcontainers/features/common-utils:2": {}
//"ghcr.io/devcontainers-contrib/features/ffmpeg-apt-get:1": {}

#### setup_env.ps1

Delete recently created container
- docker rm $(docker ps -a -q --filter "label=temp_container")

to set wsl $name as default
- wsl -s $name

### Troubleshooting
wenn in Zeile 1 die Ausführung des Skripts failed  
```powershell
./install.sh: 1: set: Illegal option -  
Feature "devtools lkw" (Unknown) failed to install!"  
```

dann z.B. mit Codespace das install.sh Skript (in local-features) öffnen und unten rechts CRLF zu LF ändern!
Alternativ in .gitconfig (unter Users) im [Core] Segment folgendes hinzufügen:
`autocrlf = false`
