#!/usr/bin/env pwsh

function Update-Link([string]$SourcePath, [string]$TargetPath) {
  $targetFile = Get-Item -Force $TargetPath

  if ($null -eq $targetFile) {
    New-Item -ItemType Directory $(Split-Path $TargetPath) -ErrorAction SilentlyContinue | Out-Null
  } elseif ([bool]($targetFile.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
    Remove-Item -Path $TargetPath -Force
    $targetFile = $null
  }

  if ($null -eq $targetFile) {
    Write-Host -ForegroundColor "Green" ("{0} -> {1}" -f $TargetPath, $SourcePath)
    $sourceFullPath = $([IO.Path]::GetFullPath($(Join-Path $PSScriptRoot $SourcePath)))
    New-Item -ItemType "SymbolicLink" -Path $TargetPath -Value $sourceFullPath | Out-Null
  } else {
    Write-Host -ForegroundColor "Red" ("{0} already exists, skipping." -f $TargetPath)
  }
}

$platform = if ($IsWindows) { "nt" } else { "unix" }
$applicationData = [Environment]::GetFolderPath([Environment+SpecialFolder]::ApplicationData)

$links = [ordered]@{
  "fish" = @{"unix" = (Join-Path $applicationData "fish")};
  "emacs.d" = @{"unix" = (Join-Path $HOME ".emacs.d"); "nt" = (Join-Path $applicationData ".emacs.d")};
  "spacemacs.d" = @{"unix" = (Join-Path $HOME ".spacemacs.d"); "nt" = (Join-Path $applicationData ".spacemacs.d")};
  "gitconfig" = @{"all" = (Join-Path $HOME ".gitconfig")};
  "gitignore" = @{"all" = (Join-Path $HOME ".gitignore")};
}

foreach ($pair in $links.GetEnumerator()) {
  $targetPath = ($pair.Value[@($platform, "all")] | Select -First 1)
  Update-Link -SourcePath $pair.Key -TargetPath $targetPath
}

# Update-Link -SourcePath "Profile.ps1" -TargetPath $profile.CurrentUserAllHosts
# update-link -sourcepath "code.json" -targetpath $(join-path $applicationdata "code" "user" "settings.json")
