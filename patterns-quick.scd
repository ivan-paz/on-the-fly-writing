// Resources
// - https://ccrma.stanford.edu/~ruviaro/texts/A_Gentle_Introduction_To_SuperCollider.pdf
s.boot.meter;
s.scope;

// A synth to play.
(
SynthDef(\tupper, {
	var out = \out.kr(0);
	var freq = \freq.kr(440);
	var amp = \amp.kr(-12.dbamp);
	var pan = \pan.kr(0);
	var atk = \atk.kr(0.01);
	var dec = \dec.kr(0.3);
	var sus = \sus.kr(0.5);
	var rel = \rel.kr(1);
	var gate = \gate.kr(1);
	var feedback = \feedback.kr(0.5);
	var env = EnvGen.kr(Env.adsr(atk, dec, sus, rel), gate, doneAction:2);
	var sig = SinOsc.ar(freq * SinOscFB.ar(freq * 2, feedback, mul:0.78 * env));
	// sig = sig + GVerb.ar(sig, 10, 3, 0.5, damping: 0.98, mul: 0.2);
	sig = sig + FreeVerb.ar(sig);
	Out.ar(out, Pan2.ar(sig * env * amp));
}).add;
)

// A famous musician to play the synth.
Pdef(\jarrett);

// Sync.
// Starts playing on the next beat.
Pdef(\jarrett).play(quant:1);

// Give the musician the score sheet for the synth, A.K.A.: Pbind
Pdef(\jarrett, Pbind(\instrument, \tupper));

// Change the score sheet for another one with a melody.
// This is like saying:
// Please, Mr. Jarrett, play this piece with the Tupper Synth.
// The score being: Play a major triad arpeggio forever.
(
Pdef(\jarrett, Pbind(\instrument, \tupper,
	\degree, Pseq([0,2,4],inf),
));
)

// Repeat parts.
(
Pdef(\jarrett, Pbind(\instrument, \tupper,
	\degree, Pseq([
		Pseq([0,2,4], 3),
		Pshuf([-1,-2,-3], 1),
	], inf)
));
)

// Chords.
(
Pdef(\jarrett, Pbind(\instrument, \tupper,
	\degree, [0,2,4],
));
)

// Chord progression
(
Pdef(\jarrett, Pbind(\instrument, \tupper,
	\degree, Pseq([
		[0,2,4],
		[1,3,5],
		[4,-1,1],
	], inf),
));
)

// Chord progression variant
(
Pdef(\jarrett, Pbind(\instrument, \tupper,
	\degree, [0,2,4] + Pseq([0,1,-3], inf),
));
)

// Rhythm
(
Pdef(\jarrett, Pbind(\instrument, \tupper,
	\dur, Pseq([0.25, 0.5, 1],inf),
));
)

// Melody and Rhythm
(
Pdef(\jarrett, Pbind(\instrument, \tupper,
	\dur, Pseq([0.25, 0.5, 1],inf),
	\degree, Pseq([0,2,4],inf),
));
)

// Change scale and octave
(
Pdef(\jarrett, Pbind(\instrument, \tupper,
	\scale, Scale.harmonicMinor,
	\octave, Pseq([3,4,5,6],inf),
));
)

// Polyphony - Ptuple() is for arrays of patterns
(
Pdef(\jarrett, Pbind(\instrument, \tupper,
	\octave, [3,6],
	\dur, Pseq([0.25, 0.5, 1],inf),
	\degree, Ptuple([
		Pseq([0,2,4],inf),
		Prand([0,2,4],inf),
	]),
));
)

// Custom arguments
(
Pdef(\jarrett, Pbind(\instrument, \tupper,
	\feedback, Pwhite(0.0, 4.0).trace,
	\atk, Pseq([0.01, 0.1, 0.3], inf),
	\sus, Prand([0.1, 0.9, 0.5], inf).trace,
));
)

// All of the above and more.
(
Pdef(\jarrett, Pbind(\instrument, \tupper,
	\feedback, Ptuple([
		Pwhite(0.0, 2.0),
		Pwhite(0.0, 2.0),
	]),
	\sus, 0.1,
	\scale, Scale.harmonicMinor,
	\octave, Prand([4,5,6],inf),
	// \dur, Pseq([0.25, 0.25, 0.25, 0.25, 0.5, 0.5, 1], inf),
	\dur, 1/4,
	\degree, Ptuple([
		Pn(Pshuf([0,2,4,6],12)),
		[0,2,4] + Prand([0,2,4,-3],inf),
	]),
	\legato, Pkey(\dur) * 0.5,
	\amp, Ptuple([
		Pbjorklund(3,5),
		Pbjorklund(7,8),
	]) * Pwhite(0.05, 0.1),
));
)
// Add another hand
(
Pdef(\keith, Pbind(\instrument, \tupper,
	\scale, Scale.harmonicMinor,
	\octave, 3,
	\degree, Pwhite(0,7),
	\atk, 0.3,
	\rel, 2,
	\legato, 2,
	\feedback, Pwhite(0.0,2.0),
)).play(quant:1);
)

// jam
(
Pdef(\keith).stop;
Pdef(\jarrett).play;
)
(
Pdef(\keith).play;
Pdef(\jarrett).stop;
)
(
Pdef(\keith).play;
Pdef(\jarrett).play;
)