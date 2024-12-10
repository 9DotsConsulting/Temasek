page 50107 "DOT Donor Email List"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DOT Donor Email List";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Email ID"; Rec."Email ID")
                {

                }
                field(Email; Rec.Email) { }
                field(Default; Rec.Default) { }
            }
        }
    }
}