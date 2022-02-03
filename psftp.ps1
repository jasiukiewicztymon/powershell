$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
Write-Output $scriptPath
Write-Output "Connect your ftp";
Write-Output "";
Write-Output "[1] - Connect new profil";
Write-Output "[2] - Connect a profil";
Write-Output "[3] - Exit";
Write-Output "";
$choice = Read-Host ;

Clear-Host

switch ($choice) {
    1 {
        $hostname = Read-Host -Prompt 'Host';
        $username = Read-Host -Prompt 'User';
        $password = Read-host 'Password' -AsSecureString;

        $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
        $unpassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

        $output = "$hostname`n$username`n$unpassword"

        if (Test-Path -Path ".\FTP") {
        } else {
            New-Item -Path "." -Name "FTP" -ItemType "directory" -Force 
        }

        New-Item -Path ".\FTP\connect.sav" -Value $output -ItemType File -Force
        Clear-Host

        Write-Output 'Do you want do save the profil? [y/n]';
        Write-Output "";
        $save = Read-Host;
        
        if ($save -eq "y") {
            Clear-Host
            $profilname = Read-Host -Prompt 'Profil name';
            $savepath = ".\FTP\Profil\$profilname"

            $securehostname = $hostname | ConvertTo-SecureString -AsPlainText -Force
            $encryptedhostname = $securehostname | ConvertFrom-SecureString

            $secureusername = $username | ConvertTo-SecureString -AsPlainText -Force
            $encryptedusername = $secureusername | ConvertFrom-SecureString

            $secureunpassword = $unpassword | ConvertTo-SecureString -AsPlainText -Force
            $encryptedunpassword = $secureunpassword | ConvertFrom-SecureString

            $saveoutput = "$profilname,$encryptedhostname,$encryptedusername,$encryptedunpassword"

            New-Item -Path $savepath -Value $saveoutput -ItemType File -Force | Out-Null
        }
        else {
            if ($save -eq "Y") {
                Clear-Host
                $profilname = Read-Host -Prompt 'Profil name';
                $savepath = ".\FTP\Profil\$profilname"

                $securehostname = $hostname | ConvertTo-SecureString -AsPlainText -Force
                $encryptedhostname = $securehostname | ConvertFrom-SecureString

                $secureusername = $username | ConvertTo-SecureString -AsPlainText -Force
                $encryptedusername = $secureusername | ConvertFrom-SecureString

                $secureunpassword = $unpassword | ConvertTo-SecureString -AsPlainText -Force
                $encryptedunpassword = $secureunpassword | ConvertFrom-SecureString

                $saveoutput = "$profilname,$encryptedhostname,$encryptedusername,$encryptedunpassword"

                New-Item -Path $savepath -Value $saveoutput -ItemType File -Force | Out-Null
            }
        }

        Clear-Host
    }
    2 {
        $profilname = Read-Host -Prompt 'Profil name';
        $profilpassword = Read-host 'Password' -AsSecureString;



        Clear-Host
    }
    default {
        Clear-Host;
    }
}