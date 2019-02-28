function Update-Link([string]$SourcePath, [string]$TargetPath) {
  $TargetFile = Get-Item $TargetPath -ErrorAction SilentlyContinue

  if ($null -eq $TargetFile) {
    New-Item -ItemType Directory $(Split-Path $TargetPath) -ErrorAction SilentlyContinue | Out-Null
  } elseif ([bool]($TargetFile.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
    Remove-Item $TargetPath
    $TargetFile = $null
  }

  if ($null -eq $TargetFile) {
    Write-Host -ForegroundColor "Green"("{0} -> {1}" -f $TargetPath, $SourcePath)
    $SourceFullPath = $([IO.Path]::GetFullPath($(Join-Path $PSScriptRoot $SourcePath)))
    New-Item -ItemType "SymbolicLink" -Path $TargetPath -Value $SourceFullPath | Out-Null
  } else {
    Write-Host -ForegroundColor "Red" ("{0} already exists, skipping." -f $TargetPath)
  }
}

$ApplicationData = [Environment]::GetFolderPath([Environment+SpecialFolder]::ApplicationData)

Update-Link -SourcePath "Profile.ps1" -TargetPath $profile.CurrentUserAllHosts
Update-Link -SourcePath "emacs.d" -TargetPath $(Join-Path $ApplicationData ".emacs.d")
Update-Link -SourcePath "spacemacs" -TargetPath $(Join-Path $ApplicationData ".spacemacs")
Update-Link -SourcePath "spacemacs-layers" -TargetPath $(Join-Path $ApplicationData ".spacemacs-layers")
Update-Link -SourcePath "code.json" -TargetPath $(Join-Path $ApplicationData "Code" "User" "settings.json")
Update-Link -SourcePath "gitconfig" -TargetPath $(Join-Path $HOME ".gitconfig")
Update-Link -SourcePath "gitignore" -TargetPath $(Join-Path $HOME ".gitignore")
