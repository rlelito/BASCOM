'*******************************
'***      Code Lock v2       ***
'***  4x4 keyboard support   ***
'*******************************
$regfile = "m32def.dat"
$crystal = 16000000
$hwstack = 40
$swstack = 16
$framesize = 32
$sim


Dim Kbrd As Byte
Dim Kbrd_st As String * 2
Dim InputCode As String * 5
Dim Code As String * 5
Dim TryNum As Byte
Dim ErrorTry As Byte

Config Single = Sciencetific , Digits = 2
Config Kbd = Porta , Debounce = 30 , Delay = 100


Config Portc = Input
Pinc.0 = 1

Config Lcd = 16 * 2
Config Lcdpin = Pin , Db4 = Portb.4 , Db5 = Portb.5 , Db6 = Portb.6 , Db7 = Portb.7 , E = Portb.2 , Rs = Portb.3
Cursor Off

Code = "0123"
InputCode = ""
TryNum = 0
ErrorTry = 0

Gosub EnterCode

Do
   Kbrd = Getkbd()
   If Kbrd <> 16 Then Gosub InputScreen

   If TryNum = 4 Then
      Cls
      If Code = InputCode then
         LCD "Lock Opened"
      else
         LCD "Wrong Code"
         ErrorTry = ErrorTry + 1
         gosub LockedScreen
      End if

      TryNum = 0
      InputCode = ""
      Wait 2
      Gosub EnterCode
   End if

Loop
End

LockedScreen:
Cls
Lcd "Locked"
Wait 10
Return

InputScreen:
   If Kbrd < 3 Then Kbrd = Kbrd + 1
   If Kbrd > 7 And Kbrd < 11 Then Kbrd = Kbrd - 1
   If Kbrd = 13 Then Kbrd = 0
   Kbrd_st = Str(Kbrd)
   'If Kbrd = 12 Then Kbrd_st = "."

   InputCode = InputCode + Kbrd_st
   TryNum = TryNum + 1

   Do
      Kbrd = Getkbd()
   Loop Until Kbrd = 16

Return

EnterCode:
Cls
   Lcd "Enter code"
Return
