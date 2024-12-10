page 50107 "DOT Donor Email List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DOT Donor Email List";
    Caption = 'Donor Email List';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(Email; Rec.Email) { }
                field(Default; Rec.Default) { }
            }
        }
    }
}