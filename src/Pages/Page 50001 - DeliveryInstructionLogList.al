/// <summary>
/// Page Delivery Instruction Log List (ID 50000).
/// </summary>

page 50001 "Delivery Instruction Log List"
{
    ApplicationArea = All;
    Caption = 'Delivery Instruction Log List';
    PageType = List;
    SourceTable = "Delivery Instruction Log";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order No. field.', Comment = '%';
                }
                field("Delivery Method"; Rec."Delivery Method")
                {
                    ToolTip = 'Specifies the value of the Delivery Method field.', Comment = '%';
                }
                field(Instructions; Rec.Instructions)
                {
                    ToolTip = 'Specifies the value of the Delivery Instructions field.', Comment = '%';
                }
                field("Date Time of last modification"; Rec."Date Time of last modification")
                {
                    ToolTip = 'Specifies the value of the Date Time of last modification field.', Comment = '%';
                }
            }
        }
    }
}
