'*******************************
'***  Keyboard / Calculator  ***
'***  with support for some  ***
'***    polish characters    ***
'*******************************
$regfile = "m32def.dat"
$crystal = 16000000
$hwstack = 40
$swstack = 16
$framesize = 32
$sim


Dim Number As Single
Dim Kbd As Byte
Dim Kbd_st As String * 2
Dim Characters As String * 5
Dim Length As Byte

Config Single = Sciencetific , Digits = 2
Config Kbd = Porta , Debounce = 30 , Delay = 100


Config Portc = Input
Pinc.0 = 1

Config Lcd = 16 * 2
Config Lcdpin = Pin , Db4 = Portb.4 , Db5 = Portb.5 , Db6 = Portb.6 , Db7 = Portb.7 , E = Portb.2 , Rs = Portb.3
Cursor Off

' -> replace [x] with number (0-7)
Deflcdchar 0 , 32 , 32 , 14 , 17 , 31 , 16 , 14 , 1         ' ę

Cls
   Lcd "Napi" ; Chr(0) ; "cie U="


Do
   Kbd = Getkbd()
   If Kbd <> 16 Then Gosub Screen

Loop
End


Screen:
   If Kbd < 3 Then Kbd = Kbd + 1
   If Kbd > 7 And Kbd < 11 Then Kbd = Kbd - 1
   If Kbd = 13 Then Kbd = 0
   Kbd_st = Str(Kbd)
   If Kbd = 12 Then Kbd_st = "."

   If Kbd = 11 Then
      Length = Len(Characters)
      Length = Length - 1
      Characters = Left(Characters , Length)
   Else
      Characters = Characters + Kbd_st
   End If

   Cls
   If Kbd = 14 Then
      Lcd "Napi" ; Chr(0) ; "cie U=" ; Characters ; "V"
      Number = Val(Characters)
      Lowerline
      Lcd "Liczba-" ; Number
   Else
      Lcd "Napi" ; Chr(0) ; "cie U=" ; Characters
   End If

   Do
      Kbd = Getkbd()
   Loop Until Kbd = 16

Return
