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
            }
            field("Tax E"; Rec."Tax E")
            {
                ApplicationArea = All;
            }
        }
        addafter("Customer No.")
        {
            field("CustomerName"; Rec."Customer Name")
            {
                ApplicationArea = All;
                Caption = 'Name';
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Customer: Record Customer;
        GenJnlBatch: Record "Gen. Journal Batch";
    begin
        if not Customer.get(Rec."Customer No.") then begin
            Rec."ID No." := '';
            Rec.Modify();
        end else begin
            Rec."ID No." := Customer."ID No.";
            Rec.Modify();
        end;

        if not GenJnlBatch.Get(Rec."Journal Batch Name") then begin
            Rec."Batch Indicator" := '';
            Rec."Authorised Person ID No." := '';
        end else begin
            Rec."Batch Indicator" := GenJnlBatch."DOT Batch Indicator";
            Rec."Authorised Person ID No." := GenJnlBatch."DOT Authorized Id";
        end;
    end;
}
