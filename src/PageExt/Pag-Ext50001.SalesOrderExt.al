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

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                ValidatePosting();
            end;
        }
        modify(PostAndNew)
        {
            trigger OnBeforeAction()
            begin
                ValidatePosting();
            end;
        }

        modify("Test Report")
        {
            trigger OnBeforeAction()
            begin
                ValidatePosting();
            end;
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


    /// <summary>
    /// ValidatePosting.
    /// </summary>
    procedure ValidatePosting()
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then
            if Rec."Delivery Method" = Rec."Delivery Method"::Courier then
                if Rec."Delivery Instructions" = '' then Error('You must provide delivery instructions when the delivery method is Courier!');
    end;
}
