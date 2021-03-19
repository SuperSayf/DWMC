unit Main_U;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects, FMX.Filter.Effects,
  FMX.Maps, FMX.Colors, FMX.Edit, FMX.ScrollBox, FMX.Memo, FMX.ListBox,
  IdMultipartFormData,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TfrmMain = class(TForm)
    StyleBook1: TStyleBook;
    edtAvatar: TEdit;
    edtName: TEdit;
    memoMessage: TMemo;
    lblAvatar: TLabel;
    lblName: TLabel;
    lblMessage: TLabel;
    cmbChannel: TComboBox;
    btnSend: TButton;
    httpclient1: TIdHTTP;
    lblSuperSayf: TLabel;
    btnAddWebhook: TButton;
    procedure btnSendClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}

procedure TfrmMain.btnSendClick(Sender: TObject);
var
  sMessage, sUsername, sAvatar, sChannel: String;
  params: TIdMultipartFormDataStream;
begin

  sMessage := memoMessage.Text;
  sUsername := edtName.Text;
  sAvatar := edtAvatar.Text;

  if sAvatar = '' then
  begin
    sAvatar :=
      'https://e7.pngegg.com/pngimages/888/805/png-clipart-discord-computer-icons-android-icons-combat-arena-android-game-smiley-thumbnail.png';
  end;

  case cmbChannel.ItemIndex of

    0:
      sChannel :=
        'https://discord.com/api/webhooks/822219858383994963/uNkzI33Lzissz7-cYq2n-41TrutTc5Q49B6eNGqaYJtHn5k-1x2N7R23E4NFRdXszMuq';

    1:
      sChannel :=
        'https://discord.com/api/webhooks/822219948985942077/df9Q4vL6Lvd___qW0lNqsJ-zzdg5Nw2P5xLqOAE5XqgwmUSCULIVGpUMuMiY3S18zeVP';

    2:
      sChannel :=
        'https://discord.com/api/webhooks/822206833921228850/oBzUaxlxA9wjy2hPzkekBP8EXGEs1RprbLqma_boTsgH3HrapDq_gGu_mwGZxZgLeRs1'

  end;

  if (cmbChannel.ItemIndex <> -1) then
  begin
    params := TIdMultipartFormDataStream.Create;
    try
      params.AddFormField('content', sMessage);
      params.AddFormField('username', sUsername);
      params.AddFormField('avatar_url', sAvatar);

      httpclient1.Request.UserAgent :=
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36';
      httpclient1.Post(sChannel, params);
    finally
      params.Free;
    end;
    memoMessage.ClearContent;
    memoMessage.SetFocus;
  end
  else
  begin
    ShowMessage('Please choose a channel to send a message');
    cmbChannel.SetFocus;
  end;

end;

procedure TfrmMain.FormActivate(Sender: TObject);
var
  myFile: TextFile;
  Text, sChannel: string;
  iCount, iPos: integer;
begin
  iCount := 0;

  if FileExists('Data.txt') then
  begin
    AssignFile(myFile, 'Data.txt');
    Reset(myFile);
  end
  else
  begin
    FileCreate('Data.txt');
    AssignFile(myFile, 'Data.txt');
    Reset(myFile);
  end;

  while not Eof(myFile) do
  begin
    ReadLn(myFile, Text);
    iPos := Pos('#', Text);
    sChannel := Copy(Text, 1, iPos - 1);
    cmbChannel.Items[iCount] := sChannel;
    Inc(iCount);
  end;

  CloseFile(myFile);

end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Left := (Screen.Width - Width) div 2;
  Top := (Screen.Height - Height) div 2;

end;

end.
