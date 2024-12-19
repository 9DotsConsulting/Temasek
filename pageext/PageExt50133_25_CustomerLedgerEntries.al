pageextension 50133 "DOT Customer Ledger Entries" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Remaining Amt. (LCY)")
        {
            field("Batch Indicator"; Rec."Batch Indicator")
            {
                ApplicationArea = All;
            }
            field(IRASAmt; Rec.IRASAmt)
            {
                ApplicationArea = All;
            }
            field("Remaining IRASAmnt"; Rec."Remaining IRASAmnt")
            {
                ApplicationArea = All;
            }
            field("ID No."; Rec."ID No.")
            {
                ApplicationArea = All;
            }
            field("Authorised Person ID No."; Rec."Authorised Person ID No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Tax E"; Rec."Tax E")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
        modify("Customer Name")
        {
            Caption = 'Name';
        }
    }

    trigger OnAfterGetRecord()
    var
        Customer: Record Customer;
        GenJnlBatch: Record "Gen. Journal Batch";
    begin
        Rec.IRASAmt := Round(-Rec.Amount, 1, '>');
        Rec."Remaining IRASAmnt" := Round(-Rec."Remaining Amount", 1, '>');
        Rec.Modify();
    end;
}
