pageextension 50134 EmailOutbox extends "Email Outbox"
{
    layout
    {
        addafter(Desc)
        {
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
