page 50051 ApiCustPage
{
    PageType = API;
    Caption = 'apiPageName';
    APIPublisher = 'KSPL';
    APIGroup = 'KSPLGrp';
    APIVersion = 'v1.0';
    EntityName = 'APICust';
    EntitySetName = 'CustSetName';
    SourceTable = Customer;
    DelayedInsert = true;
    
    layout
    {
        area(Content)
        {
            repeater(Listing)
            {
                field("No";"No.")
                {
                    Caption = 'Customer No.';
                    
                }
            }
        }
    }
}