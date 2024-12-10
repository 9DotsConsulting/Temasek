pageextension 50102 "Company Information Extension" extends "Company Information"
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
