# How-To



# Then - Run this script in PowerShell as ADMIN one folder before .devcontainer
# .\setup_env.ps1 -dependencies $false -name "NAME"
#   dependencies -> Boolean: if true install Node.js and npm 
#   name -> the name for wsl

param (
  [String]$name = "kraftwerk"
 )

Write-Host "Install dependencies..."
# Win: Donwload und install EXE from https://github.com/coreybutler/nvm-windows/releases automatically
winget install CoreyButler.NVMforWindows

# Install neccessary dependencies if needed
# Install latest version Node.js and npm and devcontainer-cli

# Install Node LTS version
nvm install lts
nvm use lts
# update npm
npm install -g npm@latest
# Check installations
node --version
npm --version
npm install -g @devcontainers/cli

Write-Host "Create container..."
# Actual creation container and WSL
# bei der Erstellung mehrerer Container muss der Parameter '--id-label' angepasst werden
devcontainer up --id-label temp_container=1 --workspace-folder . 

Write-Host "Export container..."
# 2>$null unterdrückt das sonst in der Variable auftretende "failed to get console mode for stdout: The handle is invalid."
$containerID = docker ps -a -q --filter "label=temp_container" 2>$null
Write-Host "ContainerID: " $containerID#
docker export $containerID -o rootfs.tar.gz

Write-Host "...and create Subsystem and restarting WSL..."
wsl --import $name . .\rootfs.tar.gz
wsl -d $name 

Write-Host "Finish."
