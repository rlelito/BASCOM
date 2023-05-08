'*******************************
'***       Step Motor        ***
'*******************************
$regfile = "m32def.dat"
$crystal = 16000000
$hwstack = 40
$swstack = 16
$framesize = 32
$sim

Dim Step As Byte
Dim Speed As Byte

Speed = 3
Step = 6

Config Portc = Input
Portc = 1
Config Porta = Output
Porta = 0

Uz1 Alias Porta.0
Uz2 Alias Porta.1
Uz3 Alias Porta.2
Uz4 Alias Porta.3


Do
   Debounce Pinc.0 , 0 , Left , Sub
   Debounce Pinc.1 , 0 , Right , Sub
   Debounce Pinc.2 , 0 , Faster , Sub
   Debounce Pinc.3 , 0 , Slower , Sub

Loop
End

' ==== ==== ==== ==== Subprograms ==== ==== ==== ====
Left:
Do
   Uz1 = 1 : Waitms Speed : Uz1 = 0
   Uz2 = 1 : Waitms Speed : Uz2 = 0
   Uz3 = 1 : Waitms Speed : Uz3 = 0
   Uz4 = 1 : Waitms Speed : Uz4 = 0
Loop Until Pinc.1 = 0
Bitwait Pinc.1 , Set
Return

Right:
Do
   Uz4 = 1 : Waitms Speed : Uz4 = 0
   Uz3 = 1 : Waitms Speed : Uz3 = 0
   Uz2 = 1 : Waitms Speed : Uz2 = 0
   Uz1 = 1 : Waitms Speed : Uz1 = 0
Loop Until Pinc.1 = 0
Bitwait Pinc.1 , Set
Return

Woniej:
   Speed = Speed + Step
   If Speed > 33 Or Speed = 33 Then Speed = 3
Return

Faster:
   Speed = Speed - Step
   If Speed = 3 Or Speed < 3 Then Speed = 33
Return
