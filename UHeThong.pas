﻿unit UHeThong;
interface
uses //Winapi.Windows,System.Variants,Vcl.Dialogs,  Vcl.Grids, Vcl.DBGrids,  Vcl.DBCtrls
  Windows, Messages,  Classes, Graphics,
  Controls, Forms, Dialogs,
  StdCtrls, Menus, Db, ADODB, ExtCtrls, DBCtrls, ComCtrls, Buttons, Grids,
  DBGrids, Variants, DateUtils, OleServer, StrUtils, ToolWin,SysUtils,
  Commctrl, XPMan, ShellApi, Keyboard, AppEvnts, DBCGrids, ActnList, ExcelXP  ;

Const
Cot: array [1 .. 256] of string[2] = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
    'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
    'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ',
    'AK', 'AL', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV',
    'AW', 'AX', 'AY', 'AZ', 'BA', 'BB', 'BC', 'BD', 'BE', 'BF', 'BG', 'BH',
    'BI', 'BJ', 'BK', 'BL', 'BM', 'BN', 'BO', 'BP', 'BQ', 'BR', 'BS', 'BT',
    'BU', 'BV', 'BW', 'BX', 'BY', 'BZ', 'CA', 'CB', 'CC', 'CD', 'CE', 'CF',
    'CG', 'CH', 'CI', 'CJ', 'CK', 'CL', 'CM', 'CN', 'CO', 'CP', 'CQ', 'CR',
    'CS', 'CT', 'CU', 'CV', 'CW', 'CX', 'CY', 'CZ', 'DA', 'DB', 'DC', 'DD',
    'DE', 'DF', 'DG', 'DH', 'DI', 'DJ', 'DK', 'DL', 'DM', 'DN', 'DO', 'DP',
    'DQ', 'DR', 'DS', 'DT', 'DU', 'DV', 'DW', 'DX', 'DY', 'DZ', 'EA', 'EB',
    'EC', 'ED', 'EE', 'EF', 'EG', 'EH', 'EI', 'EJ', 'EK', 'EL', 'EM', 'EN',
    'EO', 'EP', 'EQ', 'ER', 'ES', 'ET', 'EU', 'EV', 'EW', 'EX', 'EY', 'EZ',
    'FA', 'FB', 'FC', 'FD', 'FE', 'FF', 'FG', 'FH', 'FI', 'FJ', 'FK', 'FL',
    'FM', 'FN', 'FO', 'FP', 'FQ', 'FR', 'FS', 'FT', 'FU', 'FV', 'FW', 'FX',
    'FY', 'FZ', 'GA', 'GB', 'GC', 'GD', 'GE', 'GF', 'GG', 'GH', 'GI', 'GJ',
    'GK', 'GL', 'GM', 'GN', 'GO', 'GP', 'GQ', 'GR', 'GS', 'GT', 'GU', 'GV',
    'GW', 'GX', 'GY', 'GZ', 'HA', 'HB', 'HC', 'HD', 'HE', 'HF', 'HG', 'HH',
    'HI', 'HJ', 'HK', 'HL', 'HM', 'HN', 'HO', 'HP', 'HQ', 'HR', 'HS', 'HT',
    'HU', 'HV', 'HW', 'HX', 'HY', 'HZ', 'IA', 'IB', 'IC', 'ID', 'IE', 'IF',
    'IG', 'IH', 'II', 'IJ', 'IK', 'IL', 'IM', 'IN', 'IO', 'IP', 'IQ', 'IR',
    'IS', 'IT', 'IU', 'IV');

  CoLor16: array [0 .. 15] of TColor = (clGreen, clOlive, clNavy, clPurple,
    clTeal, clGray, clGreen, clRed, clLime, clYellow, clBlue, clFuchsia, clAqua,
    clLtGray, clDkGray, clWhite);

procedure msg(S:variant);
procedure DrawColumnCell(DBGrid1: TDBGrid; DBCheckBox1: TDBCheckBox;
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
procedure ColExit(DBGrid1: TDBGrid; DBCheckBox1: TDBCheckBox; Sender: TObject);
procedure ChuyenSangExcel(E: TExcelApplication; Grid: TDBGrid);
procedure ChuyenDataSetToExcel(E: TExcelApplication; Dataset: TADODataSet);


implementation

///////////////////////////////////////////////////////////////////////////
procedure TenForm_GDiemRLDblClick(Sender: TObject);
begin
//Hướng dẫn: Bên Form FMain có khai báo E: TExcelApplication là thành phần của form
// TExcelApplication  trên Component Servers , Gọi lên sau đây:
//ChuyenSangExcel(FMain.E , GDiemRL);
end;
///////////////////////////////////////////////////////////////////////////
//TenForm gọi phương thức DrawColumnCell, thay đổi màu các dòng chẵn lẻ, thêm CheckBox vào lưới
procedure TenForm_DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TColumn; State: TGridDrawState);
  var
    grid: TDBGrid;
    row: Integer;
  begin
    grid := Sender as TDBGrid;
    row := grid.DataSource.DataSet.RecNo;
    if Odd(row) then
      grid.Canvas.Brush.Color := clMoneyGreen;
    // clMenuHighlight;//clNavy ; //clMedGray  ;//clSilver;
    grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    //DrawColumnCell(grid, DBCheckBox1, Sender, Rect, DataCol, Column, State);
    //DrawColumnCell(grid, DBCheckBox2, Sender, Rect, DataCol, Column, State);
    //DrawColumnCell(grid, DBCheckBox3, Sender, Rect, DataCol, Column, State);
  end;
