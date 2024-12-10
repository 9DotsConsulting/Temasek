pageextension 50101 "Customer Card Extension" extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            group(Donor)
            {
                field("ID Type No."; Rec."ID Type No.")
                {
                    Caption = 'ID Type';

                }
                field("ID No."; Rec."ID No.")
                {
                    Caption = 'ID No.';
                    Editable = true;
                }
                field("Indicator No."; Rec."Indicator No.")
                {
                    Caption = 'Individual Indicator';

                }

                field("Type No."; Rec."Type No.")
                {
                    Caption = 'Type od Donation';
                }

                field("Naming No."; Rec."Naming No.")
                {
                    Caption = 'Naming Donation';
                }
            }
        }

    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var

    begin
        Rec."Type No." := 'O';
        Rec."Naming No." := 'Z';
    end;
}
