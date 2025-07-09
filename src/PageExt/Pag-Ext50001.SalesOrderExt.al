/// <summary>
/// PageExtension Sales Order Ext. (ID 50001) extends Record Sales Order.
/// </summary>

pageextension 50001 "Sales Order Ext." extends "Sales Order"
{
    layout
    {
        addafter("Shipment Date")
        {
            field("Delivery Method"; Rec."Delivery Method")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = IsVisible;
                ToolTip = 'Specifies the delivery method';
            }

            field("Delivery Instructions"; Rec."Delivery Instructions")
            {
                ApplicationArea = All;
                Importance = Promoted;
                Visible = IsVisible;
                ToolTip = 'Specifies the delivery Instructions';
            }
        }
    }

    var
        IsVisible: Boolean;


    trigger OnOpenPage()
    begin
        Visibility();
    end;

    trigger OnAfterGetRecord()
    begin
        Visibility();
    end;

    /// <summary>
    /// Visibility.
    /// </summary>
    procedure Visibility()
    begin
        if Rec."Document Type" in [Rec."Document Type"::Order] then
            IsVisible := True
        else
            IsVisible := False;
    end;
}
