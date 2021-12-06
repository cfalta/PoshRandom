function New-Password([int]$Length)
{
    if($Length -gt 0)
    {
        $Alphabet = @("0","1","2","3","4","5","6","7","8","9",":",";","<","=",">","?","!","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","_","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
        
        for($i=1;$i -le $Length;$i++)
        {
            $Password += $Alphabet | Get-Random    
        }

        return($Password)
    }
}