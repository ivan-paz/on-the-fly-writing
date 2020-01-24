//==================================================================
//
//                             Iván Paz
//                           Roger Pibernat
//Live coding: on-the-fly writing as a performative and explorative technique
//                             25-01-2020
//                             TRUPPER_6
//
//==================================================================

(
SynthDef(\x,{
	arg freq = 2, amp = 1;
	var sig, env;
	sig = Impulse.ar(freq,0,amp)!2;
	env = EnvGen.ar(Env.perc(0,1),doneAction:2);
	Out.ar(0, sig * env)
}).add
)
(Tdef(\px,{
	inf.do{
		Synth(\x);
		[1,0.01,1,0.01].choose.wait
}}).stop)

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
(Tdef(\px1,{
	inf.do{
		Synth(\x1);
		[1,0.1,1,0.01].choose.wait
}}).stop)
//====================================================
s.boot
~buff = Buffer.read(s,"/home/ivan/documents/toplap/talleres2020/tupper_6/on-the-fly-writing/ta.wav");
~buff.play
~buff.numChannels
~buff.query

(
SynthDef(\x2,{
	var sig, env;
	sig = PlayBuf.ar(~buff.numChannels,~buff.bufnum)!2;
	sig = sig * 1;
	env = EnvGen.ar(Env.perc(0,2),doneAction:2);
	Out.ar(0,sig * env)
}).add;
)
Synth(\x2)


s.quita
	