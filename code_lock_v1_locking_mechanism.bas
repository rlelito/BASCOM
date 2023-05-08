'*******************************
'***      Code Lock v1       ***
'*** with locking mechanism  ***
'*******************************
$regfile = "m32def.dat"
$crystal = 16000000
$hwstack = 40
$swstack = 16
$framesize = 32
$sim


Dim InputCode as String * 5
Dim Digit As Integer
Dim Code As String * 5
Dim TryNum As Integer
Dim var as Integer
dim ErrorTry as Byte

Config Porta = Input
Porta = 1

Config Lcd = 16 * 2
Config Lcdpin = Pin , Db4 = Portb.4 , Db5 = Portb.5 , Db6 = Portb.6 , Db7 = Portb.7 , E = Portb.2 , Rs = Portb.3
Cursor Off

SW0 alias Pina.0
SW1 alias Pina.1
SW2 alias Pina.2
SW3 alias Pina.3

Code = "0000"
TryNum = 0
InputCode = ""
ErrorTry = 0


Gosub EnterCode

Do

   Debounce pina.0 , 0 , Zero , Sub
   Debounce pina.1 , 0 , One , Sub
   Debounce pina.2 , 0 , Two , Sub
   Debounce pina.3 , 0 , Three , Sub

   If TryNum = 4 Then
      Cls
      If Code = InputCode then
         LCD "Lock Opened"
      else
         LCD "Wrong Code"
         ErrorTry = ErrorTry + 1
         If ErrorTry = 1 Then Gosub Locked
      End if

      TryNum = 0
      InputCode = ""
      Wait 2
      Gosub EnterCode
   End if

   Wait 1

Loop

End

'==============================Subprograms====================================='
EnterCode:
Cls
   Lcd "Enter Code"
Return

Locked:
   Cls
   Lcd "Locked"
   ErrorTry = 0
   Wait 10
Return

Zero:
'Do
   Digit = 0
   InputCode = InputCode + str(Digit)
   TryNum = TryNum + 1
'Loop Until SW0 = 0
Bitwait SW0 , Set
Wait 1
Return
'=============================================================================='
One:
'Do
   Digit = 1
   InputCode = InputCode + str(Digit)
   TryNum = TryNum + 1
'Loop Until SW1 = 0
Bitwait SW1 , Set
Wait 1
Return
'=============================================================================='
Two:
'Do
   Digit = 2
   InputCode = InputCode + str(Digit)
   TryNum = TryNum + 1
'Loop Until SW2 = 0
Bitwait SW2 , Set
Wait 1
Return
'=============================================================================='
Three:
'Do
   Digit = 3
   InputCode = InputCode + str(Digit)
   TryNum = TryNum + 1
'Loop Until SW3 = 0
Bitwait SW3 , Set
Wait 1
Return
