page 50103 "DOT Organisation ID Type"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DOT Organisation ID Type";
    Caption = 'Organisation ID Type';

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
            }
        }
    }
}