#.NET stub shamelessly copied from the great rasta-mouse https://gist.github.com/rasta-mouse/af009f49229c856dc26e3a243db185ec
Add-Type -TypeDefinition @"
using System;
using System.Diagnostics;
using System.Runtime.InteropServices;

    public class ProcessReparent
    {
        public static void Start(string ProcPath, int ProcID)
        {
            var startInfoEx = new Win32.STARTUPINFOEX();
            var processInfo = new Win32.PROCESS_INFORMATION();
            
            startInfoEx.StartupInfo.cb = (uint)Marshal.SizeOf(startInfoEx);

            var lpValue = Marshal.AllocHGlobal(IntPtr.Size);

            try
            {
                var processSecurity = new Win32.SECURITY_ATTRIBUTES();
                var threadSecurity = new Win32.SECURITY_ATTRIBUTES();
                processSecurity.nLength = Marshal.SizeOf(processSecurity);
                threadSecurity.nLength = Marshal.SizeOf(threadSecurity);

                var lpSize = IntPtr.Zero;
                Win32.InitializeProcThreadAttributeList(IntPtr.Zero, 2, 0, ref lpSize);
                startInfoEx.lpAttributeList = Marshal.AllocHGlobal(lpSize);
                Win32.InitializeProcThreadAttributeList(startInfoEx.lpAttributeList, 2, 0, ref lpSize);

                var parentHandle = Process.GetProcessById(ProcID).Handle;
                lpValue = Marshal.AllocHGlobal(IntPtr.Size);
                Marshal.WriteIntPtr(lpValue, parentHandle);

                Win32.UpdateProcThreadAttribute(
                    startInfoEx.lpAttributeList,
                    0,
                    (IntPtr)Win32.ProcThreadAttribute.PARENT_PROCESS,
                    lpValue,
                    (IntPtr)IntPtr.Size,
                    IntPtr.Zero,
                    IntPtr.Zero
                    );

                Win32.CreateProcess(
                    ProcPath,
                    null,
                    ref processSecurity,
                    ref threadSecurity,
                    false,
                    Win32.CreationFlags.ExtendedStartupInfoPresent,
                    IntPtr.Zero,
                    null,
                    ref startInfoEx,
                    out processInfo
                    );
            }
            catch (Exception e)
            {
                Console.Error.WriteLine(e.StackTrace);
            }
            finally
            {
                Win32.DeleteProcThreadAttributeList(startInfoEx.lpAttributeList);
                Marshal.FreeHGlobal(startInfoEx.lpAttributeList);
                Marshal.FreeHGlobal(lpValue);

                Console.WriteLine("{0} started", processInfo.dwProcessId);
            }
        }
    }

    class Win32
    {
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool InitializeProcThreadAttributeList(IntPtr lpAttributeList, int dwAttributeCount, int dwFlags, ref IntPtr lpSize);

        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool UpdateProcThreadAttribute(IntPtr lpAttributeList, uint dwFlags, IntPtr Attribute, IntPtr lpValue, IntPtr cbSize, IntPtr lpPreviousValue, IntPtr lpReturnSize);

        [DllImport("kernel32.dll")]
        public static extern bool CreateProcess(string lpApplicationName, string lpCommandLine, ref SECURITY_ATTRIBUTES lpProcessAttributes, ref SECURITY_ATTRIBUTES lpThreadAttributes, bool bInheritHandles, CreationFlags dwCreationFlags, IntPtr lpEnvironment, string lpCurrentDirectory, [In] ref STARTUPINFOEX lpStartupInfo, out PROCESS_INFORMATION lpProcessInformation);

        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool DeleteProcThreadAttributeList(IntPtr lpAttributeList);

        [StructLayout(LayoutKind.Sequential)]
        public struct PROCESS_INFORMATION
        {
            public IntPtr hProcess;
            public IntPtr hThread;
            public int dwProcessId;
            public int dwThreadId;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct STARTUPINFO
        {
            public uint cb;
            public IntPtr lpReserved;
            public IntPtr lpDesktop;
            public IntPtr lpTitle;
            public uint dwX;
            public uint dwY;
            public uint dwXSize;
            public uint dwYSize;
            public uint dwXCountChars;
            public uint dwYCountChars;
            public uint dwFillAttributes;
            public uint dwFlags;
            public ushort wShowWindow;
            public ushort cbReserved;
            public IntPtr lpReserved2;
            public IntPtr hStdInput;
            public IntPtr hStdOutput;
            public IntPtr hStdErr;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct STARTUPINFOEX
        {
            public STARTUPINFO StartupInfo;
            public IntPtr lpAttributeList;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct SECURITY_ATTRIBUTES
        {
            public int nLength;
            public IntPtr lpSecurityDescriptor;
            public int bInheritHandle;
        }

        [Flags]
        public enum ProcThreadAttribute : int
        {
            MITIGATION_POLICY = 0x20007,
            PARENT_PROCESS = 0x00020000
        }
        
        [Flags]
        public enum CreationFlags : uint
        {
            CreateSuspended = 0x00000004,
            DetachedProcess = 0x00000008,
            CreateNoWindow = 0x08000000,
            ExtendedStartupInfoPresent = 0x00080000
        }
}
"@

function Start-ProcessWithFakeParent {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_})]
        [string]
        $Path,
        
        [Parameter(Mandatory=$true)]
        [ValidateNotNullorEmpty()]
        [Alias('ID')]
        [string]
        $ParentProcess
    )

    $isPID = $true
    $ProcessID = $null

    try {
        $ProcessID = [int]$ParentProcess
    }
    catch {
        $isPID = $false
    }

    if($isPID)
    {
        $Process = get-process -Id $ProcessID
    }
    else {
        $Process = get-process -Name $ParentProcess
    }

    if($Process)
    {
        if($Process.Count -gt 1)
        {
            Write-Error "Possible parents count is greater than 1. Try to use process id instead of name."
        }
        else {
            [ProcessReparent]::Start($Path,($Process.Id))
        }
    }

}