pageextension 50100 "DOT Employee Card" extends "Employee Card"
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
        }
    }

    actions
    {

    }
}
