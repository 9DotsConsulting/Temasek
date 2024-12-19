tableextension 50105 "DOT Cust. Ledger Entry" extends "Cust. Ledger Entry"
{
    fields
    {

        field(50100; "Authorised Person ID No."; Text[12])
        {
            Caption = 'Authorised Person ID No.';
            DataClassification = ToBeClassified;
        }
        field(50101; "Batch Indicator"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50102; IRASAmt; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Remaining IRASAmnt"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "ID No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "Tax E"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

}
