import 'dart:html';
import '../lib/cells.dart';

CanvasElement canvas;
CanvasRenderingContext2D context;

void main(){
  InputElement size_element = querySelector("#size");
  InputElement rule_element = querySelector("#rule");
  InputElement cell_size_element = querySelector("#cell-size");
  ButtonElement submit_button = querySelector("#submit_button"); 
  canvas = querySelector("#mycanvas");
  context = canvas.getContext('2d');

  submit_button.onClick.listen((event) {
    var rule = int.parse(rule_element.value);
    var size = int.parse(size_element.value);
    var cell_size = int.parse(cell_size_element.value);
    generate(size, rule, cell_size);
  });
}


void generate(size, rule, cell_size) {
  int x = 0;
  int y = 0;
  var grid = Cells.generate(size, rule);
  
  canvas.width = grid[0].length * cell_size;
  canvas.height = grid.length * cell_size;

  context.clearRect(0,0, canvas.width, canvas.height);
  for(int i=0; i<grid.length; i++){
    List<int> row = grid[i];
    for(int k=0; k<row.length; k++){
      int cell = row[k];

      if (cell == 1) {
        context.fillRect(x,y, cell_size,cell_size);
      }
      x += cell_size;
    }
    x = 0;
    y += cell_size;
  }
}
