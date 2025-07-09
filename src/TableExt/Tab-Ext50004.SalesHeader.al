/// <summary>
/// TableExtension Sales Header (ID 50004) extends Record Sales Header.
/// </summary>
tableextension 50004 "Sales Header" extends "Sales Header"
{
    fields
    {
        field(50000; "Delivery Method"; Option)
        {
            Caption = 'Delivery Method';
            DataClassification = ToBeClassified;
            OptionMembers = Courier,"Pick Up",Delivery,"Delivery Van";
            OptionCaption = 'Courier,Pick Up,Delivery,Delivery Van';
        }
        field(50001; "Delivery Instructions"; Text[100])
        {
            Caption = 'Delivery Instructions';
            DataClassification = ToBeClassified;
        }
    }

    var
        DeliveryInstructionLog: Record "Delivery Instruction Log";

    trigger OnModify()
    begin
        if Rec."Delivery Instructions" <> xRec."Delivery Instructions" then LogChanges();
    end;


    local procedure LogChanges()
    begin
        DeliveryInstructionLog.Init();
        DeliveryInstructionLog."Delivery Method" := Rec."Delivery Method";
        DeliveryInstructionLog."Sales Order No." := Rec."No.";
        DeliveryInstructionLog.Instructions := Rec."Delivery Instructions";
        DeliveryInstructionLog."Date Time of last modification" := CurrentDateTime();
        DeliveryInstructionLog.Insert();
    end;


}
