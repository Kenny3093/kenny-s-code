int x,y,speedx,speedy,kby,kscore,mscore,flg;
/*
x,y為球的位置
speedx,speedy球的速度
kby二號玩家的位置(鍵盤操控W、S為上下移動鍵)
kscore,mscore一、二號玩家的分數
flg作為分數計數器的變數，使分數每次只加一分
*/
void setup(){
  fullScreen();//全螢幕
  x=width/2; y=height/2;//球的初始位置
  speedx=floor(random(-30,30)); speedy=floor(random(-30,30));//運用隨機變數設定球的速度，讓球的速度界在x、y向30以內，正負代表左右
  kby=height/2;//二號玩家初始位置
  frameRate(1000);//每秒1000幀
  kscore=mscore=flg=0;//初始分數為0
}

void draw(){//繪製足球場造型的場地
  background(#0DB421);//背景為草地顏色
  stroke(255);strokeWeight(7);fill(#0DB421);circle(width/2,height/2,250);line(width/2,0,width/2,height);//中線
  rectMode(CORNER); noFill();rect(0,0,width,height);//邊線
  arc(width/4,height/2,250,250,PI*-1/2,PI*1/2,OPEN);rect(0,height/5,width/4,3*height/5);rect(0,height/3,width/12,height/3);
  fill(255);circle(width/6,height/2,20);//左邊禁區
  noFill();
  arc(3*width/4,height/2,250,250,PI*1/2,PI*3/2,OPEN);rect(3*width/4,height/5,width/4,3*height/5);rect(11*width/12,height/3,width/12,height/3);
  fill(255);circle(5*width/6,height/2,20);//右邊禁區
  noFill();
  arc(0,0,100,100,0,PI*1/2,OPEN);arc(width,0,100,100,PI*1/2,PI,OPEN);arc(0,height,100,100,PI*3/2,2*PI,OPEN);arc(width,height,100,100,PI,PI*3/2,OPEN);//角球位置
  fill(255);circle(x,y,70);fill(0);circle(x,y,50);//繪製足球造型的球
  
  rectMode(CENTER);rect(width-10,mouseY,20,200);//以輸入座標為中心畫矩形作為1號玩家
  
  x=x+speedx; y=y+speedy;//動畫中球的位置
  if(y>=height-35||y<=35)  speedy=-1*speedy;//使球撞擊到上下邊界會反彈
  if(x>=width-55&&(y>=mouseY-100&&y<=mouseY+100))  speedx=-1*speedx;//使球撞擊到1號玩家會反彈
  else if(x>width+35){
    if(flg==0){
      kscore++;//當1號玩家漏接，2號玩家得分
      flg=1;//flg從0變1使分數不會無止盡累加
    }
    speedx=0;//當1號玩家漏接，球不再x方向上移動，否則在符合的條件下會再反彈回來
  }
  
  rectMode(CENTER);rect(10,kby,20,200);//以輸入座標為中心畫矩形作為2號玩家
  
  if(keyPressed){
    if(key=='w'&&kby>=0)  kby=kby-10;//按下w，二號玩家往上10個像素(要注意的是螢幕坐標系的y軸正向為下方)
    if(key=='s'&&kby<=height)  kby=kby+10;//按下w，二號玩家往下10個像素
  }
  if(x<=55&&y<=kby+100&&y>=kby-100)  speedx=-1*speedx;//使球撞擊到2號玩家會反彈
  else if(x<=-55){
    if(flg==0)
    {
      mscore++;
      flg=1;
    }
    speedx=0;//1號玩家得分
  }
  
  fill(255);
  textSize(228);
  text(mscore,width-300,200);//1號玩家分數
  text(kscore,300,200);//2號玩家分數
}

void mousePressed(){
  x=width/2; y=height/2;
  speedx=floor(random(-30,30));speedy=floor(random(-40,40));
  flg=0;
}//當按下滑鼠，重新開球