////////////////////////////////////////////////////////////////////////////
procedure TenForm_DBGrid1ColExit(Sender: TObject);
var
  grid: TDBGrid;
begin
  grid := Sender as TDBGrid;
  //ColExit(grid, DBCheckBox1, Sender);
  //ColExit(grid, DBCheckBox2, Sender);
  //ColExit(grid, DBCheckBox3, Sender);
end;
///////////////////////////////////////////////////////////////////////////
procedure TenForm_DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  grid: TDBGrid;
begin
grid := Sender as TDBGrid;
  if (Key = 40) then
    if grid.DataSource.DataSet.RecNo = grid.DataSource.DataSet.RecordCount
    then
      Key := 0;
end;

///////////////////////////////////////////////////////////////////////////////

procedure msg(S:variant);
begin
  showmessage(vartostr(S));
end;
///////////////////////////////////////////////////////////////////////////////
procedure DrawColumnCell(DBGrid1: TDBGrid; DBCheckBox1: TDBCheckBox;
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
const
  IsChecked: array [Boolean] of Integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or
    DFCS_CHECKED);
var
  DrawState: Integer;
  DrawRect: TRect;
begin
  try
    if (gdFocused in State) then
    begin
      if (Column.Field.FieldName = DBCheckBox1.DataField) then
      begin
        DBCheckBox1.ReadOnly := Column.ReadOnly;
        DBCheckBox1.Left := Rect.Left + DBGrid1.Left + 2;
        DBCheckBox1.Top := Rect.Top + DBGrid1.Top + 2;
        DBCheckBox1.Width := Rect.Right - Rect.Left;
        DBCheckBox1.Height := Rect.Bottom - Rect.Top;
        DBCheckBox1.Visible := TRUE;
      end
    end
    else
    begin
      if (Column.Field.FieldName = DBCheckBox1.DataField) then
      begin
        DBCheckBox1.ReadOnly := Column.ReadOnly;
        DrawRect := Rect;
        InflateRect(DrawRect, -1, -1);
        DrawState := IsChecked[Column.Field.AsBoolean];
        DBGrid1.Canvas.FillRect(Rect);
        DrawFrameControl(DBGrid1.Canvas.Handle, DrawRect, DFC_BUTTON,
          DrawState);
      end;
    end;
  except
    ;
  end;
end;
//////////////////////////////////////////////////////////////////////////////
procedure ColExit(DBGrid1: TDBGrid; DBCheckBox1: TDBCheckBox; Sender: TObject);
begin
  if DBGrid1.SelectedField.FieldName = DBCheckBox1.DataField then
    DBCheckBox1.Visible := false
end;
//////////////////////////////////////////////////////////////////////////////
{ ======================================================= }
Function CotHang(C, H: Integer): string;
begin
  Result := Cot[C] + inttostr(H);
end;

{ ======================================================= }
Procedure SetValue(E: TExcelApplication; C, H: Integer; V: Variant);
var
  R: ExcelRange;
