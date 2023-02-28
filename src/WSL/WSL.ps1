function Install-WSL {
  wsl --install Debian
  wsl --set-default-version 2
  wsl --update
  wsl --shutdown
  wsl echo "nameserver 1.1.1.1" | sudo tee -a /etc/resolv.conf >/dev/null
  wsl sudo apt update && sudo apt upgrade -y
  wsl sudo apt install gedit -y
  wsl sudo apt install gimp -y
  wsl sudo apt install nautilus -y
  wsl sudo apt install vlc -y
  wsl sudo apt install x11-apps -y
  wsl sudo apt install x11-xserver-utils -y
}

function Update-WSL-Packages-Repository {
  Write-Host "Updating WSL package repository:" -ForegroundColor "Green";
  wsl sudo apt --yes update;
}

function Update-WSL-Packages {
  Write-Host "Upgrading WSL packages:" -ForegroundColor "Green";
  wsl sudo apt --yes upgrade;
}

function Install-WSL-Package {
  [CmdletBinding()]
  param(
    [Parameter(Position=0, Mandatory=$TRUE)][string]$PackageName
  )
  Write-Host "Installing ${PackageName} in WSL:" -ForegroundColor "Green";
  wsl sudo apt install --yes --no-install-recommends $PackageName;
}

function Set-Git-Configuration-In-WSL {
  Write-Host "Configuring Git in WSL:" -ForegroundColor "Green";
  wsl git config --global init.defaultBranch "main";
  wsl git config --global user.name $Config.GitUserName;
  wsl git config --global user.email $Config.GitUserEmail;
  wsl git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe";
  wsl git config --list;
  Write-Host "Git was successfully configured in WSL." -ForegroundColor "Green";
}

function Install-VSCode-Extensions-In-WSL {
  Write-Host "Installing Visual Studio Code extensions in WSL:" -ForegroundColor "Green";
  wsl code --install-extension ue.alphabetical-sorter;
  wsl code --install-extension ms-azuretools.vscode-docker;
  wsl code --install-extension dbaeumer.vscode-eslint;
  wsl code --install-extension eamodio.gitlens;
  wsl code --install-extension golang.go;
  wsl code --install-extension oderwat.indent-rainbow;
  wsl code --install-extension ritwickdey.liveserver;
  wsl code --install-extension davidanson.vscode-markdownlint;
  wsl code --install-extension esbenp.prettier-vscode;
  wsl code --install-extension jock.svg;
  wsl code --install-extension bradlc.vscode-tailwindcss;
  wsl code --install-extension rangav.vscode-thunder-client;
}

