unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TRectang = class
  private
    coord: array [0..3] of Integer;
  public
    constructor Create(left, top, right, bottom: Integer); overload;
    constructor Create(topLeft, bottomRight: TPoint); overload;
    procedure Draw(Canvas: TCanvas); virtual;
  end;

type
  TEllipse = class(TRectang)
  public
    procedure Draw(Canvas: TCanvas); override;
  end;

type
  TLine = class
  private
    startPoint, endPoint: TPoint;
  public
    constructor Create(p1, p2: TPoint);
    procedure Draw(Canvas: TCanvas);
  end;

type
  TPolygon = class
  private
    points: array of TPoint;
  public
    constructor Create(p: array of TPoint);
    procedure Draw(Canvas: TCanvas);
  end;

type
  TForm1 = class(TForm)
    procedure FormPaint(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

constructor TRectang.Create(left, top, right, bottom: Integer);
begin
  coord[0] := left;
  coord[1] := top;
  coord[2] := right;
  coord[3] := bottom;
end;

constructor TRectang.Create(topLeft, bottomRight: TPoint);
begin
  coord[0] := topLeft.X;
  coord[1] := topLeft.Y;
  coord[2] := bottomRight.X;
  coord[3] := bottomRight.Y;
end;

procedure TRectang.Draw(Canvas: TCanvas);
begin
  Canvas.Rectangle(coord[0], coord[1], coord[2], coord[3]);
end;

procedure TEllipse.Draw(Canvas: TCanvas);
begin
  Canvas.Ellipse(coord[0], coord[1], coord[2], coord[3]);
end;

constructor TLine.Create(p1, p2: TPoint);
begin
  startPoint := p1;
  endPoint := p2;
end;

procedure TLine.Draw(Canvas: TCanvas);
begin
  Canvas.MoveTo(startPoint.X, startPoint.Y);
  Canvas.LineTo(endPoint.X, endPoint.Y);
end;

constructor TPolygon.Create(p: array of TPoint);
var
  i: Integer;
begin
  SetLength(points, Length(p));
  for i := 0 to High(p) do
    points[i] := p[i];
end;

procedure TPolygon.Draw(Canvas: TCanvas);
begin
  Canvas.Polygon(points);
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  rect1, rect2: TRectang;
  ellipse1: TEllipse;
  line1: TLine;
  polygon1: TPolygon;
  point1, point2, p1, p2: TPoint;
  polyPoints: array of TPoint;
begin
  point1 := Point(65, 75);
  point2 := Point(95, 100);
  rect1 := TRectang.Create(22, 43, 54, 75);
  rect2 := TRectang.Create(point1, point2);
  ellipse1 := TEllipse.Create(120, 50, 200, 120);
  p1 := Point(30, 150);
  p2 := Point(200, 200);
  line1 := TLine.Create(p1, p2);

  SetLength(polyPoints, 5);
  polyPoints[0] := Point(100, 250);
  polyPoints[1] := Point(150, 200);
  polyPoints[2] := Point(200, 250);
  polyPoints[3] := Point(180, 300);
  polyPoints[4] := Point(120, 300);
  polygon1 := TPolygon.Create(polyPoints);

  with Form1.Canvas do
  begin
    Pen.Width := 3;
    Pen.Color := clRed;
    rect1.Draw(Canvas);

    Pen.Width := 4;
    Pen.Color := clGreen;
    rect2.Draw(Canvas);

    Pen.Width := 2;
    Pen.Color := clBlue;
    ellipse1.Draw(Canvas);

    Pen.Width := 1;
    Pen.Color := clBlack;
    line1.Draw(Canvas);

    Pen.Color := clPurple;
    polygon1.Draw(Canvas);
  end;
end;

end.
