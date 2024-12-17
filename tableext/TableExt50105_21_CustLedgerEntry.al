tableextension 50105 "DOT Cust. Ledger Entry" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50100; "Batch Indicator"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; IRASAmt; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Remaining IRASAmnt"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "ID No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Authorised Person ID No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "Tax E"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        modify(Amount)
        {
            trigger OnAfterValidate()
            var
            begin
                IRASAmt := Round(-Amount, 1, '>');
            end;
        }
        modify("Remaining Amount")
        {
            trigger OnAfterValidate()
            var
            begin
                "Remaining IRASAmnt" := Round(-"Remaining Amount", 1, '>');
            end;
        }
    }
}
