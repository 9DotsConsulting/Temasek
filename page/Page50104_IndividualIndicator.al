page 50104 "DOT Individual Indicator"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DOT Individual Indicator";
    Caption = 'Individual Indicator';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Indicator No."; Rec."Indicator No.")
                {

                }

                field(Terms; Rec.Terms)
                {

                }
            }
        }
    }
}