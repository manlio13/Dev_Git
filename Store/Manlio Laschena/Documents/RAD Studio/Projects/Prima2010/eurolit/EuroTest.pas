{**************************************************************************************************}
{                                                                                                  }
{ MLSoft 2002                                                                  }
{ DUnit Test Unit                                                                                  }
{                                                                                                  }
{ Covers:      EuroConv                                                                            }
{ Last Update: 16/04/2002                                                                        }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{**************************************************************************************************}
unit EuroTest;

interface
Uses
TestFramework,
Euro,
sysutils,
dialogs;

 { TEuro}
type
TEuroconvTest = class(TTestCase)

 private
    FEurolit:Teurolit;
 public
   procedure Setup; override;
   procedure Teardown; override;
 published
 procedure EuroconvTest;
 end;


implementation
{TEuroConvTest}

procedure TEuroConvTest.Setup;
begin
FEurolit:=TEurolit.Create(FEurolit);     //crea l'istanza di eurolit
end;
procedure TEuroConvTest.TearDown;
begin
FEurolit.Free;   //libera l'istanza di Eurolit
end;

procedure TEuroConvTest.EuroConvTest;
 var
ed1,ed2:string;
begin
        try
ed1:='1';
FEurolit.Edit1.Text:=ed1;
FEuroLit.Button1Click(Self);
ed2:=FEurolit.Edit2.Text;
messagedlg(ed2,mtInformation,[mbOK],0);
ed1:='1936.27';
FEurolit.Edit1.Text:=ed1;
FEuroLit.Button2Click(Self);
ed2:=FEurolit.Edit2.Text;
messagedlg(ed2,mtInformation,[mbOK],0);
       except
       check(false);
       end;
end;
initialization
    RegisterTest('',TeuroconvTest.Suite);

end.
