function Install-OhMyPosh {
  scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
  Import-Module -Name "posh-git" -Repository "PSGallery";
  Import-Module "Terminal-Icons";
  Import-Module "PSReadLine";
  Install-Module -Name "Terminal-Icons" -Repository "PSGallery";
  Install-Module -Name "PSWebSearch" -Repository "PSGallery";
  Install-Module -Name "PSReadLine" -Repository "PSGallery" -RequiredVersion 2.1.0;
}