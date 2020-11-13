Add-Type -TypeDefinition @"
using System;
using System.Diagnostics;
using System.Runtime.InteropServices;

public static class ntdll
{
    [DllImport("ntdll.dll", PreserveSig = false)]
    public static extern void NtSuspendProcess(IntPtr processHandle);
    [DllImport("ntdll.dll", PreserveSig = false, SetLastError = true)]
    public static extern void NtResumeProcess(IntPtr processHandle);
}
public static class kernel32
{
    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern IntPtr OpenProcess(ProcessAccessFlags processAccess,bool bInheritHandle,int processId);
    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern bool CloseHandle(IntPtr hObject);
}

[Flags]
public enum ProcessAccessFlags : uint
{
    All = 0x001F0FFF,
    Terminate = 0x00000001,
    CreateThread = 0x00000002,
    VirtualMemoryOperation = 0x00000008,
    VirtualMemoryRead = 0x00000010,
    VirtualMemoryWrite = 0x00000020,
    DuplicateHandle = 0x00000040,
    CreateProcess = 0x000000080,
    SetQuota = 0x00000100,
    SetInformation = 0x00000200,
    QueryInformation = 0x00000400,
    QueryLimitedInformation = 0x00001000,
    Synchronize = 0x00100000
}
"@

function Suspend-Process {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline = $True)]
        [ValidateNotNullorEmpty()]
        [Alias('ID')]
        [string]
        $Name
    )

    $isPID = $true
    $ProcessID = $null

    try {
        $ProcessID = [int]$Name
    }
    catch {
        $isPID = $false
    }

    if($isPID)
    {
        $Process = get-process -Id $ProcessID
    }
    else {
        $Process = get-process -Name $Name
    }

    if($Process)
    {
        $handle = [kernel32]::OpenProcess("ALL",$false,($Process.Id))

        [ntdll]::NtSuspendProcess($handle)

        [kernel32]::CloseHandle($handle)
    }

}

function Resume-Process {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline = $True)]
        [ValidateNotNullorEmpty()]
        [Alias('ID')]
        [string]
        $Name
    )

    $isPID = $true
    $ProcessID = $null

    try {
        $ProcessID = [int]$Name
    }
    catch {
        $isPID = $false
    }

    if($isPID)
    {
        $Process = get-process -Id $ProcessID
    }
    else {
        $Process = get-process -Name $Name
    }

    if($Process)
    {
        $handle = [kernel32]::OpenProcess("ALL",$false,($Process.Id))

        [ntdll]::NtResumeProcess($handle)

        [kernel32]::CloseHandle($handle)
    }

}