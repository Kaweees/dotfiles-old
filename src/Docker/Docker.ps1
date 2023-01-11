function Install-Docker {
  choco install -y "docker-desktop" --execution-timeout 3600;
}

function Install-Docker-Compose {
  choco install -y "docker-compose" --execution-timeout 3600;
}

Install-Docker;
Install-Docker-Compose;