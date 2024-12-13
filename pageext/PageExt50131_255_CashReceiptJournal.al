pageextension 50131 "Cash Receipt Journal Extension" extends "Cash Receipt Journal"
{
    layout
    {
        modify("Account No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Customer: Record Customer;
            begin
                Customer.SetFilter("No.", '*DNO*');
                if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then
                    Rec."Account No." := Customer."No.";
            end;
        }
        addafter("Account No.")
        {
            field(AuthorisedPersonIDNo; Rec.AuthorisedPersonIDNo)
            {
                Editable = false;
                ApplicationArea = Basic, Suite;
            }
            field(AuthorisedPersonName; Rec.AuthorisedPersonName)
            {
                Editable = false;
                ApplicationArea = Basic, Suite;
            }
            field(Telephone; Rec.Telephone)
            {
                Editable = false;
                ApplicationArea = Basic, Suite;
            }
            field(AuthorisedPersonEmail; Rec.AuthorisedPersonEmail)
            {
                Editable = false;
                ApplicationArea = Basic, Suite;
            }
        }

        addafter("Amount (LCY)")
        {
            field(IRASAmt; Rec.IRASAmt)
            {
                //Editable = false;
                ApplicationArea = Basic, Suite;
            }
            field("Donor Payment Method Code"; Rec."Donor Payment Method Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Tax E"; Rec."Tax E")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Donor Email"; Rec."Donor Email")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Email Status"; Rec."Email Status")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
