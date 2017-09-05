//bring in HyperBpm
//instance of HyperBPM
//HyperBPM3 HyperBpm;
//initialize kick (Sample1)
SndBuf kick => dac;
0 => kick.gain;
0 => kick.pos;
//initialize snare (Sample2)
SndBuf snare => dac;
0 => snare.gain;
0 => snare.pos;
//initialize clap (Sample3)
SndBuf clap => dac;
0 => clap.gain;
0 => clap.pos;
//initialize hihat (Sample4)
SndBuf hihat => dac;
0 => hihat.gain;
0 => hihat.pos;
//initialize auxiliary percussion(Sample5)
SndBuf perc => dac;
0 => perc.gain;
perc.samples() => perc.pos;


//read in audio file
me.dir(-1) + "audio/kick_03.wav" => kick.read;
me.dir(-1) + "audio/snare_02.wav" => snare.read;
me.dir(-1) + "audio/clap_01.wav" => clap.read;
me.dir(-1) + "audio/hihat_02.wav" => hihat.read;
me.dir(-1) + "audio/cowbell_01.wav" => perc.read;







// Create OSC Input Object
OscIn oscin;
// Create OSC message
OscMsg msg;

// Set our port from myRemoteLocaiton from Processing
12000 => oscin.port; 
// Tell OSC to listen to all messages
oscin.listenAll();

// Create Variables for info input values
float bpm;
1 => int ring1;
2 => int ring2;
3 => int ring3;
4 => int ring4;
5 => int ring5;
//variables for gate messages
int rb1;
int rb2;
int rb3;
int rb4;
int rb5;

fun void oscPoller()
{
    while(true)
    {
        oscin => now;
        while(oscin.recv(msg) != 0)
        {
            if (msg.address == "/bpm")//Osc message 0 = bpm controls master clock
            {
                // extract data
                //info messages
                msg.getFloat(0) => bpm;
                msg.getInt(1) => ring1;
                msg.getInt(2) => ring2;
                msg.getInt(3) => ring3;
                msg.getInt(4) => ring4;
                msg.getInt(5) => ring5;
                //gate messages
                msg.getInt(6) => rb1;
                msg.getInt(7) => rb2;
                msg.getInt(8) => rb3;
                msg.getInt(9) => rb4;
                msg.getInt(10) => rb5;
                
                
            }
        }
        
    }   
}


// Spork the Poller
spork ~ oscPoller();



// MAIN PROGRAM 
while (true)
{
    <<<"bpm",bpm>>>;
    <<<"ring1",ring1>>>;
    <<<"ring2",ring2>>>;
    <<<"ring3",ring3>>>;
    <<<"ring4",ring4>>>;
    <<<"ring5",ring5>>>;
    <<<"RB1", rb1>>>;
    <<<"RB2", rb2>>>;
    <<<"RB3", rb3>>>;
    <<<"RB4", rb4>>>;
    <<<"RB5", rb5>>>;
    
  //  HyperBpm.tempo2tups("ringOne", bpm,ring1);//ring one
   // HyperBpm.tempo2tups("ringTwo",bpm,ring2);//ring 2
  // HyperBpm.tempo2tups("ringThree",bpm,ring3);//ring 3
  // HyperBpm.tempo2tups("ringFour",bpm,ring4);//ring 4
  // HyperBpm.tempo2tups("ringFive",bpm,ring5);//ring 5
   
   
   
   //ring one
   if(rb1 == 1){
       0 => kick.pos;
       2 => kick.gain;
       (kick.samples()*0.5)::samp => now;

   }
   //ring two
   if(rb2 == 1){
       0 => snare.pos;
       2 => snare.gain;
       (snare.samples()*0.5)::samp => now;

   }   

   //ring three
   if(rb3 == 1){
       0 => clap.pos;
       1 => clap.gain;
       (clap.samples()*0.5)::samp => now;

   }

   //ring four
   if(rb4  == 1){
       0 => hihat.pos;
       1 => hihat.gain;
       (hihat.samples()*0.5)::samp => now;
   }
   
  
   //ring five
     if(rb5 == 1){
       0 => perc.pos;
       1 => perc.gain;
       (perc.samples()*0.5)::samp => now;

   }

       
    //tupOne.masterNote => now;
    10::ms => now;
}




//10::ms => now;









