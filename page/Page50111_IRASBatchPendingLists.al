page 50111 "DOT IRAS Batch Pending Lists"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'IRAS Batch Pending Lists';
    UsageCategory = Lists;
    SourceTable = "DOT IRAS Batch Pending Lists";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Record ID"; Rec."Record ID") { }
                field("Basis Year"; Rec."Basis Year") { }
                field("Receipt Num"; Rec."Receipt Num") { }
                field("Date Of Donation"; Rec."Date Of Donation") { }
                field(Status; Rec.Status) { }
                field(Validate; Rec.Validate) { }
                field("Recent Date Time"; Rec."Recent Date Time") { }
                field("Batch Indicator"; Rec."Batch Indicator") { }
                field("Authorised Person ID No."; Rec."Authorised Person ID No.") { }
                field("ID Type No."; Rec."ID Type No.") { }
                field("ID No."; Rec."ID No.") { }
                field("Indicator No."; Rec."Indicator No.") { }
                field(Name; Rec.Name) { }
                field("Type No."; Rec."Type No.") { }
                field("Naming No."; Rec."Naming No.") { }
                field("Donation Amount"; Rec."Donation Amount") { }
                field(Response; Rec.Response) { }
            }
        }
    }


}