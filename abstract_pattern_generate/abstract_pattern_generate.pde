ArrayList<pattern> Patterns = new ArrayList<pattern>();
pattern p  = new pattern();

int proportion[] = {22, 48, 80, 100};       //{3, 6, 14, 20}
PVector[][] R_s = new PVector[4][4];        //size of rect
PVector[][] R_p = new PVector[4][4];      //position of rect
  
float scale = 0 ; 
float frame_size = 400 ;
float originX, originY ;
  
int x_siz[][] = new int[4][4];
int y_siz[][] = new int[4][4];
  
int a, b, c, d ;
int []new_seq = new int [4];
  
float area_f = 0 ;
float area_t = 0 ;
float[][] area = new float[4][4];
  
int[] judg_seq = new int[16];
  
boolean success = false ;

StringList database = new StringList();

void setup(){
  size(700,700);
  originX = (width-frame_size)/2 ;
  originY = (height-frame_size)/2 ;
  scale = frame_size/(proportion[0]+proportion[1]+proportion[2]+proportion[3]) ;
  a=0 ; b=0 ; c=0 ; d=0 ;
  area_f = frame_size*frame_size ; 

  p.find_a_pattern();     
  p.display();
}

void draw(){
  
}
