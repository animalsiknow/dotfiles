Set-StrictMode -Version "Latest"

{
  function Add-To-Path([String]$Var = "PATH", [String]$Value) {
    $OldValue = [Environment]::GetEnvironmentVariable($Var)
    if ($null -eq $OldValue) {
      [Environment]::SetEnvironmentVariable($Var, $Value)
    } else {
      [Environment]::SetEnvironmentVariable($Var, "$OldValue;$Value")
    }
  }

  $VcpkgPath = "C:\Users\simon\Documents\Source\github.com\Microsoft\vcpkg"
  Add-To-Path -Var "LIB" -Value $(Join-Path -Path $VcpkgPath -ChildPath installed\x64-windows\lib)
  Add-To-Path -Value $(Join-Path -Path $VcpkgPath -ChildPath installed\x64-windows\bin)
  Import-Module $(Join-Path -Path $VcpkgPath -ChildPath scripts\posh-vcpkg)
  Set-Alias -Scope Script -Name vcpkg -Value $(Join-Path -Path $VcpkgPath -ChildPath vcpkg)

  Add-To-Path -Value "C:\Users\simon\AppData\Local\Programs\Rebar3"
  Add-To-Path -Value "C:\Program Files (x86)\Windows Kits\10\Debuggers\x64"
  $env:LIBCLANG_PATH = "C:\Users\simon\scoop\apps\llvm\current\bin"
  $env:EI_LINK_SEARCH = "C:\Users\simon\Documents\Libraries"

  Import-Module posh-git
  $GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'

  Set-Alias -Scope Script -Name ls -Value lsd.exe
}.Invoke()
