'*******************************
'***       Step Motor        ***
'***     with half step      ***
'*******************************
$regfile = "m32def.dat"
$crystal = 16000000
$hwstack = 40
$swstack = 16
$framesize = 32
$sim

Dim WaitTime As Byte
Dim Step As Byte
Dim T1 As Byte


WaitTime = 150
T1 = 2

Config Portc = Input
Portc = 1
Config Porta = Output
Porta = 0

Uz1 Alias Porta.0
Uz2 Alias Porta.1
Uz3 Alias Porta.2
Uz4 Alias Porta.3


Do
   Bitwait Pinc.0 , Reset
   Waitms WaitTime
   For Step = 0 To 127
      Uz1 = 1 : Uz3 = 0 : Waitms T1
      Uz2 = 1 : Uz4 = 0 : Waitms T1
      Uz3 = 1 : Uz1 = 0 : Waitms T1
      Uz4 = 1 : Uz2 = 0 : Waitms T1
   Next Step
   Waitms WaitTime
   For Step = 0 To 127
      Uz1 = 1 : Uz3 = 0 : Waitms T1
      Uz2 = 1 : Uz4 = 0 : Waitms T1
      Uz3 = 1 : Uz1 = 0 : Waitms T1
      Uz4 = 1 : Uz2 = 0 : Waitms T1
   Next Step

   Bitwait Pinc.0 , Set
   For Step = 0 To 254
      Uz1 = 1 : Uz3 = 0 : Waitms T1
      Uz2 = 1 : Uz4 = 0 : Waitms T1
      Uz3 = 1 : Uz1 = 0 : Waitms T1
      Uz4 = 1 : Uz2 = 0 : Waitms T1
   Next Step

Loop
End
