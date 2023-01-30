# Let's install some dotfiles
# Are you ready?

$GitHubRepositoryUri = "https://github.com/${GitHubRepositoryAuthor}/${GitHubRepositoryName}/archive/refs/heads/main.zip";
$DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles";
$ZipRepositoryFile = Join-Path -Path $DotfilesFolder -ChildPath "${GitHubRepositoryName}-main.zip";
$DotfilesWorkFolder = Join-Path -Path $DotfilesFolder -ChildPath "${GitHubRepositoryName}-main" | Join-Path -ChildPath "src";
$DownloadResult = $FALSE;
