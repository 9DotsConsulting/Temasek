page 50107 "DOT Donor Email List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DOT Donor Email List";
    Caption = 'Donor Email List';
    DelayedInsert = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Donor No."; Rec."Donor No.")
                {
                    Visible = false;
                }
                field(Email; Rec.Email) { }
                field(Default; Rec.Default) { }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        DEL: Record "DOT Donor Email List";
    begin
        DEL.Reset();
        DEL.SetRange("Donor No.", Rec."Donor No.");
        DEL.SetRange(Default, true);
        if DEL.FindSet() then begin
            if DEL.Count() > 5 then
                Error('Default email cannot be more than 5!');
        end;
    end;
}