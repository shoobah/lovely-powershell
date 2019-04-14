# Configurate colors with concfg
concfg import 'https://raw.githubusercontent.com/krokofant/lovely-powershell/master/Hitchens.json'

# Install fonts
## Workaround wget
$AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
[Net.ServicePointManager]::SecurityProtocol = $AllProtocols

## Install powerline fonts
$tempFolder = Join-Path -Resolve .\lp-temp\ ""
function download {
    Invoke-WebRequest -Headers @{"Cache-Control" = "no-cache" } $($args[0]) -OutFile $($tempFolder + $args[1])
}

New-Item lp-temp -ItemType Directory
download 'https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Bold/complete/Hack%20Bold%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf?raw=true' 'HackBold.ttf'
download 'https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/BoldItalic/complete/Hack%20Bold%20Italic%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf?raw=true' 'HackBoldItalic.ttf'
download 'https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Italic/complete/Hack%20Italic%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf?raw=true' 'HackItalic.ttf'
download 'https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf?raw=true' 'HackRegular.ttf'

$FONTS = 0x14
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace($FONTS)
$objFolder.CopyHere($objShell.Namespace($tempFolder).Items())

Remove-Item .\lp-temp -Force -Recurse