begin
  R := E.Range[CotHang(C, H), CotHang(C, H)];
  R.Value2 := '''' + V;
end;

{ ======================================================= }
Function GetValue(E: TExcelApplication; C, H: Integer): Variant;
var
  R: ExcelRange;
  V: Variant;
begin
  R := E.Range[CotHang(C, H), CotHang(C, H)];
  V := R.Value2;
  Result := V;
end;

{ ======================================================= }
Procedure GiaTri(E: TExcelApplication; C, H: Integer; V: Variant; Format: byte;
  Orient: byte);
var
  R: ExcelRange;
begin
  if Format < 10 then
  begin
    R := E.Range[CotHang(C, H), CotHang(C, H)];
    R.Value2 := '''' + V;
    R := E.Range[CotHang(C, H), CotHang(C, H + 1)];
    R.AutoFormat(Format, null, null, null, null, null, null);
  end
  else
  begin
    R := E.Range[CotHang(C, H), CotHang(C, H)];
    R.Value2 := '''' + V;
    R := E.Range[CotHang(C, H), CotHang(C, H + 1)];
    R.AutoFormat(Format, null, null, null, null, null, null);
    R := E.Range[CotHang(C, H + 1), CotHang(C, H + 2)];
    R.AutoFormat(0, null, null, null, null, null, null);
  end;
  R := E.Range[CotHang(C, H), CotHang(C, H)];
  R.Orientation := Orient;
  R.BorderAround(1, 1, 1, 1);
end;

{ ======================================================= }
Procedure GiaTri2(E: TExcelApplication; C, H: Integer; V: Variant; Format: byte;
  Orient: byte; Text: byte);
var
  R: ExcelRange;
begin
  if Format < 10 then
  begin
    R := E.Range[CotHang(C, H), CotHang(C, H)];
    if Text = 0 then
      R.Value2 := V
    else
      R.Value2 := '''' + V;

    R := E.Range[CotHang(C, H), CotHang(C, H + 1)];
    R.AutoFormat(Format, null, null, null, null, null, null);
  end
  else
  begin
    R := E.Range[CotHang(C, H), CotHang(C, H)];
    if Text = 0 then
      R.Value2 := V
    else
      R.Value2 := '''' + V;
    R := E.Range[CotHang(C, H), CotHang(C, H + 1)];
    R.AutoFormat(Format, null, null, null, null, null, null);
    R := E.Range[CotHang(C, H + 1), CotHang(C, H + 2)];
    R.AutoFormat(0, null, null, null, null, null, null);
  end;
  R := E.Range[CotHang(C, H), CotHang(C, H)];
  R.Orientation := Orient;
  R.BorderAround(1, 1, 1, 1);
end;

// ===============================================================================================
procedure ChuyenSangExcel(E: TExcelApplication; Grid: TDBGrid);
var
  R, tam: ExcelRange;
  i, j: Integer;
  S: string;
begin
  E.Visible[0] := TRUE;
  E.Workbooks.Add(null, 0);

  for i := 1 to Grid.Columns.Count do
    GiaTri(E, i, 1, Grid.Columns.Items[i - 1].Title.Caption, 0, 0);
  Grid.DataSource.Dataset.First;
  while not Grid.DataSource.Dataset.Eof do
  begin
    for j := 0 to Grid.Columns.Count - 1 do
    begin
      if Grid.DataSource.Dataset.FieldByName(Grid.Columns.Items[j].FieldName)
        .DataType in [ftBoolean] then
      begin
        if Grid.DataSource.Dataset.FieldByName(Grid.Columns.Items[j].FieldName)
          .AsBoolean = TRUE then
          GiaTri(E, j + 1, Grid.DataSource.Dataset.RecNo + 1, 'X', 0, 0)
        else
          GiaTri(E, j + 1, Grid.DataSource.Dataset.RecNo + 1, '', 0, 0);
      end
      else if Grid.DataSource.Dataset.FieldByName(Grid.Columns.Items[j].FieldName).DataType
        in [ftString,ftWideString,ftDate, ftTime, ftDateTime] then //Text
        GiaTri(E, j + 1, Grid.DataSource.Dataset.RecNo + 1,Grid.DataSource.Dataset.FieldByName(Grid.Columns.Items[j].FieldName).AsString, 0, 0)
      else   //Số
        GiaTri2(E, j + 1, Grid.DataSource.Dataset.RecNo + 1,Grid.DataSource.Dataset.FieldByName(Grid.Columns.Items[j].FieldName).AsString, 0, 0, 0);

    end;
    Grid.DataSource.Dataset.Next;
  end;
  // E.Disconnect ;

end;

{ ======================================================= }
procedure ChuyenDataSetToExcel(E: TExcelApplication; Dataset: TADODataSet);
var
  R, tam: ExcelRange;
  i, j: Integer;
  S: string;
begin
  E.Visible[0] := TRUE;
  E.Workbooks.Add(null, 0);

  for i := 1 to Dataset.FieldCount do
    GiaTri(E, i, 1, Dataset.Fields.Fields[i - 1].FieldName, 0, 0);
  Dataset.First;
  while not Dataset.Eof do
  begin
    for j := 0 to Dataset.FieldCount - 1 do
    begin
      if Dataset.Fields.Fields[j].DataType in [ftBoolean] then
      begin
        if Dataset.Fields.Fields[j].AsBoolean = TRUE then
          GiaTri(E, j + 1, Dataset.RecNo + 1, 'X', 0, 0)
        else
          GiaTri(E, j + 1, Dataset.RecNo + 1, '', 0, 0);
      end
      else if Dataset.Fields.Fields[j].DataType
        //in [ftSmallint, ftInteger, ftFloat, ftBytes, ftAutoInc, ftWord] then
        in [ftString,ftWideString,ftDate, ftTime, ftDateTime] then //Text
          GiaTri(E, j + 1, Dataset.RecNo + 1,
          Dataset.Fields.Fields[j].AsString, 0, 0)
      else
          GiaTri2(E, j + 1, Dataset.RecNo + 1,
          Dataset.Fields.Fields[j].AsString, 0, 0, 0) ;
    end;
    Dataset.Next;
  end;
  // E.Disconnect ;

end;


end.
