page 50105 "DOT Donor Payment Method"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DOT Donor Payment Method";
    Caption = 'Donor Payment Method';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Payment Method Code"; Rec."Payment Method Code")
                {

                }
                field(Description; Rec.Description)
                {

                }
            }
        }
    }
}