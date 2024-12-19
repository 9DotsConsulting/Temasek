codeunit 50101 "DOT GenJnlPost"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostCustOnAfterInitCustLedgEntry', '', false, false)]
    local procedure OnPostCustOnAfterInitCustLedgEntry(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; var CustLedgEntry: Record "Cust. Ledger Entry"; Cust: Record Customer; CustPostingGr: Record "Customer Posting Group");
    var
        Customer: Record Customer;
        GenJnlBatch: Record "Gen. Journal Batch";
    begin
        if not Customer.get(GenJournalLine."Account No.") then begin
            CustLedgEntry."ID No." := '';
        end else begin
            CustLedgEntry."ID No." := Customer."ID No.";
        end;

        GenJnlBatch.Reset();
        GenJnlBatch.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        GenJnlBatch.SetRange(Name, GenJournalLine."Journal Batch Name");
        if GenJnlBatch.FindFirst() then begin
            CustLedgEntry."Batch Indicator" := GenJnlBatch."DOT Batch Indicator";
        end else begin
            CustLedgEntry."Batch Indicator" := '';
        end;

        CustLedgEntry."Authorised Person ID No." := GenJournalLine.AuthorisedPersonIDNo;
        CustLedgEntry."Tax E" := GenJournalLine."Tax E";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust. Entry-Edit", OnBeforeCustLedgEntryModify, '', false, false)]
    local procedure ModifyCustomerLedgEntryLine(var CustLedgEntry: Record "Cust. Ledger Entry"; FromCustLedgEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgEntry.Validate("Tax E", FromCustLedgEntry."Tax E");
    end;
}