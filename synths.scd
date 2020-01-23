//==================================================================
//
//                        Iván Paz
//                      Roger Pibernat
//                  on-the-fly programming
//                       25-01-2020
//                        TRUPPER_6
//
//==================================================================

s.boot

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

LoopBuf.ar(