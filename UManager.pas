unit UManager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.TabNotBk, Vcl.Menus,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB, Data.Win.ADODB, Vcl.StdCtrls;

type
  TFMain = class(TForm)
    Menu: TMainMenu;
    Manager1: TMenuItem;
    N11: TMenuItem;
    Exit1: TMenuItem;
    ADO: TADOConnection;
    HinFormngKHcPhn1: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure welcome(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HinFormngKHcPhn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;
implementation
uses UChild1, UHeThong,UDangKy;

{$R *.dfm}
procedure msg(S:variant);
begin
  showmessage(vartostr(S));
end;


procedure TFMain.Exit1Click(Sender: TObject);
begin
  close();
end;
//ngay 26/9/2017
procedure TFMain.FormShow(Sender: TObject);
var s:STRING;
begin
    s:='Provider=SQLOLEDB.1;Password=12345;Persist Security Info=True;User ID=CauPoro;Initial Catalog=QLDaoTao_2017;Data Source=DESKTOP-B3TGDNV;';
    s:=s+'Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=DESKTOP-GV0ITAJ;Use Encryption for Data=False;Tag with column collation when possible=False';
    ADO.Connected:=False;
    ADO.ConnectionString:=s;
    ADO.Connected:=True;
    end;

procedure TFMain.HinFormngKHcPhn1Click(Sender: TObject);
begin
if FDangKy=nil then

   Application.CreateForm(TFDangKy,FDangKy);
   FDangKy.Show();
end;

procedure TFMain.N11Click(Sender: TObject);
begin
  Application.CreateForm(TFChild,FChild);
  FChild.Show();
end;

procedure TFMain.welcome(Sender: TObject);
begin
  //msg(123);
end;

end.
