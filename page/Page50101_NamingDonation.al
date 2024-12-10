page 50101 "DOT Naming Donation"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DOT Naming Donation";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Naming No."; Rec."Naming No.")
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