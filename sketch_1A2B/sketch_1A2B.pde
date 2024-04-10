int[] answer = new int[4]; // 存储答案
int[] guess = new int[4]; // 存储猜测数字
String[] guesses = new String[10]; // 存储猜测结果的数组，最多存储10次猜测
int count = 0; // 标识位数
int guessCount = 0; // 记录已经存储的猜测结果数量
boolean correctGuess; // 用于标记是否猜对了
boolean gameOver; // 用于标记游戏是否结束

void setup() {
  size(600, 800); // 设置绘图窗口的大小为600x800像素
  textAlign(CENTER, CENTER); // 设置文本对齐方式为居中
  textSize(30); // 设置文本大小为20像素
  fill(255); // 设置填充颜色为白色
  
  generateAnswer(); // 自定义函数生成答案
}

void draw() {
  background(0); // 将背景设置为黑色
  
  if (gameOver) { // 如果游戏结束
    // 显示最后一次猜测的结果
    displayGuesses();
    // 显示游戏结束
    text("Game Over", width/2, 3*height/4 - 20);
    // 显示答案
    displayAnswer();
  } else { // 如果游戏未结束
    text("Guess the 4-digit number", width/2, 50); // 在画布中央顶部显示"Guess the 4-digit number"文本
    displayGuesses(); // 显示猜测结果
  }
}

void keyPressed() { // 键盘按下事件处理函数
  if (!gameOver) { // 只有游戏未结束时才能进行猜测
    if (key >= '0' && key <= '9') { // 如果按下的键是数字键
      if (count < 4) { // 如果猜测数字位数不超过4位
        guess[count] = key - '0'; // 将按下的数字键转换为整数并存储在guess数组中
        count++; // 数字位数加1
      }
    } else if (key == BACKSPACE) { // 如果按下的是退格键
      if (count > 0) { // 如果已经输入了数字
        count--; // 删除最后一位数字
      }
    } else if (key == ENTER) { // 如果按下的是回车键
      if (count == 4) { // 如果已经输入了4位数字
        checkGuess(); // 检查猜测结果
        count = 0; // 重置数字位数计数器
        guess = new int[4]; // 重置猜测数组
      }
    }
  }
  
  if (key == ' ' && !correctGuess) { // 如果按下的是空格键并且还没猜对
    gameOver = true; // 标记游戏结束
  }
}

void generateAnswer() { // 生成答案的函数
  boolean[] used = new boolean[10]; // 用于标记数字是否已经被使用过的数组
  for (int i = 0; i < 4; i++) { // 循环4次，生成4位数字的答案
    int number;
    do {
      number = int(random(10)); // 随机生成一个0到9之间的整数
    } while (used[number]); // 如果该数字已经被使用过，则重新生成
    answer[i] = number; // 将生成的数字存储在答案数组中
    used[number] = true; // 标记该数字已被使用过
  }
}

void checkGuess() { // 检查猜测结果的函数
  int A = 0; // 用于存储数字和位置都正确的数量
  int B = 0; // 用于存储数字正确但位置不正确的数量
  for (int i = 0; i < 4; i++) { // 循环遍历每一位数字
    if (guess[i] == answer[i]) { // 如果猜测的数字和位置都正确
      A++; // 数字和位置都正确的数量加1
    }
  }
  if (A == 4) { // 如果全部数字和位置都正确
    correctGuess = true; // 标记猜对了
    String result = ""; // 用于存储猜测结果的字符串
    for (int i = 0; i < 4; i++) { // 将猜测结果转换为字符串形式
      result += guess[i];
    }
    result += "  4A0B  Congratulations!"; // 在猜测结果后面添加“4A0B”，表示全部数字和位置都正确
    guesses[guessCount] = result; // 存储猜测结果到数组中
    guessCount++; // 记录猜测结果数量加1
  }
  else{
    for (int i = 0; i < 4; i++) { // 循环遍历每一位数字
      for (int j = 0; j < 4; j++) { // 再次循环遍历每一位数字
        if (guess[i] == answer[j] && guess[i] != answer[i] && guess[j] != answer[j]) { // 如果数字正确但位置不正确
          B++; // 数字正确但位置不正确的数量加1
          break; // 结束内层循环
        }
      }
    }
    String guessString = ""; // 用于存储猜测结果的字符串
    for (int i = 0; i < 4; i++) { // 将猜测结果转换为字符串形式
      guessString += guess[i];
    }
    String result = guessString + "  " + A + "A" + B + "B"; // 将猜测结果和A、B值组合成结果字符串
    guesses[guessCount] = result; // 存储猜测结果到数组中
    guessCount++; // 记录猜测结果数量加1
  }

  if (guessCount >= 10 && A != 4) { // 如果达到猜测次数上限或者猜对了
    gameOver = true; // 标记游戏结束
  }
}

void displayGuesses() { // 显示猜测结果的函数
  for (int i = 0; i < guessCount; i++) { // 循环遍历每一个猜测结果
    text(guesses[i], width/2, 100 + i * 30); // 在画布中央显示每一个猜测结果
  }
  String currentGuess = ""; // 用于存储当前正在输入的猜测结果的字符串
  for (int i = 0; i < count; i++) { // 将当前正在输入的猜测结果转换为字符串形式
    currentGuess += guess[i];
  }
  text(currentGuess, width/2, 150 + guessCount * 30); // 在画布中央显示当前正在输入的猜测结果
}

void displayAnswer() { // 显示答案的函数
  String ans = ""; // 用于存储答案的字符串
  for (int i = 0; i < 4; i++) { // 将答案数组中的数字转换为字符串形式
    ans += answer[i];
  }
  String result = "Answer: " + ans; // 将答案字符串组合成结果字符串
  text(result, width/2, height/2 + 50 + guessCount * 30); // 在画布中央显示答案字符串
}
