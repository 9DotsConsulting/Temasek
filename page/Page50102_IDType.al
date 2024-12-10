page 50102 "DOT ID Type"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DOT ID Type";
    Caption = 'ID Type';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("ID Type No."; Rec."ID Type No.")
                {

                }

                field(Terms; Rec.Terms)
                {

                }

                field("Individual Indicator"; Rec."Individual Indicator")
                {

                }
            }
        }
    }
}