function Install-Chocolatey {
    Set-ExecutionPolicy Bypass -Scope Process -Force;
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

function Install-FromChocolatey {
    param(
        [string]
        [Parameter(Mandatory = $true)]
        $PackageName
    )

    choco install $PackageName --yes
}

function Install-PowerShellModule {
    param(
        [string]
        [Parameter(Mandatory = $true)]
        $ModuleName,

        [ScriptBlock]
        [Parameter(Mandatory = $true)]
        $PostInstall = {}
    )

    if (!(Get-Command -Name $ModuleName -ErrorAction SilentlyContinue)) {
        Write-Host "Installing $ModuleName"
        Install-Module -Name $ModuleName -Scope CurrentUser -Confirm $true
        Import-Module $ModuleName -Confirm

        Invoke-Command -ScriptBlock $PostInstall
    } else {
        Write-Host "$ModuleName was already installed, skipping"
    }
}

Install-Chocolatey

Install-FromChocolatey 'git'
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/icalzone/system-initialization/master/common/.gitconfig' -OutFile (Join-Path $env:USERPROFILE '.gitconfig')

Install-FromChocolatey 'firefox'
Install-FromChocolatey 'googlechrome'
Install-FromChocolatey 'dotnet4.7.2'
Install-FromChocolatey 'nvm'
Install-FromChocolatey 'nodejs'
Install-FromChocolatey 'visualstudio2019enterprise'
Install-FromChocolatey 'vscode'
Install-FromChocolatey 'sql-server-2019'
Install-FromChocolatey 'sql-server-management-studio'
Install-FromChocolatey 'sourcetree'
Install-FromChocolatey 'microsoftazurestorageexplorer'
Install-FromChocolatey '7zip'
Install-FromChocolatey 'notepadplusplus'
Install-FromChocolatey 'microsoft-windows-terminal'
Install-FromChocolatey 'fiddler'
Install-FromChocolatey 'postman'
Install-FromChocolatey 'linqpad'
# Install-FromChocolatey 'wireshark'

Install-PowerShellModule 'Posh-Git' { Add-PoshGitToProfile -AllHosts }
Install-PowerShellModule 'nvm' {
    Install-NodeVersion latest
    Set-NodeVersion -Persist User latest
}
