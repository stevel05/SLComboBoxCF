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
	MainForm.RootPane.LoadLayout("Example1")
	
	SLComboboxCF1.PromptText = "Select an Item"
	SLComboboxCF1.Items = Array As String(1,2,3,4,5,6)
End Sub

#Region SLComboboxCF Callbacks

'Style the buttonCell as Required
Private Sub SLComboboxCF1_SetButtonCell(Value As Object)
	Dim LCB As B4XView = CCF_Utils.NewListCell
	LCB.Text = Value
	LCB.SetTextAlignment("CENTER","CENTER")

	SLComboboxCF1.ButtonCell = LCB
End Sub

'ListCell is a descendant of Node, so we can cast it to a B4xView and use the styling provided
'by B4xView
Private Sub SLComboboxCF1_GetText(Cell As B4XView, Source As Object) As String
	Cell.SetTextAlignment("CENTER","CENTER")
	Return Source
End Sub

#End Region SLComboboxCF Callbacks



Private Sub btnDone_Click
	CallSubDelayed(Main, "Example_Finished")
End Sub