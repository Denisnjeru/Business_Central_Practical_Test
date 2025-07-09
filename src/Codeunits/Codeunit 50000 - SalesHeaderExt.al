/// <summary>
/// </summary>

codeunit 50000 "Sales Header Ext."
{
    trigger OnRun()
    begin
    end;


    [EventSubscriber(ObjectType::Codeunit, 81, 'OnBeforeConfirmPost', '', false, false)]
    local procedure OnBeforeConfirmPost(var SalesHeader: Record "Sales Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    begin
        if SalesHeader."Delivery Method" = SalesHeader."Delivery Method"::Courier then
            if SalesHeader."Delivery Instructions" = '' then Error('You must provide delivery instructions when the delivery method is Courier!');

        IsHandled := false;
    end;
}
