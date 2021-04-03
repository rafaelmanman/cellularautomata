
List<int> nextGeneration(var state){
  List<int> rules = [0, 1, 1, 1, 1, 0, 0, 0];
  List<String> configurations = ["000", "001", "010", "011", "100", "101", "110", "111"];
  var chunk = [];
  String config;
  List<int> new_state = [];
  state = List.from(state);
  state.add(0);
  state.insert(0, 0);
  
  for(int i=0; i<state.length-2; i++){
    chunk = state.sublist(i, i+3);
    config = chunk.map((bit) => bit.toString()).join('');
    int rule = configurations.indexWhere((item) => item == config);
    int next_cell = rules[rule]; 
    new_state.add(next_cell);
  }
  return new_state;
}

void printCells(var generations) {
  String full_block = "\u{2588}";
  String top_half = "\u{2580}";
  String bottom_half = "\u{2584}";

  generations.forEach((generation) {
    String cells = generation.map((bit) => bit.toString()).join('');
    cells = cells.replaceAll("1", full_block+full_block);
    cells = cells.replaceAll("0", " " + " ");
    print(cells);
  });

}

void printNewCells(var generations){
  String full_block = "\u{2588}";
  String top_half = "\u{2580}";
  String bottom_half = "\u{2584}";
  String line = "";

  for(int i=0; i<generations.length; i += 2){
    var top_generation = generations[i];
    var bottom_generation = generations[i+1];
    
    for (int k=0; k<generations[0].length; k++) {
      var top_cell = top_generation[k];
      var bottom_cell = bottom_generation[k];

      if (top_cell == 1 && bottom_cell == 1) {
        line += full_block;
      } else if (top_cell == 1 && bottom_cell == 0){
        line += top_half;
      } else if (top_cell == 0 && bottom_cell == 1){
        line += bottom_half;
      } else {
        line += " ";
      }
    }

    print(line);
    line = "";
  }
}

List<List<int>> generate(gen_number){  
  int gen_size = gen_number * 2 + 1;
  List<int> state = [];

  for (int i=0; i<gen_size; i++) {
    state.add(0);
  }

  state[gen_number] = 1;

  nextGeneration(state);
  List<List<int>> generations = [state];
  for(int i=0; i<gen_number; i++){
    List<int> new_state = nextGeneration(state);
    generations.add(new_state);
    state = List.from(new_state);
  }  
}

void main(){
  int gen_size = 19*5;
  int gen_number = gen_size ~/ 2;
  List<int> state = [];

  for (int i=0; i<gen_size; i++) {
    state.add(0);
  }

  state[gen_number] = 1;

  nextGeneration(state);
  List<List<int>> generations = [state];
  for(int i=0; i<gen_number; i++){
    List<int> new_state = nextGeneration(state);
    generations.add(new_state);
    state = List.from(new_state);
  }  
  
  printCells(generations);
  printNewCells(generations);

}
