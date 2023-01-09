function Install-Python {
  choco install -y python3
  python --version
  python -m pip install --upgrade pip
}

Install-Python;