B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private Xui As XUI
	Private SLComboboxCF1 As SLComboboxCF
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub Show(MainForm As Form)
	MainForm.RootPane.RemoveAllNodes
	MainForm.RootPane.LoadLayout("Example2")
	
	SLComboboxCF1.Items = Array( _
	CreateMap("color":0xFFFF0000,"text":"Red"), _
	CreateMap("color":0xFF00FF00,"text":"Green"), _
	CreateMap("color":0xFF0000FF,"text":"Blue"))
	
	SLComboboxCF1.PromptText = "Select a Colour"
End Sub

#Region Optional

'Manage Changes to the ButtonCell prompt style
Private Sub SLComboboxCF1_SelectedIndexChanged(Index As Int, Value As Object)
'	Reset style for the button cell
	If Index = -1 Then SetPromptStyle(Sender)
End Sub

'Dont want resiudal styles from the cellfactory on the prompt text.
'Configure as required
Private Sub SetPromptStyle(thisComboBoxCF As SLComboboxCF)
	SetPromptStyle2(thisComboBoxCF,Xui.Color_Black)
End Sub

Private Sub SetPromptStyle2(thisComboBoxCF As SLComboboxCF, Color As Int)
	Dim LCB As B4XView = thisComboBoxCF.Combobox.As(JavaObject).RunMethod("getButtonCell",Null)
	If Initialized(LCB) Then
		LCB.TextColor = Color
		LCB.SetTextAlignment("CENTER","LEFT")
	Else
		'There is no node on the buttoncell until a selection has been made,
		'Add a cell if not present so we can style it before a selection is made.
		LCB = CCF_Utils.NewListCell2(thisComboBoxCF.PromptText)
		LCB.TextColor = Color
		LCB.SetTextAlignment("CENTER","LEFT")
		thisComboBoxCF.ButtonCell = LCB
	End If
End Sub
#End Region Optional


#Region Cell Factory Callbacks

'Style the buttonCell as Required
Private Sub SLComboboxCF1_SetButtonCell(Value As Object)
	If Value Is Map Then
		Dim LCB As B4XView = SetFromMap("buttoncell",Value)
	Else
		Dim LCB As B4XView = CCF_Utils.NewListCell
		LCB.Text = Value
'		LCB.TextColor = Xui.Color_Red
		LCB.SetTextAlignment("CENTER","CENTER")
	End If
	SLComboboxCF1.ButtonCell = LCB
End Sub


'Return a Node for the cell content.
Private Sub SLComboboxCF1_GetGraphic(Cell As B4XView, Source As Object) As Node
	If Source Is Map Then
		Return SetFromMap("cell",Source)
	Else
		Dim L As B4XView = CCF_Utils.NewLabel
		L.Text = Source
		L.TextColor = Xui.Color_Red
		L.SetTextAlignment("CENTER","CENTER")
		'Need to set a width so the text can center.
		L.Width = SLComboboxCF1.mBase.Width - 30
		Return L
	End If
End Sub

Private Sub SetFromMap(tType As String, M As Map) As Object

	'Pane to hold the regtangle so we can display it smaller than the hbox height
	'Use the same pane layout for Cell pr ButtonCell Nodes
	Dim P As B4XView = Xui.CreatePanel("")
	P.SetLayoutAnimated(0,0,0,25,30)
	Dim R As JavaObject = CCF_Utils.NewRectangle(15,15, M.Get("color"))
	'Position the rectangle where we want it in the pane.
	P.AddView(R,0,7.5,10,15)
	
	If tType = "cell" Then
		'Return a Node with Rectangle (In a pane) and Label
		'Hbox is the easiest way to 'stack' views horizontally, no need to calculate positions.
		Dim HB As JavaObject = CCF_Utils.NewHBox
		Dim L As B4XView = CCF_Utils.NewLabel
		L.Text = M.Get("text")
		L.SetTextAlignment("CENTER","LEFT")
		'Need to set a Height value so the text Centers Vertically
		L.Height = 30
		
		HB.RunMethod("getChildren",Null).As(List).AddAll(Array(P,L))
		Return HB
		
	Else If tType = "buttoncell" Then
		
		'Return a listcell object with graphic
		Dim LCB As B4XView = CCF_Utils.NewListCell
		LCB.As(JavaObject).RunMethod("setGraphic",Array(P))
		
		'Helps align the views to those in the List
		LCB.As(JavaObject).RunMethod("setGraphicTextGap",Array(-1.0))
		
		LCB.Text = M.Get("text")
		LCB.SetTextAlignment("CENTER","LEFT")
		Return LCB
	End If
	
	Return Null
End Sub
#End Region CellFactory Callbacks

#Region Testing
'Just for Testing
Private Sub btnClearSelection_Click
	SLComboboxCF1.Combobox.SelectedIndex = -1
End Sub
#End region Testing



Private Sub btnDone_Click
	CallSubDelayed(Main, "Example_Finished")
End Sub