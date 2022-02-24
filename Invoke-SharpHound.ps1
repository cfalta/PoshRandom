function Invoke-SharpHound([string]$Command)
{
$Assembly = [System.Reflection.Assembly]::Load([Convert]::FromBase64String($Message))
$vars = New-Object System.Collections.Generic.List[System.Object]

foreach ($args in $Command.Split(" "))
{
    $vars.Add($args)
}

$passed = [string[]]$vars.ToArray()
$BindingFlags= [Reflection.BindingFlags] "NonPublic,Static"
$PrivateMethod = [Sharphound.Program].GetMethod('<Main>',$bindingFlags)
$PrivateMethod.Invoke($Null,@(,$passed))
}