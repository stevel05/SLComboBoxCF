B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.2
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub


Public Sub NewLabel As Label
	Dim L As Label
	L.Initialize("")
	Return L
End Sub

Public Sub NewHBox As JavaObject
	Dim HB As JavaObject
	HB.InitializeNewInstance("javafx.scene.layout.HBox",Null)
	Return HB
End Sub

Public Sub NewRectangle(Width As Double,Height As Double, Color As Int) As JavaObject
	Dim R As JavaObject
	R.InitializeNewInstance("javafx.scene.shape.Rectangle",Array(Width,Height))
	R.RunMethod("setStroke",Array(fx.Colors.From32Bit(Color)))
	R.RunMethod("setFill",Array(fx.Colors.From32Bit(Color)))
	Return R
End Sub

Public Sub NewListCell As JavaObject
	Dim LC As JavaObject
	LC.InitializeNewInstance("javafx.scene.control.ListCell",Null)
	Return LC
End Sub
Public Sub NewListCell2(Text As String) As JavaObject
	Dim LC As JavaObject
	LC.InitializeNewInstance("javafx.scene.control.ListCell",Null)
	LC.As(B4XView).Text = Text
	Return LC
End Sub