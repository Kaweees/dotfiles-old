function Install-VimPlug {
  $VimPlugFilePath = "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim/autoload/plug.vim";
  if (-not (Test-Path -Path $VimPlugFilePath)) {
    Write-Host "Installing Vim-Plug:" -ForegroundColor "Green";
    Invoke-WebRequest -useb "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" | New-Item $VimPlugFilePath -Force;
  }
  else {
    Write-Host "Vim-Plug is already installed." -ForegroundColor "Green";
  }
}