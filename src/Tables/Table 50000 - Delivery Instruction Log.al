
/// <summary>
/// Table Delivery Instruction Log (ID 50000).
/// </summary>
/// 
Table 50000 "Delivery Instruction Log"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            AutoIncrement = true;
        }

        field(2; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            DataClassification = ToBeClassified;
        }

        field(3; "Delivery Method"; Option)
        {
            Caption = 'Delivery Method';
            DataClassification = ToBeClassified;
            OptionMembers = Courier,"Pick Up",Delivery,"Delivery Van";
            OptionCaption = 'Courier,Pick Up,Delivery,Delivery Van';
        }

        field(4; "Instructions"; Text[100])
        {
            Caption = 'Delivery Instructions';
            DataClassification = ToBeClassified;
        }

        field(5; "Date Time of last modification"; DateTime)
        {
            Caption = 'Date Time of last modification';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Sales Order No.", "Delivery Method", "Instructions", "Date Time of last modification")
        {
        }
    }
}

