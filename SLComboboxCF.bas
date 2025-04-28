B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
#Event: ItemClicked(Index as Int, Value As Object)
#Event: SelectedIndexChanged(Index As Int, Value As Object)
#Event: SetButtonCell(Value As Object)
#Event: GetGraphic(Cell As B4xView, Source as Object) As Node
#Event: GetText(Cell As B4xView, Source as Object) As String
#DesignerProperty: Key: celltype, DisplayName: Cell Type, FieldType: String, DefaultValue: Text, List: Text|Graphic


Sub Class_Globals
	Public const CELLTYPE_TEXT As String = "Text"
	Public const CELLTYPE_GRAPHIC As String = "Graphic"
	
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private ComboBox1 As ComboBox
	Private mCellType As String = "Graphic"
	Private EventMap As JavaObject
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	EventMap.InitializeNewInstance("java.util.WeakHashMap",Null)
	
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
    Tag = mBase.Tag
    mBase.Tag = Me
	ComboBox1.Initialize("Combobox1")
	mBase.AddView(ComboBox1,0,0,mBase.Width,mBase.Height)
	
	mCellType = Props.GetDefault("celltype","Text")
	
	'Set the Callback sub for CellFactory
	Dim Cb As JavaObject = ComboBox1
	Dim Event As Object = Cb.CreateEvent("javafx.util.Callback","Callback",Null)
	Cb.RunMethod("setCellFactory",Array(Event))
	
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	ComboBox1.As(B4XView).Width = Width
	ComboBox1.As(B4XView).Height= Height
End Sub

#Region Wrapper subs
Public Sub setButtonCell(Cell As JavaObject)
	ComboBox1.As(JavaObject).RunMethod("setButtonCell",Array(Cell))
End Sub

Public Sub setPromptText(text As String)
	ComboBox1.As(JavaObject).RunMethod("setPromptText",Array(text))
End Sub
Public Sub getPromptText As String
	Return ComboBox1.As(JavaObject).RunMethod("getPromptText",Null)
End Sub

Public Sub setItems(Items As List)
	ComboBox1.Items.AddAll(Items)
End Sub

Public Sub getCombobox As ComboBox
	Return ComboBox1
End Sub

'Delegate SelectedIndexChanged to the CallBack Module / Class
'Also prompts for the Button Cell to be changed if a sub exists for it.
Private Sub ComboBox1_SelectedIndexChanged(Index As Int, Value As Object)

	If SubExists(mCallBack,mEventName & "_SetButtonCell") Then
		'Attempt to hide the initial state for the ButtonCell which may flash the value before being
		'overwritten on slower, or busy machines, or in debug mode
		ComboBox1.As(JavaObject).RunMethod("setButtonCell",Array(CCF_Utils.NewListCell))
		
		CallSubDelayed2(mCallBack,mEventName & "_SetButtonCell", Value)
	End If
	
	If SubExists(mCallBack,mEventName & "_SelectedIndexChanged") Then
		CallSubDelayed3(mCallBack,mEventName & "_SelectedIndexChanged", Index, Value)
	End If
End Sub
#End Region Wrapper Subs

#Region CellFactory Callbacks

Public Sub setCellType(tType As String)
	mCellType = tType
End Sub

Private Sub Callback_Event(MethodName As String,Args() As Object) As Object
	'Call the java cell factory code
	If MethodName = "call" Then Return Me.As(JavaObject).RunMethod("newListCell",Array(mCellType))
	Return False
End Sub

Private Sub Get_Graphic(Source As Object) As Object
	If SubExists(mCallBack,mEventName & "_GetGraphic") Then Return CallSub3(mCallBack,mEventName & "_GetGraphic",Sender.As(B4XView),Source)
	Return Null
End Sub

Private Sub Get_Text(Source As Object) As String

	If SubExists(mCallBack,mEventName & "_GetText") Then
		Return CallSub3(mCallBack,mEventName & "_GetText",Sender.As(B4XView),Source)
	Else
		Return Sender.As(JavaObject).RunMethod("getItem",Null)
	End If
End Sub
#End Region CellFactory Callbacks

#if java
import javafx.scene.control.ListCell;
import javafx.scene.Node;

public ListCell newListCell(final String cellType){
	ListCell cell = new ListCell(){
	        @Override
	        protected void updateItem(Object t, boolean bln) {
	        	super.updateItem(t, bln);
				
				
	            if (t != null) {
					if (cellType.equals("Text")){
		            	setText((String)ba.raiseEvent(this, "get_text", t));
						}
					if (cellType.equals("Graphic")){
						setGraphic((Node)ba.raiseEvent(this, "get_graphic", t));
						}
	            }
	         }
		};
	return cell;
}
#end if