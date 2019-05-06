<#
.SYNOPSIS
The template gives a good starting point for creating powershell functions and tools.
Start your design with writing out the examples as a functional spesification.
.DESCRIPTION
.PARAMETER
.EXAMPLE
Test-CustomConnection -ComputerName SRV1 -PING -WinRM -WSMan -Dcom -RDP -ErrorLogFilePath
.EXAMPLE
Test-CustomConnection -ComputerName (Get-Content c:\servers.txt) -PING -WinRM -WSMan -Dcom -RDP -ErrorLogFilePath
#>

function Test-CustomConnection {
    [CmdletBinding()]
    #^ Optional ..Binding(SupportShouldProcess=$True,ConfirmImpact='Low')
    param (
    [Parameter(Mandatory=$True,
        ValueFromPipeline=$True,
        ValueFromPipelineByPropertyName=$True)]
    [Alias('CN','MachineName','HostName','Name')]
    [string[]]$ComputerName
    )

BEGIN {
    # Intentionaly left empty.
    # Provides optional one-time pre-processing for the function.
    # Setup tasks such as opening database connections, setting up log files, or initializing arrays.
}

PROCESS {
    # Provides record-by-record processing for the function.
}


END {
    # Intentionaly left empty.
    # This block is used to provide one-time post-processing for the function.
}

} #Function