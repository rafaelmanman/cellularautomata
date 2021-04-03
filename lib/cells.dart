library cells;

class Cells{
  Cells(){
  }

  static List<int> nextGeneration(var state, var rules){
    List<String> configurations = ["111", "110", "101", "100", "011", "010", "001", "000"];
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

  static List<List<int>> generate(int gen_number, int rule_number){  
    int gen_size = gen_number * 2 + 1;
    List<int> rules = numberToBinary(rule_number);
    List<int> state = [];

    for (int i=0; i<gen_size; i++) {
      state.add(0);
    }

    state[gen_number] = 1;

    nextGeneration(state, rules);
    List<List<int>> generations = [state];
    for(int i=0; i<gen_number; i++){
      List<int> new_state = nextGeneration(state, rules);
      generations.add(new_state);
      state = List.from(new_state);
    }

    return generations;
  }

  static List<int> numberToBinary(int rule_number) {
    List<int> binary_number = [];
    while (rule_number > 0) {
      binary_number.insert(0, rule_number % 2);
      rule_number = rule_number ~/ 2;
    }
    
    int pad_amount = 8-binary_number.length;

    for (int i=0; i<pad_amount; i++) {
      binary_number.insert(0,0);
    }

    return binary_number;
  }
}
