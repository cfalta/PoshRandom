# PoshRandom

A not-at-all-ordered compilation of random security-related powershell scripts. Things land here if I don't know where else to put them ;-)

Here's a snapshot of what's in there at the moment:

* __Disable-AMSI:__ function to disable AMSI for the current process
* __Invoke-Rubeus:__ powershell wrapper for Ghostpack Rubeus by @harmj0y
* __Invoke-Profiler:__ an old AD Recon tool. Propably doesn't work any more - work in progress
* __ProcessReparent:__ contains "Start-ProcessWithFakeParent", which allows you to fake the parent process on a new process you start. Shamelessly copied from the great rasta-mouse.
* __ProcessSuspendResume:__ allows you to invoke "Suspend-Process" and "Resume-Process" (like Process Explorer does to suspend a process) 