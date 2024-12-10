page 50100 "DOT Type of Donation"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "DOT Type of Donation";
    Caption = 'Type of Donation';
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Control1)
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