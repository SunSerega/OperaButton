##
uses System.IO, System.Text;

function ReadMessage(self: BinaryReader): string; extensionmethod;
begin
  var c := self.ReadInt32;
  
  var bytes := self.ReadBytes(c);
  if c<>bytes.Length then
    raise new Exception($'{c} <> {bytes.Length}');
  
  Result := Encoding.UTF8.GetString(bytes);
end;
procedure WriteMessage(self: BinaryWriter; m: string); extensionmethod;
begin
  var bytes := Encoding.UTF8.GetBytes($'"{m}"');
  
  self.Write(bytes.Length);
  self.Write(bytes);
  
end;

{$reference System.Windows.Forms.dll}

try
  var br := new System.IO.BinaryReader(Console.OpenStandardInput);
  var bw := new System.IO.BinaryWriter(Console.OpenStandardOutput);
  
  var m := br.ReadMessage;
//  System.Windows.Forms.MessageBox.Show(m);
  
  //TODO Implement better system, because this isn't just yt
  System.Diagnostics.Process.Start('C:\0\Prog\yt-dlp\Скачать с ютуба.exe', m);
  
  bw.WriteMessage('Done');
except
  on e: Exception do
    System.Windows.Forms.MessageBox.Show(e.ToString);
end;