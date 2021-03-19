program DWMC;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main_U in 'Main_U.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
