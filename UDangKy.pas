﻿unit UDangKy;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Data.Win.ADODB,
  Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TFDangKy = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Panel4: TPanel;
    Splitter2: TSplitter;
    Panel5: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    TKhoa: TADOTable;
    DSKhoa: TDataSource;
    TLop: TADOQuery;
    DSLop: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel10: TPanel;
    DBGrid1: TDBGrid;
    TLLSV: TADODataSet;
    DSLLSV: TDataSource;
    Label3: TLabel;
    Panel6: TPanel;
    DBText1: TDBText;
    THK: TADODataSet;
    DSHK: TDataSource;
    Panel11: TPanel;
    DBNavigator1: TDBNavigator;
    DBText2: TDBText;
    DBCheckBox1: TDBCheckBox;
    TKHHT: TADODataSet;
    DSKHHT: TDataSource;
    Label4: TLabel;
    DBGrid2: TDBGrid;
    DBCheckBox2: TDBCheckBox;
    TLopHP: TADODataSet;
    DSLopHP: TDataSource;
    DBGrid3: TDBGrid;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    btDelete: TBitBtn;
    BitBtn2: TBitBtn;
    ADOQ: TADOQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TKhoaAfterScroll(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure TLopAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TColumn; State: TGridDrawState);
//    procedure TKHHTAfterScroll(DataSet: TDataSet);
   procedure TLopHPAfterScroll(DataSet: TDataSet);
    procedure TKHHTAfterScroll(DataSet: TDataSet);
    procedure btDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDangKy: TFDangKy;

implementation
uses UManager,UHeThong;
{$R *.dfm}

procedure TFDangKy.btDeleteClick(Sender: TObject);
var s:string;
i:integer;
k:integer;
begin
if IDYES=Application.MessageBox('Bạn thật sự muốn xóa mẫu tin ?','Note!',MB_YESNO) then
msg(k);
 s:='EXEC SP_Delete_BangDiem ' +TLopHP.FieldByName('BangDiemID').AsString;
    ADOQ.Close;
    ADOQ.SQL.Clear;
    ADOQ.SQL.Add(s);
    ADOQ.ExecSQL;
    TLopHp.Requery();
    TLopHP.RecNo:=i;
end;

procedure TFDangKy.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  grid: TDBGrid;
  row: Integer;
begin
  grid := Sender as TDBGrid;
  row := grid.DataSource.DataSet.RecNo;
  if Odd(row) then
  begin
    grid.Canvas.Brush.Color := clMedGray;
    font.Size:=12;
  end
  else
    grid.Canvas.Brush.Color := clPurple;

  // clMenuHighlight;//clNavy ; //clMedGray  ;//clSilver;
  grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  DrawColumnCell(grid, DBCheckBox1, Sender, Rect, DataCol, Column, State);
  //DrawColumnCell(grid, DBCheckBox2, Sender, Rect, DataCol, Column, State);
  //DrawColumnCell(grid, DBCheckBox3, Sender, Rect, DataCol, Column, State);
end;

procedure TFDangKy.DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  grid: TDBGrid;
  row: Integer;
begin
  grid := Sender as TDBGrid;
  row := grid.DataSource.DataSet.RecNo;
  if Odd(row) then
  begin
    grid.Canvas.Brush.Color := clMedGray;
    font.Size:=12;
  end
  else
    grid.Canvas.Brush.Color := clPurple;

  // clMenuHighlight;//clNavy ; //clMedGray  ;//clSilver;
  grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  DrawColumnCell(grid, DBCheckBox2, Sender, Rect, DataCol, Column, State);
  DrawColumnCell(grid, DBCheckBox3, Sender, Rect, DataCol, Column, State);
  DrawColumnCell(grid, DBCheckBox4, Sender, Rect, DataCol, Column, State);
end;

procedure TFDangKy.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=cafree;
  FDangKy:=nil;
end;

procedure TFDangKy.FormShow(Sender: TObject);
begin
TKhoa.Active:=True;
THK.Active:=True;
THK.Locate('HocKy;NamHoc', VarArrayOf(['1','2016']), [loPartialKey]);

end;

//procedure TFDangKy.TKHHTAfterScroll(DataSet: TDataSet);
//var s:string;
//begin
//  s:='select *from FC_LopHP('+dataset.FieldByName('KeHoachID').AsString+')';
//  TLopHp.Active:=false;
//  TLopHP.CommandText:=s;
//  TLopHP.Active:=True;
//end;

procedure TFDangKy.TKHHTAfterScroll(DataSet: TDataSet);
       var s:string;
begin
  s:='select *from FC_LopHP('+dataset.FieldByName('KeHoachID').AsString+')';
  TLopHp.Active:=false;
  TLopHP.CommandText:=s;
  TLopHP.Active:=True;

  btDelete.Enabled:=(not Dataset.FieldByName('XNBP').AsBoolean)or
                     (not Dataset.FieldByName('XN1').AsBoolean);
end;

procedure TFDangKy.TKhoaAfterScroll(DataSet: TDataSet);
var s:string;
begin
s:='Select * From Lop where MaKhoa='+DataSet.FieldByName('MaKhoa').Asstring;
TLop.Active:=False;
TLop.SQL.Clear;
TLop.SQL.Add(s);
TLop.Active:=True;
end;

procedure TFDangKy.TLopAfterScroll(DataSet: TDataSet);
var s:string;
begin
  s:='exec SP_DSSV '''+TLop.FieldByName('MaLop').AsString + '''';
 //msg(s);
 TLLSV.Active:=false;
 TLLSV.CommandText:=s;
 TLLSV.Active:=true;
 if THK.Active then
 begin
 s:='SELECT * FROM FC_KHHT(''' +TLop.FieldByName('MaLop').Asstring+''','+THK.FieldByName('HocKy').AsString +
 ','+ THK.FieldByName('NamHoc').AsString+')';
 TKHHT.Active:=False;
 TKHHT.CommandText:=s;
 TKHHT.Active:=True;
end;
end;

procedure TFDangKy.TLopHPAfterScroll(DataSet: TDataSet);
var s:string;
begin
  s:='select *from FC_LopHP('+TLopHP.FieldByName('KeHoachID').AsString+')';
  TLopHp.Active:=false;
  TLopHP.CommandText:=s;
  TLopHP.Active:=True;
end;

end.
