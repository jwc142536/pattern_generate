class pattern{
  pattern(){ 
}
  
  
  void rect_pos_def(){
    
    for(int i=0 ; i<4 ; i++){                                   //random chose siz_y
      ran_seq();
      for(int j=0 ; j<4 ; j++)  y_siz[i][j] = new_seq[j];
    }
    
    ran_seq();                                                  //random chose siz_x
    for(int j=0 ; j<4 ; j++)  x_siz[j][0] = new_seq[j];
    
    ran_seq();
    if(y_siz[0][0] != y_siz[0][1])  x_siz[0][1] = x_siz[0][0];
    if(y_siz[0][1] != y_siz[0][2])  x_siz[1][1] = x_siz[1][0];  
    if(y_siz[0][2] != y_siz[0][3])  x_siz[2][1] = x_siz[2][0];
    for(int j=0 ; j<4 ; j++)  x_siz[j][1] = new_seq[j];
    
    ran_seq(); 
    for(int j=0 ; j<4 ; j++)  x_siz[j][2] = new_seq[j];  
    ran_seq();  
    for(int j=0 ; j<4 ; j++)  x_siz[j][3] = new_seq[j];
  
    for(int i=0 ; i<4 ; i++){
      for(int j=0 ; j<4 ; j++){
        R_s[j][i] = new PVector(x_siz[j][i]*scale, y_siz[j][i]*scale);
        //R_s[j][i] = new PVector(proportion[j]*scale, proportion[i]*scale);
        R_p[j][i] = new PVector(0, 0);
      }
    }
    
    for(int i=0 ; i<4 ; i++){
      for(int j=0 ; j<4 ; j++){
        R_p[j][i].add(originX, originY);
        if(j==1)  R_p[j][i].add(R_s[0][i].x, 0);
        if(j==2)  R_p[j][i].add(R_s[0][i].x+R_s[1][i].x, 0);
        if(j==3)  R_p[j][i].add(R_s[0][i].x+R_s[1][i].x+R_s[2][i].x, 0);
        
        if(i==1)  R_p[j][i].add(0, R_s[j][0].y);
        if(i==2)  R_p[j][i].add(0, R_s[j][0].y+R_s[j][1].y);
        if(i==3)  R_p[j][i].add(0, R_s[j][0].y+R_s[j][1].y+R_s[j][2].y);
      }
    }
    
    check();
  }
  
  void ran_seq(){
    //randomSeed(0);
    a = proportion[floor(random(0,4))];          //chose a
    for(int i=0 ; i<1000 ; i++){                 //chose b
      if(b==0 || b==a){
        b = proportion[floor(random(0,4))];
        if(b!=a)  break ;
      }
    }
    for(int i=0 ; i<1000 ; i++){                 //chose c
      if(c==0 || c==a || c==b){
        c = proportion[floor(random(0,4))];
        if(c!=a && c!=b)  break ;
      }
    }
    for(int i=0 ; i<1000 ; i++){                 //chose d
      if(d==0 || d==a || d==b || d==c){
        d = proportion[floor(random(0,4))];
        if(d!=a && d!=b && d!=c)  break ;
      }
    }
    new_seq[0] = a ;
    new_seq[1] = b ;
    new_seq[2] = c ;
    new_seq[3] = d ;
  }
  
  void check(){
    area_t = 0 ;
    for(int i=0 ; i<4 ; i++){
      for(int j=0 ; j<4 ; j++){
        area[j][i] = R_s[j][i].x * R_s[j][i].y ;
        area_t += area[j][i] ;
      }
    }
    
    int[][] j_ul = new int[16][16];  int J_UL = 1 ;
    int[][] j_bl = new int[16][16];  int J_BL = 1 ;
    int[][] j_ur = new int[16][16];  int J_UR = 1 ;
    int[][] j_br = new int[16][16];  int J_BR = 1 ;
    
    for(int i=0 ; i<16 ; i++){
      for(int j=0 ; j<16 ; j++){
        j_ul[j][i] = 1 ;
        j_bl[j][i] = 1 ;
        j_ur[j][i] = 1 ;
        j_br[j][i] = 1 ;
      }
    }
    
    for(int i=0 ; i<4 ; i++){
      for(int j=0 ; j<4 ; j++){
        
        for(int k=0 ; k<4 ; k++){                   //check up_left corner
          for(int l=0 ; l<4 ; l++){
            boolean cX_0 = false ;  
            boolean cX_1 = false ;
            boolean cY_0 = false ;
            boolean cY_1 = false ;
            if(R_p[j][i].x > R_p[l][k].x)              cX_0 = true ;
            if(R_p[j][i].x < R_p[l][k].x+R_s[l][k].x)  cX_1 = true ;
            if(R_p[j][i].y > R_p[l][k].y)              cY_0 = true ;
            if(R_p[j][i].y < R_p[l][k].y+R_s[l][k].y)  cY_1 = true ;
            
            if(cX_0==true && cX_1==true && cY_0==true && cY_1==true){
              j_ul[i*4+j][k*4+l] = 0 ; 
            }else{
              j_ul[i*4+j][k*4+l] = 1 ; 
            }
          }
        }
        for(int k=0 ; k<4 ; k++){                    //check buttom_left corner
          for(int l=0 ; l<4 ; l++){
            boolean cX_0 = false ;  
            boolean cX_1 = false ;
            boolean cY_0 = false ;
            boolean cY_1 = false ;
            if(R_p[j][i].x > R_p[l][k].x)                          cX_0 = true ;
            if(R_p[j][i].x < R_p[l][k].x+R_s[l][k].x)              cX_1 = true ;
            if(R_p[j][i].y+R_s[j][i].y > R_p[l][k].y)              cY_0 = true ;
            if(R_p[j][i].y+R_s[j][i].y < R_p[l][k].y+R_s[l][k].y)  cY_1 = true ;
            
            if(cX_0==true && cX_1==true && cY_0==true && cY_1==true){
              j_bl[i*4+j][k*4+l] = 0 ; 
            }else{
              j_bl[i*4+j][k*4+l] = 1 ; 
            }
          }
        }
        for(int k=0 ; k<4 ; k++){                   //check up_right corner
          for(int l=0 ; l<4 ; l++){
            boolean cX_0 = false ;  
            boolean cX_1 = false ;
            boolean cY_0 = false ;
            boolean cY_1 = false ;
            if(R_p[j][i].x+R_s[j][i].x > R_p[l][k].x)              cX_0 = true ;
            if(R_p[j][i].x+R_s[j][i].x < R_p[l][k].x+R_s[l][k].x)  cX_1 = true ;
            if(R_p[j][i].y > R_p[l][k].y)                          cY_0 = true ;
            if(R_p[j][i].y < R_p[l][k].y+R_s[l][k].y)              cY_1 = true ;
            
            if(cX_0==true && cX_1==true && cY_0==true && cY_1==true){
              j_ur[i*4+j][k*4+l] = 0 ; 
            }else{
              j_ur[i*4+j][k*4+l] = 1 ; 
            }
          }
        }
        for(int k=0 ; k<4 ; k++){                    //check buttom_right corner
          for(int l=0 ; l<4 ; l++){
            boolean cX_0 = false ;  
            boolean cX_1 = false ;
            boolean cY_0 = false ;
            boolean cY_1 = false ;
            if(R_p[j][i].x+R_s[j][i].x > R_p[l][k].x)              cX_0 = true ;
            if(R_p[j][i].x+R_s[j][i].x < R_p[l][k].x+R_s[l][k].x)  cX_1 = true ;
            if(R_p[j][i].y+R_s[j][i].y > R_p[l][k].y)              cY_0 = true ;
            if(R_p[j][i].y+R_s[j][i].y < R_p[l][k].y+R_s[l][k].y)  cY_1 = true ;
            
            if(cX_0==true && cX_1==true && cY_0==true && cY_1==true){
              j_bl[i*4+j][k*4+l] = 0 ; 
            }else{
              j_bl[i*4+j][k*4+l] = 1 ; 
            }
          }
        }
        
      }
    }
    
    for(int i=0 ; i<16 ; i++){
      for(int j=0 ; j<16 ; j++){
        J_UL *= j_ul[j][i] ;
        J_BL *= j_bl[j][i] ;
        J_UR *= j_ur[j][i] ;
        J_BR *= j_br[j][i] ;
      }
    }
    
    if(J_UL==1 && J_BL==1 && J_UR==1 && J_BR==1){
      success = true ;
    }else{
      success = false ; 
    }
  }
  
  void judg_order(){
    float A = proportion[0]*scale ;
    float B = proportion[1]*scale ;
    float C = proportion[2]*scale ;
    float D = proportion[3]*scale ;
    
    for(int i=0 ; i<4 ; i++){
      for(int j=0 ; j<4 ; j++){      
        if(R_s[j][i].x==A && R_s[j][i].y==A)  judg_seq[i*4+j] = 0 ;
        if(R_s[j][i].x==B && R_s[j][i].y==A)  judg_seq[i*4+j] = 1 ;
        if(R_s[j][i].x==C && R_s[j][i].y==A)  judg_seq[i*4+j] = 2 ;
        if(R_s[j][i].x==D && R_s[j][i].y==A)  judg_seq[i*4+j] = 3 ;
        
        if(R_s[j][i].x==A && R_s[j][i].y==B)  judg_seq[i*4+j] = 4 ; 
        if(R_s[j][i].x==B && R_s[j][i].y==B)  judg_seq[i*4+j] = 5 ;
        if(R_s[j][i].x==C && R_s[j][i].y==B)  judg_seq[i*4+j] = 6 ;
        if(R_s[j][i].x==D && R_s[j][i].y==B)  judg_seq[i*4+j] = 7 ;
        
        if(R_s[j][i].x==A && R_s[j][i].y==C)  judg_seq[i*4+j] = 8 ;
        if(R_s[j][i].x==B && R_s[j][i].y==C)  judg_seq[i*4+j] = 9 ;
        if(R_s[j][i].x==C && R_s[j][i].y==C)  judg_seq[i*4+j] = 10 ;
        if(R_s[j][i].x==D && R_s[j][i].y==C)  judg_seq[i*4+j] = 11 ;
        
        if(R_s[j][i].x==A && R_s[j][i].y==D)  judg_seq[i*4+j] = 12 ;
        if(R_s[j][i].x==B && R_s[j][i].y==D)  judg_seq[i*4+j] = 13 ;
        if(R_s[j][i].x==C && R_s[j][i].y==D)  judg_seq[i*4+j] = 14 ;
        if(R_s[j][i].x==D && R_s[j][i].y==D)  judg_seq[i*4+j] = 15 ;
      }
    }
  }
  
  void display(){
    for(int i=0 ; i<4 ; i++){
      for(int j=0 ; j<4 ; j++){
        //noFill();
        fill(20,50);
        stroke(0);
        strokeWeight(2);
        rect(R_p[j][i].x, R_p[j][i].y, R_s[j][i].x, R_s[j][i].y);
        noStroke();
      }
    }
    
    noFill();
    strokeWeight(4);
    //rect(originX, originY, frame_size, frame_size);
  }
  
  void find_a_pattern(){
    String space = str(' ') ;
    String[]num = new String[16];
    String f_seq = str(' ');
    boolean repeat = false ;
    for(int i=0 ; i<100 ; i++){
      rect_pos_def();
      if(area_f==area_t && success==true)  break ;
    }
    judg_order();
    for(int i=0 ; i<16 ; i++){
      num[i] = str(judg_seq[i]);
      f_seq += num[i] ;
      f_seq += space ;
    }
    
    for(int i=0 ; i<database.size() ; i++){
      if(f_seq == database.get(i)){
        repeat = true ;
        break ;
      }
    }
    
    if(repeat==false)  database.append(f_seq);
  }
}
