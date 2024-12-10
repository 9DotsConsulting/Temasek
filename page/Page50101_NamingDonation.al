page 50101 "DOT Naming Donation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DOT Naming Donation";
    Caption = 'Naming Donation';

    layout
    {
        area(Content)
        {
            repeater(Control1)
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