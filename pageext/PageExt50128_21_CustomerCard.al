pageextension 50128 "DOT Customer Card" extends "Customer Card"
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
                    ApplicationArea = All;
                }
                field("ID No."; Rec."ID No.")
                {
                    Caption = 'ID No.';
                    ApplicationArea = All;
                }
                field("Indicator No."; Rec."Indicator No.")
                {
                    Caption = 'Individual Indicator';
                    ApplicationArea = All;

                }
                field("Type No."; Rec."Type No.")
                {
                    Caption = 'Type of Donation';
                    ApplicationArea = All;
                }
                field("Naming No."; Rec."Naming No.")
                {
                    Caption = 'Naming Donation';
                    ApplicationArea = All;
                }
            }
        }

    }

    actions
    {
        addfirst("&Customer")
        {
            action("Email List")
            {
                Caption = 'Email List';
                ApplicationArea = Basic, Suite;
                Image = Email;
                RunObject = Page "DOT Donor Email List";
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