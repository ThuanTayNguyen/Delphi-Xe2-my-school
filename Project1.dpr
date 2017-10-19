program Project1;

uses
  Vcl.Forms,
  UManager in 'UManager.pas' {FMain},
  UHeThong in 'UHeThong.pas',
  UChild1 in 'UChild1.pas' {Form2},
  UDangKy in 'UDangKy.pas' {FDangKy};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  //Application.CreateForm(TFDangKy, FDangKy);
  //Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
