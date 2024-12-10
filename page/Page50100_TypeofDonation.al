page 50100 "DOT Type of Donation"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DOT Type of Donation";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Type No."; Rec."Type No.")
                {
                    ApplicationArea = All;
                }
                field(Terms; Rec.Terms)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}