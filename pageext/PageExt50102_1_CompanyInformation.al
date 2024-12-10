pageextension 50129 "DOT Company Information" extends "Company Information"
{
    layout
    {
        addafter("Contact Person")
        {
            field("Donor Authorised"; Rec."Donor Authorised")
            {
                ApplicationArea = All;
            }
        }
    }
}
