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
    }
}
