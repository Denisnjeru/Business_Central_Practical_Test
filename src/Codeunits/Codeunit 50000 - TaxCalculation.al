/// <summary>
/// Unknown DalaDala.
/// </summary>

namespace DalaDala.DalaDala;

codeunit 50000 "Tax Calculation"
{
    /// <summary>
    /// CalculateTax.
    /// </summary>
    /// <param name="Rec">Record "Payment Line".</param>
    /// <param name="CalculationType">Option VAT,"W/Tax",Retention,"W/VAT".</param>
    /// <returns>Return variable Amount of type Decimal.</returns>
    procedure CalculateTax(Rec: Record "Payment Line"; CalculationType: Option VAT,"W/Tax",Retention,"W/VAT") Amount: Decimal
    begin
        case CalculationType of
            CalculationType::VAT:
                begin
                    //  Amount:=Rec."Taxable Amount" - ((100/(100+Rec."VAT Rate"))*Rec."Taxable Amount");

                    Amount := (Rec."VAT Rate" / (100 + Rec."VAT Rate")) * Rec."Taxable Amount";

                end;
            CalculationType::"W/Tax":
                begin
                    Amount := (Rec."W/Tax Rate" / 100) * (Rec."Taxable Amount" - Rec."VAT Amount");
                    Amount := Round(Amount, 1, '>');
                end;
            CalculationType::Retention:
                begin
                    Amount := (Rec."Taxable Amount" - ((Rec."VAT Rate" / (100 + Rec."VAT Rate")) * Rec."Taxable Amount"))
                     * (Rec."Retention Rate" / 100);
                end;

            CalculationType::"W/VAT":
                begin
                    //Amount:=Rec."Taxable Amount" - ((100/(100+Rec."VAT Withholding Rate"))*Rec."Taxable Amount");
                    Amount := (Rec."VAT Withholding Rate" / (100 + Rec."VAT Rate")) * Rec."Taxable Amount";
                    Amount := Round(Amount, 1, '>');
                end;

        end;
    end;
}
