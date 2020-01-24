//==================================================================
//
//                             Iván Paz
//                           Roger Pibernat
//Live coding: on-the-fly writing as a performative and explorative technique
//                             25-01-2020
//                             TRUPPER_6
//
//==================================================================

//SynthDef is one of the structures in SC that allow us to define a sound synthesis

// the basic structure is
(

SynthDef(\name,{ /* sound definition */ }).add

)


//    a sound definition has tree main parts
0. definitions arguments and variables
1. UGen
2. Env
3. Out


//   this is a simple sound definition

(
SynthDef(\myFirstSynth,{

	//variables var defines the variables in the synth
	var signal, envelop;

	//UGens signal is assigned with a Sinusoidal Oscillator of 440Hz
	signal = SinOsc.ar(440);

	// envelop is assigned with a percusive envelop
	envelop = EnvGen.ar(Env.perc(0.01,1));

	// the Out has array of buses and sent objects
	Out.ar([0,1],signal*envelop);
}).add
)
Synth(\myFirstSynth)




//   arguments can be changed

(
SynthDef(\myFirstSynth,{
	//NOTE ASSIGNATION OF freq AND amp
	arg freq= 220, amp=0.5;

	var signal, envelop;

	signal = SinOsc.ar(freq, 0, amp);

	envelop = EnvGen.ar(Env.perc(0.01,1));

	Out.ar([0,1],signal*envelop);
}).add
)

Synth(\myFirstSynth).set(\freq, 880, \amp, 0.5)


//      W  R  I  T  I  N  G    S  Y  N  T  H  S  ---------------------


(
SynthDef(\x,{
	arg freq = 2, amp = 1;
	var sig, env;
	sig = Impulse.ar(freq,0,amp)!2;
	env = EnvGen.ar(Env.perc(0,4),doneAction:2);
	Out.ar(0, sig * env)
}).add
)
Synth(\x)

(
SynthDef(\x,{
	arg freq = 60, amp = 0.1;
	var sig, env;
	sig = SinOsc.ar(freq)*LFNoise0.ar(10)!2;
	sig = sig * amp;
	env = EnvGen.ar(Env.perc(0.1,0.6),doneAction:2);
	Out.ar(0,sig);
}).add;
)
Synth(\x)
//====================================================
(
SynthDef(\x1,{
	arg freq = 2, amp = 0.9;
	var sig, env;
	sig = Impulse.ar(freq,0,amp)!2;
	sig = FreeVerb.ar(sig,SinOsc.kr(10),SinOsc.kr(3),SinOsc.kr(4));
	sig = sig * 3;
	env = EnvGen.ar(Env.perc(0,2),doneAction:2);
	Out.ar(0,sig * env)
}).add
)
Synth(\x1)
//====================================================
// Using buffers
//read the buffer and store it in a global variable

//Example 1
~buff = Buffer.read(s,"/home/ivan/documents/toplap/talleres2020/tupper_6/on-the-fly-writing/ta.wav");
//Example 2
~buff = Buffer.read(s,"/home/ivan/documents/toplap/talleres2020/tupper_6/on-the-fly-writing/KickAkd11.wav");

~buff.play
~buff.numChannels
~buff.query

(
SynthDef(\x2,{
	var sig, env;
	sig = PlayBuf.ar(~buff.numChannels,~buff.bufnum,1)!2;
	sig = sig * 1;
	env = EnvGen.ar(Env.perc(0,2),doneAction:2);
	Out.ar(0,sig * env)
}).add;
)
Synth(\x2)


s.quit
	