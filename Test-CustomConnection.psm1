<#
.SYNOPSIS
The template gives a good starting point for creating powershell functions and tools.
Start your design with writing out the examples as a functional spesification.
.DESCRIPTION
.PARAMETER
.EXAMPLE
Test-CustomConnection -ComputerName SRV1 -PING -WinRM -WSMan -Dcom -RDP -ErrorLogFilePath
.EXAMPLE
Test-CustomConnection -ComputerName SRV1 -Ping -PingBufferSize -PingCount
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
    [string[]]$ComputerName,

    [Parameter(Mandatory=$false)]
    [switch]$Ping,

    [Parameter(Mandatory=$false)]
    [int32]$PingCount = 4,

    [Parameter(Mandatory=$false)]
    [int32]$PingBufferSize = 4,

    [Parameter(Mandatory=$false)]
    [switch]$WsMan
    )

BEGIN {
    # Intentionaly left empty.
    # Provides optional one-time pre-processing for the function.
    # Setup tasks such as opening database connections, setting up log files, or initializing arrays.
}

PROCESS {
    try{
        #Define a progress variabl
        $ProgressTotal = ($ComputerName).Count
        $ProgressNum = 0

        #Check each computer
        foreach($computer in $ComputerName){
            #Create our object
            $ComputerObj = New-Object psobject -Property @{'ComputerName'=$computer}
            
            Write-Verbose "$computer is number $ProgressNum of $ProgressTotal."

            #Run ping test if specified by parameter
            if($PSBoundParameters.ContainsKey('Ping')){
                Write-Verbose "$computer : running ping test."
                $PingTest = Test-Connection -ComputerName $computer -BufferSize $PingBufferSize -Count $PingCount -Quiet

                #If pingtest succesfull
                if($PingTest){
                    Add-Member -InputObject $ComputerObj -MemberType NoteProperty -Name 'Ping' -Value 'Succesfull'     
                } #if

                #If pingtest failed
                elseif ($pingtest -eq $false){
                    Add-Member -InputObject $ComputerObj -MemberType NoteProperty -Name 'Ping' -Value 'Failed'
                }
            } #If

            #Run WsMan test if specified by parameter
            if($PSBoundParameters.ContainsKey('WsMan')){
                Write-Verbose "$computer : running WsMan test."
            }

            #Output our object to the pipeline
            $ComputerObj
        } #Foreach computer
    } #Try
    Catch{

    } #Catch
}


END {
    # Intentionaly left empty.
    # This block is used to provide one-time post-processing for the function.
}

} #Function