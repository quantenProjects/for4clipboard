unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Spin, Clipbrd,Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button1Go: TButton;
    Button2: TButton;
    Button2GoCopyClose: TButton;
    Button3CopyClose: TButton;
    Button4Selc: TButton;
    FloatSpinEdit1Begin: TFloatSpinEdit;
    FloatSpinEdit2End: TFloatSpinEdit;
    FloatSpinEdit2Step: TFloatSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabeledEdit1: TLabeledEdit;
    Memo1: TMemo;
    RadioGroup1: TRadioGroup;
    SpinEdit1: TSpinEdit;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button1GoClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button2GoCopyCloseClick(Sender: TObject);
    procedure Button3CopyCloseClick(Sender: TObject);
    procedure Button4SelcClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    function formatStep(akk:Double):String;
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  killOnTimer:Boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   killOnTimer:=false;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin

  if ssCtrl in Shift then
  begin
    if Key=71 then Button1GoClick(Sender);  //ctrl g
    if Key=70 then Button4SelcClick(Sender); //ctlr f
    if ssShift in Shift then begin
      if Key =67 then Button3CopyCloseClick(Sender); //ctrl shift c
    end;
  end;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if Clipboard.HasFormat(CF_Text) then
  begin
    Memo1.Append(Clipboard.AsText);
  end;

end;

procedure TForm1.Button1GoClick(Sender: TObject);
var
  begining, ending, step, akk: double;
    stringVorlage:string;
    stringsWork:TStrings;
begin

  begining := FloatSpinEdit1Begin.Value;
  ending := FloatSpinEdit2End.Value;
  step := FloatSpinEdit2Step.Value;
  akk := begining;
  begin
    stringVorlage:=Memo1.Text;
    stringsWork:= Memo1.Lines;
    Memo1.Clear;
    while akk < ending do
    begin
      stringsWork.Append(StringReplace(stringVorlage,LabeledEdit1.Text,formatStep(akk),[rfReplaceAll]));
      akk := akk + step;
    end;
    Memo1.Lines := stringsWork;
  end



end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage('CTRL G for Go - CTRL F for selec - CTRL SHIFT C for Copy and Close');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   Clipboard.AsText:=Memo1.Text;
end;

procedure TForm1.Button2GoCopyCloseClick(Sender: TObject);
begin
   Button1GoClick(Sender);
  Clipboard.AsText:=Memo1.Text;
     killOnTimer:=true;
  Timer1.Enabled:=true;

end;

procedure TForm1.Button3CopyCloseClick(Sender: TObject);
begin
  Clipboard.AsText:=Memo1.Text;
  killOnTimer:=true;
  Timer1.Enabled:=true;
end;

procedure TForm1.Button4SelcClick(Sender: TObject);
begin
  LabeledEdit1.Text := Memo1.SelText;
end;

function TForm1.formatStep(akk:Double):String;
var res:string;
    format:TFormatSettings;
begin
  if RadioGroup1.ItemIndex = 0 then format.DecimalSeparator:='.' else format.DecimalSeparator:=',';
  format.ThousandSeparator:=Char('');

  if trunc(akk) = akk then
  begin
    res:=IntToStr( trunc(akk));
  end
  else
  begin
    res := FloatToStr(trunc(akk*power(10,SpinEdit1.Value))/power(10,SpinEdit1.Value),format);
  end;
  formatStep:=res;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if killOnTimer then Application.Terminate;
end;

end.

