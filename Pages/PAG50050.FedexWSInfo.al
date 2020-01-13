page 50050 OrderHistory
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Fedex WS Info';
    SourceTable = FedexReqRes;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Serial No.";"Serial No.")
                {
                    ApplicationArea = All;
                    Caption = 'Serial No.';
                    Editable = false;
                }
                field("WS Status"; "WS Status")
                {
                    ApplicationArea = All;
                    Caption = 'WS Status';
                }
                field("WS Message"; "WS Message")
                {
                    ApplicationArea = All;
                    Caption = 'WS Message';
                }
                field("SOAP Request DateTime"; "SOAP Request DateTime")
                {
                    ApplicationArea = All;
                    Caption = 'SOAP Request DateTime';
                }
                field("SOAP Response DateTime"; "SOAP Response DateTime")
                {
                    ApplicationArea = All;
                    Caption = 'SOAP Response DateTime';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            Group("Web Service Action")
            {
                action("Call SRV WS")
                {
                    Caption = 'Call Srv WS';
                    ToolTip = 'Call Srv WS';
                    Image = ExecuteBatch;
                    ApplicationArea = All;
                    trigger OnAction()
                    var 
                      FedexWS : Codeunit FedexSrvAvailabilityWS;
                    begin
                        FedexWS.SrvExecute();
                    end;
                }
                action("Check Fedex Request")
                {
                    Caption = 'Check Fedex Request';
                    ToolTip = 'Check Fedex Request';
                    Image = Check;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ViewRequest();
                    end;
                }
                action("Check Fedex Response")
                {
                    Caption = 'Check Fedex Response';
                    ToolTip = 'Check Fedex Response';
                    Image = Check;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ViewResponse();
                    end;
                }
                action("NoNS Fedex Response")
                {
                    Caption = 'NoNS Fedex Response';
                    ToolTip = 'NoNS Fedex Response';
                    Image = Check;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ViewResponseNoNS();
                    end;
                }
            }
        }
    }
}