function Install-Volta-In-WSL {
  $DotfilesVoltaInstallerPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath "volta.sh";
  Invoke-WebRequest -o $DotfilesVoltaInstallerPath https://get.volta.sh;
  $WslVoltaInstallerPath = wsl wslpath $DotfilesVoltaInstallerPath.Replace("\", "\\");
  Write-Host "Installing Volta in WSL:" -ForegroundColor "Green";
  wsl bash $WslVoltaInstallerPath;
}

function Install-Nodejs-Packages-In-WSL {
  Write-Host "Installing Node.js LTS in WSL:" -ForegroundColor "Green";
  wsl ~/.volta/bin/volta install node;
  Write-Host "Installing NPM in WSL:" -ForegroundColor "Green";
  wsl ~/.volta/bin/volta install npm;
  Write-Host "Installing Yarn in WSL:" -ForegroundColor "Green";
  wsl ~/.volta/bin/volta install yarn;
  Write-Host "Installing TypeScript in WSL:" -ForegroundColor "Green";
  wsl ~/.volta/bin/volta install typescript;
  Write-Host "Installing Yarn-Upgrade-All in WSL:" -ForegroundColor "Green";
  wsl ~/.volta/bin/volta install yarn-upgrade-all;
  Write-Host "Installing NestJS CLI in WSL:" -ForegroundColor "Green";
  wsl ~/.volta/bin/volta install @nestjs/cli;
}

function Install-Golang-In-WSL {
  Write-Host "Installing Golang in WSL:" -ForegroundColor "Green";
  wsl sudo apt install --yes --no-install-recommends golang-go;
}

function Install-Hugo-In-WSL {
  $HugoReleasesUri = "https://api.github.com/repos/gohugoio/hugo/releases";
  $DownloadHugo = $FALSE;
  Write-Host "Checking the latest version of Hugo:" -ForegroundColor "Green";
  $HugoLastVersion = (Invoke-WebRequest $HugoReleasesUri | ConvertFrom-Json)[0].tag_name.Replace("v", "");
  Write-Host "Latest Hugo version is ${HugoLastVersion}" -ForegroundColor "Green";
  $HugoDownloadUri = "https://github.com/gohugoio/hugo/releases/download/v${HugoLastVersion}/hugo_${HugoLastVersion}_Linux-64bit.deb";
  Write-Host "Download url is ${HugoDownloadUri}" -ForegroundColor "Green";
  $DotfilesHugoInstallerPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath "hugo-installer-${HugoLastVersion}.deb";

  if (-not (wsl hugo version)) {
    $DownloadHugo = $TRUE;
    Write-Host "Hugo is not installed in WSL." -ForegroundColor "Green";
  }
  else {
    $InstalledHugoFullVersion = wsl hugo version;
    $InstalledHugoFullVersion -match "(\d\.[\d]+\.\d)";
    $InstalledHugoVersion = $Matches[1];

    Write-Host "Installed Hugo version is ${InstalledHugoVersion}." -ForegroundColor "Green";

    if (-not ($InstalledHugoVersion -ge $HugoLastVersion)) {
      $DownloadHugo = $TRUE;
      Write-Host "Hugo must be updated." -ForegroundColor "Green";
    }
  }

  if ($DownloadHugo) {
    if (-not (Test-Path $DotfilesHugoInstallerPath)) {
      Write-Host "Downloading Hugo installer:" -ForegroundColor "Green";
      Invoke-WebRequest $HugoDownloadUri -O $DotfilesHugoInstallerPath;
    }

    $WslHugoInstallerPath = wsl wslpath $DotfilesHugoInstallerPath.Replace("\", "\\");

    Write-Host "Installing Hugo in WSL:" -ForegroundColor "Green";
    wsl sudo dpkg -i $WslHugoInstallerPath;
    wsl sudo apt install -f $WslHugoInstallerPath;
  }
  else {
    Write-Host "No need to update Hugo in WSL." -ForegroundColor "Green";
  }
}

function Install-Plug-Vim-In-WSL {
  Write-Host "Installing Vim-Plug in WSL:" -ForegroundColor "Green";

  wsl mkdir -p -v ~/.vim/autoload;
  wsl curl -L -o ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
}

function Copy-Initial-Vimrc-In-WSL {
  $DotfilesInitialVimrcPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Vim" | Join-Path -ChildPath "initial.vimrc";
  $WslVimrcPath = wsl wslpath $DotfilesInitialVimrcPath.Replace("\", "\\");

  if (-not((wsl wslpath -w ~/.vimrc))) {
    Write-Host "Copying initial Vim configuration file in WSL:" -ForegroundColor "Green";
    
    wsl cp -R $WslVimrcPath ~/.vimrc;
    
    $WindowsVimrcPath = wsl wslpath -w ~/.vimrc;

    # Convert token strings
    (Get-Content -path $WindowsVimrcPath) -replace "__VIM_PLUGGED__", "~/.vim/plugged" | Set-Content -Path $WindowsVimrcPath;

    # Convert line endings to Linux (CRLF -> LF)
    ((Get-Content $WindowsVimrcPath) -join "`n") + "`n" | Set-Content -NoNewline $WindowsVimrcPath;
  }
}

function Install-Vim-Plugins-In-WSL {
  Write-Host "Installing Vim plugins in WSL:" -ForegroundColor "Green";
  wsl vim +PlugInstall +qall;
}

function Copy-Final-Vimrc-In-WSL {
  $DotfilesFinalVimrcPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "Vim" | Join-Path -ChildPath "final.vimrc";
  $WslVimrcPath = wsl wslpath $DotfilesFinalVimrcPath.Replace("\", "\\");

  Write-Host "Copying final Vim configuration file in WSL:" -ForegroundColor "Green";

  wsl cp -R $WslVimrcPath ~/.vimrc;

  $WindowsVimrcPath = wsl wslpath -w ~/.vimrc;

  # Convert token strings
  (Get-Content -path $WindowsVimrcPath) -replace "__VIM_PLUGGED__", "~/.vim/plugged" | Set-Content -Path $WindowsVimrcPath;
  (Get-Content -path $WindowsVimrcPath) -replace "__STARTIFY_BOOKMARKS__", "[ { 'v': '~/.vimrc' }, { 'z': '~/.zshrc' }, { 'o': '~/.oh-my-zsh' }, { 't': '~/.oh-my-zsh/custom/themes' }, { 'f': '~/.oh-my-zsh/custom/functions' } ]" | Set-Content -Path $WindowsVimrcPath;
  (Get-Content -path $WindowsVimrcPath) -replace "__VIM_SESSION__", "~/.vim/session" | Set-Content -Path $WindowsVimrcPath;
  (Get-Content -path $WindowsVimrcPath) -replace "__VIMRC_LOCAL__", "~/.vimrc.local" | Set-Content -Path $WindowsVimrcPath;

  # Convert line endings to Linux (CRLF -> LF)
  ((Get-Content $WindowsVimrcPath) -join "`n") + "`n" | Set-Content -NoNewline $WindowsVimrcPath;
}

function Install-OhMyZsh-In-WSL {
  $DotfilesOhMyZshInstallerPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath "ohmyzsh.sh";

  Invoke-WebRequest -o $DotfilesOhMyZshInstallerPath https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh;

  $WslOhMyZshInstallerPath = wsl wslpath $DotfilesOhMyZshInstallerPath.Replace("\", "\\");
  
  Write-Host "Installing Oh My Zsh in WSL:" -ForegroundColor "Green";
  
  wsl bash $WslOhMyZshInstallerPath --unattended;
}

function Install-Zsh-Autosuggestions {
  $ZshAutosuggestionsWslPath = "~/.oh-my-zsh/custom/plugins/zsh-autosuggestions";

  Write-Host "Installing Zsh-Autosuggestions in WSL:" -ForegroundColor "Green";

  wsl rm -rf $ZshAutosuggestionsWslPath;

  wsl git clone https://github.com/zsh-users/zsh-autosuggestions $ZshAutosuggestionsWslPath;
}

function Install-OhMyZsh-Theme-In-WSL {
  $DotfilesOhMyZshThemePath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath "paradox.zsh-theme";
  $WslOhMyZshThemePath = wsl wslpath $DotfilesOhMyZshThemePath.Replace("\", "\\");

  Write-Host "Installing Paradox theme for Oh My Zsh in WSL:" -ForegroundColor "Green";

  wsl cp -R $WslOhMyZshThemePath ~/.oh-my-zsh/custom/themes;
}

function Install-OhMyZsh-Functions-In-WSL {
  $DotfilesOhMyZshFunctionsPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath "custom-actions.sh";
  $WslOhMyZshFunctionsPath = wsl wslpath $DotfilesOhMyZshFunctionsPath.Replace("\", "\\");

  Write-Host "Installing custom alias and functions for Oh My Zsh in WSL:" -ForegroundColor "Green";

  wsl mkdir -p ~/.oh-my-zsh/custom/functions;

  wsl cp -R $WslOhMyZshFunctionsPath ~/.oh-my-zsh/custom/functions;
}

function Set-OhMyZsh-Configuration-In-WSL {
  $DotfilesZshrcPath = Join-Path -Path $DotfilesWorkFolder -ChildPath "WSL" | Join-Path -ChildPath ".zshrc";
  $WslZshrcPath = wsl wslpath $DotfilesZshrcPath.Replace("\", "\\");

  Write-Host "Configuring Zsh in WSL:" -ForegroundColor "Green";
  
  wsl cp -R $WslZshrcPath ~;
}

function Set-Zsh-As-Default-In-WSL {
  Write-Host "Changing default shell to Zsh in WSL:" -ForegroundColor "Green";

  $WslZshPath = wsl which zsh;
  wsl sudo chsh -s $WslZshPath;

  # Change just for a user: sudo chsh -s $WslZshPath $USER_NAME;
}


Install-WSL;
Update-WSL-Packages-Repository;
Update-WSL-Packages;
Install-WSL-Package -PackageName "curl";
Install-WSL-Package -PackageName "neofetch";
Install-WSL-Package -PackageName "git";
Install-WSL-Package -PackageName "vim";
Install-WSL-Package -PackageName "zsh";
Install-WSL-Package -PackageName "make";
Install-WSL-Package -PackageName "g++";
Install-WSL-Package -PackageName "gcc";

Set-Git-Configuration-In-WSL;
Install-VSCode-Extensions-In-WSL;
Install-Volta-In-WSL;
Install-Nodejs-Packages-In-WSL;
Install-Golang-In-WSL;
Install-Hugo-In-WSL;
Install-Plug-Vim-In-WSL;
Copy-Initial-Vimrc-In-WSL;
Install-Vim-Plugins-In-WSL;
Copy-Final-Vimrc-In-WSL;
Install-OhMyZsh-In-WSL;
Install-OhMyZsh-Theme-In-WSL;
Install-OhMyZsh-Functions-In-WSL;
Set-OhMyZsh-Configuration-In-WSL;
Set-Zsh-As-Default-In-WSL;