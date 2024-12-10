page 50105 "DOT Donor Payment Method"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DOT Donor Payment Method";

    layout
    {
        area(Content)
        {
            group(GroupName)
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