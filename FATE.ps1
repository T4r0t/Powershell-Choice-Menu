function fate-menu
{
    param (
        [string]$Title = 'FATE'
    )
    clear-host
    write-host "================= $Title ================="
    
    write-host "1: Press '1' To know your ip address    "
    write-host "2: Press '2' Scissor,paper,rock game    "
    write-host "3: Press '3' Divine number              "
    write-host "4: Press '4' Add your friends           "
    write-host "5: Press '5' I can know your birth Year "
    write-host "6: Press '6  Check your pass security   "
    write-host "7: Press '7' The last news ?            "
    write-host "8: Press '8' To know the current date   "
    write-host "9: Press '9' Write a commentary ?       "
    write-host "Q: Press 'Q' to quit                    "

    write-host "========================================"
}

$name = (Read-host -prompt "Hello Friend, how do I call you ?")
write-host "Nice to meet you: $name" 

do{
    fate-menu
    $choice = read-host -prompt "Please, choose your fate $name"
    switch($choice){
        '1'{
            $ipa = (
                get-netipconfiguration |
                where-object{
                    $_.IPv4DefaultGateway -ne $null -and
                    $_.NetAdapter.Status -ne "Disconnected"
                }
            ).IPv4Address.IPAddress
            write-host "Here you are: $ipa"
        }
        '2'{
            $tabgame = @('scissors','paper','rock')
            $iamasterchoice = get-random -Minimum 0 -maximum 2
            write-host "Okay ! Let's start : Scissors, Paper, Rock ! $name ! But.... With new rules, if we are dealt, you win and if we're not equal you lose. Allright ?"
            $playerchoice = (read-host -prompt "Choose between Scissors(0), paper(1) or rock(2) ")
            if($iamasterchoice -eq $playerchoice){
                write-host "Ok , dealt, you win !"
            }else{
            write-host "Sorry, you lost "
            }
        }
        '3'{
            $aleos = get-random -maximum '100' 
            do{
                $first = read-host -prompt "choose your fate number between 0 and 100"
                write-host "You choose $first"
                if($first -lt $aleos){
                    write-host "Greater"
                }
                elseif($first -gt $aleos){
                    write-host "lesser"
                }
                else{
                    write-host "You Win"
                }
            }
            until($first -eq $aleos)
        }
        '4'{
            $friendsArray = [system.collections.arraylist]::new()
            do{
                $friendName = read-host -prompt "Ok, what is your friend's name?"
                $friendSurname = read-host -prompt "Ok, what is your friend surname?"
                [void]$friendsArray.add(
                [pscustomobject]@{FirstName=$friendSurname;LastName=$friendName}
                )
                $friendsArray | foreach-object{$_}
                clear-variable -name "friendName"
                clear-variable -name "friendSurname"
                $quit = read-host -prompt "Do you want to quit ? y/n"
            }
            until($quit -eq "y")
        }
        '5'{
            $age = (read-host -prompt "How old are you, $name ? ")
            $calc = ((get-date).year)-$age
            write-host "Oh you were born in: $calc"
        }
        '6'{
            $pass = read-host -prompt "let's check !!! "
            if($pass.length -ge 9){
                write-host "Ok, Maybe safe"
            }
            else{
               write-host "Not pretty safe"
            }
        }
        '7'{
            write-host "Ok let's go !"
            start-process "https://www.7sur7.be/?referrer=https%3A%2F%2Fwww.google.com%2F"
        }
        '8'{
            $date = get-date
            write-host "Here you are: $date"
        }
        '9'{
            $remark = read-host -prompt "What do you want to write ?"
            add-content -path C:\Users\Admin\Desktop\Remark.txt -value $remark
            write-host "Thanks $name"
        }
    } 
    pause
}
until($choice -eq 'q')
