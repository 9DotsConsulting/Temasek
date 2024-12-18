page 50108 "DOT Donor Email List Page"
{
    ApplicationArea = All;
    Caption = 'DonorEmailListPage';
    PageType = ListPart;
    SourceTable = "DOT Donor Email List";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Donor No."; Rec."Donor No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field(Default; Rec.Default)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DEL: Record "DOT Donor Email List";
                    begin
                        DEL.Reset();
                        DEL.SetRange("Donor No.", Rec."Donor No.");
                        DEL.SetRange(Default, true);
                        if DEL.FindSet() then begin
                            if (DEL.Count() = 5) and Rec.Default then
                                Error('Default email cannot be more than 5!');
                        end;
                    end;
                }
            }
        }
    }

}
