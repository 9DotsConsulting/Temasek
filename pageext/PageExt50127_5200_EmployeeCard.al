pageextension 50127 "DOT Employee Card" extends "Employee Card"
{
    layout
    {
        addafter("Privacy Blocked")
        {
            field("Donor Authorised"; Rec."Donor Authorised")
            {
                ApplicationArea = All;
                Caption = 'Donor Authorised';
            }

            field("ID Type No."; Rec."ID Type No.")
            {
                ApplicationArea = All;
                Caption = 'Organisation ID Type';
            }

            field("Organisation ID No."; Rec."Organisation ID No.")
            {
                ApplicationArea = All;
                Caption = 'Organisation ID No.';
            }
        }
    }

    actions
    {

    }
}
