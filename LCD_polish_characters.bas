'*******************************
'***       LCD screen        ***
'***  with support for some  ***
'***    polish characters    ***
'*******************************
$regfile = "m32def.dat"
$crystal = 16000000
$hwstack = 40
$swstack = 16
$framesize = 32
'$sim

Dim WaitTime As Word
WaitTime = 1500
Dim Counter As Byte

Config Portc = Input
Pinc.0 = 1

Config Lcd = 16 * 2
Config Lcdpin = Pin , Db4 = Portb.4 , Db5 = Portb.5 , Db6 = Portb.6 , Db7 = Portb.7 , E = Portb.2 , Rs = Portb.3
Cursor Off


' -> replace [x] with number (0-7)
Deflcdchar 0 , 2 , 4 , 22 , 25 , 17 , 17 , 17 , 32          ' ń
Deflcdchar 1 , 32 , 32 , 14 , 17 , 31 , 16 , 14 , 1         ' ę
Deflcdchar 2 , 1 , 32 , 3 , 1 , 1 , 1 , 9 , 6               ' j
Deflcdchar 3 , 32 , 32 , 14 , 1 , 15 , 17 , 15 , 1          ' ą
Deflcdchar 4 , 2 , 4 , 14 , 16 , 16 , 17 , 14 , 32          ' ś


Do

   Cls
      Locate 2 , 6
         Lcd "Witam"
      Waitms WaitTime

   Cls
      Locate 1 , 6
         Lcd "Witam" ;
      Locate 2 , 5
         Lcd "Pa" ; Chr(0) ; "stwa"
      Waitms WaitTime

   Cls
      Locate 1 , 5
         Lcd "Pa" ; Chr(0) ; "stwa"
      Locate 2 , 8
         Lcd "na"
      Waitms WaitTime

   Cls
      Locate 1 , 8
         Lcd "na"
      Locate 2 , 4
         Lcd "za" ; Chr(2) ; Chr(1) ; "ciach"
      Wait 1

   For Counter = 5 To 17
      Shiftlcd Right
      Waitms 50
   Next Counter

Bitwait Pinc.0 , Reset

   For Counter = 5 To 17
      Shiftlcd Left
      Waitms 50
   Next Counter

Bitwait Pinc.0 , Reset

Loop
'Cls
'   Lcd "aejcolp"

End
