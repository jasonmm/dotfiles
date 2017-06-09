Set-ExecutionPolicy remoteSigned
Import-Module PSReadLine
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

#
# Customize the command prompt. Note, this assumes that Post-Git is 
# installed (and it should be).
#
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Shrink the path for some directories.
    # Home directory shows as "~".
    # Subdirectories of Home shows as "~/<dir path>", e.g. "~/Documents".
    $cd = (Get-Location).ToString()
    if( $env:Home.Length -le $cd.Length -and $cd.Substring(0, $env:Home.Length) -eq $env:Home ) {
        $subStringLen = $env:Home.Length + "\Code".Length
        $cd = (Get-Location).ToString();
	    if( $subStringLen -le $cd.Length -and $cd.Substring(0, $subStringLen) -eq ($env:Home + "\Code") ) {
            Write-Host "[Code]" -NoNewline -ForegroundColor DarkGray
            $dirStr = $(Get-Location).ToString().Substring($subStringLen)
            Write-Host $dirStr -NoNewLine 
        } else {
            $cd = $cd.Replace($env:Home, "~")
            Write-Host $cd -NoNewline
        }
    } else {
        Write-Host($pwd.ProviderPath) -nonewline
    }
 
	# Write-VcsStatus gets the posh-git info, see http://www.dpetzel.info/tips/windows/2015/01/03/modifying-your-poshgit-prompt.html 
	Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
	
    return "> "
}

Start-SshAgent -Quiet
