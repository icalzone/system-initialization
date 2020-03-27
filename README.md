# system-initialization

Different scripts for setting up different types of machines.

The Windows Subsystem for Linux (WSL) gives the ability to run Linux bash on a Windows computer, and gives the ability to do pretty much everything you would normally do.

Windows Subsystem for Linux
https://docs.microsoft.com/en-us/windows/wsl/about?WT.mc_id=aaronpowell-blog-aapowell

WSL2
https://docs.microsoft.com/en-us/windows/wsl/wsl2-install?WT.mc_id=aaronpowell-blog-aapowell

- Run the following command in Powershell as an Administrator
  
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

- Make sure you restart your computer once that's done
- Install Ubuntu from the Microsoft Store https://www.microsoft.com/en-au/p/ubuntu-1804-lts/9n9tngvndl3q?activetab=pivot:overviewtab. There are a few different versions so install what you like, but the unversioned one (Ubuntu) will install the latest version
- Open up the Ubuntu app and follow the instructions to set up your new user
- Pro tip: make note of the password you set, you will need to use that in future



Windows - PowerShell script

To simplify the install of software on Windows I use Chocolatey for most of the stuff I want to install:

Git
    .gitconfig in the repo
VS Code Insiders (I want the bleeding edge!)
    I sign into the preview Settings Sync feature and VS Code is all setup for me
Fiddler (web proxy/network debugger)
Postman
LINQPad
Firefox
Google Chrome



I manually install Edge Canary as it's the first thing I install.

There's a few other things I'll manually install as they ship via the Windows Store and automating installs from that is a bit trickier:

Windows Terminal (I want a decent terminal)
    I keep my settings for Terminal in the repo and copy them in once installed
Cascadia Code PL font
Ubuntu as my WSL distro
Visual Studio Preview (I'm too lazy to work out how to automate the install of that)
Xenu



Once the applications are installed I install a few PowerShell modules from PowerShell Gallery:

Posh-Git
    Show the git status in the PowerShell prompt
PowerShell nvm
    A Node Version Manager using PowerShell semantics that I wrote

The README.md has the command to run to install it (from an admin PowerShell prompt).



WSL
I don't automate the activation of WSL2, mainly because it requires a reboot so I have to interact with the machine anyway and then I can control when I do it, but once WSL2 is activated and the Ubuntu distro installed I kick off the setup.sh bash script. This was originally written to setup WSL or Linux as a primary OS, so there's some old code in there, but the main stuff I run is:

1 - install_git
2 - install_shell
3 - install_docker
4 - install_devtools

I also kick off an sudo apt-get update && sudo apt-get upgrade to ensure I am all up to date.

This installs:

git
    I pull down the same .gitconfig as I use on Windows but change autocrlf to false and set the path of the credential helper to the Git Credential Manager for Windows which allows me to use the same git credentials from WSL2 and Windows, and also gives me the nice MFA prompt through to GitHub (I prefer username/password/MFA over ssh keys)
zsh and oh my zsh
    My .zshrc is in the repo
tmux (a terminal multiplexer, basically makes my terminal more powerful)
Docker (using the standard Ubuntu install)
.NET Core SDK (2.2 LTS and 3.1 LTS)
    I prompt to install the v5 preview too
Optionally install Golang
fnm which is a simple Node Version Manager