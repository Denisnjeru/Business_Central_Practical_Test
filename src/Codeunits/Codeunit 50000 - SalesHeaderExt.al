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
        // ** Should only apply when the document type is Order **
        ValidatePosting(SalesHeader);
        IsHandled := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, 79, 'OnBeforeConfirmPostAndSend', '', false, false)]
    local procedure OnBeforeConfirmPostAndSend(SalesHeader: Record "Sales Header"; var TempDocumentSendingProfile: Record "Document Sending Profile" temporary; var Result: Boolean; var IsHandled: Boolean)
    begin
        // ** Should only apply when the document type is Order **
        ValidatePosting(SalesHeader);
        IsHandled := false;
    end;


    /// <summary>
    /// ValidatePosting.
    /// </summary>
    /// <param name="SalesHeader">Record "Sales Header".</param>
    procedure ValidatePosting(var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            if SalesHeader."Delivery Method" = SalesHeader."Delivery Method"::Courier then
                if SalesHeader."Delivery Instructions" = '' then Error('You must provide delivery instructions when the delivery method is Courier!');

    end;
}
