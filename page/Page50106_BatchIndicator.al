page 50106 "DOT Batch Indicator"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DOT Batch Indicator";
    Caption = 'Batch Indicator';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Batch No."; Rec."Batch No.")
                {

                }
                field(Terms; Rec.Terms)
                {

                }
            }
        }
    }
}