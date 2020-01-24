// Resources
// - https://ccrma.stanford.edu/~ruviaro/texts/A_Gentle_Introduction_To_SuperCollider.pdf
s.boot.meter;

// Meet the Pbind
Pbind().play;

// press [cmd/ctlr]+. to stop the sound.

// Pbind is like a score sheet.  We must give it to a player to hear something.
// That's what '.play' does.

// Use a more interesting synth.

// First define a synth.
// Make sure the output signal is enveloped with 'doneAction:2' so the synth
// frees itself when is done playing.  Otherwise synths will keep stacking up in
// the server until it collapses.
(
SynthDef(\patty, {
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
	sig = sig + GVerb.ar(sig, 10, 3, 0.5, mul: 0.2);
	Out.ar(out, Pan2.ar(sig * env * amp));
}).add;
)

// To use the synth, we must tell Pbind what instrument we want it to play,
// using the symbol of the SynthDef.
Pbind(\instrument, \patty).play;

// To change the frequency of our synth we can tell Pbind what frequency we want it to play.
Pbind(\instrument, \patty, \freq, 200).play;
Pbind(\instrument, \patty, \freq, 800).play;

// ------------------------------------------
// Melody

// Providing the \freq argument a pattern.
Pbind(\instrument, \patty, \freq, Pseq([200,400,800])).play;

// All pattern classes start with 'P'.
// 'Pseq' is a pattern that sequences an array of values.
// Other patterns are: Prand, Pwhite, Pshuf, and many many many more.
// These are List patters. There are patterns for all kinds of stuff, like math, logic,
// filtering values, playing patterns in parallel, ...
//
// Patterns usually take a list of values and the number of times they must be played.
// usual sytax: Pwhatever( list-of-values, number-of-repetitions )
// These may vary, but it's quite common, specially for List patterns.

// The example above only plays once because we didn't provide an argument for the number of
// repetitions and Pseq defaults to 1 repetition.
// To play it twice you just add a 2 as repetition argument
Pbind(\instrument, \patty, \freq, Pseq([200,400,800], 2)).play;
// Use 'inf' to play it forever.
Pbind(\instrument, \patty, \freq, Pseq([200,400,800], inf)).play;

// There are more human-friendly ways of providing notes.
// midi note values
Pbind(\instrument, \patty, \midinote, Pseq([60, 64, 67])).play;
// note (half-step) from the root
Pbind(\instrument, \patty, \note, Pseq([0, 4, 7, -1])).play;
// degrees of a scale
Pbind(\instrument, \patty, \degree, Pseq([0, 2, 4, -1])).play;

// ... if there are degrees, how do we provide the scale?
Pbind(\instrument, \patty, \scale, Scale.harmonicMinor, \degree, Pseq([0, 2, 4, -1])).play;
// To list all the available scales:
Scale.directory; // see the post

// ------------------------------------------
// Rhythm

// Pbind plays a synth on every beat by default.  To change that there's the \dur argument.
Pbind(\instrument, \patty).play;
Pbind(\instrument, \patty, \dur, 1).play;
Pbind(\instrument, \patty, \dur, 0.5).play;
// To create a rhythm we can use... a pattern!
Pbind(\instrument, \patty, \dur, Pseq([0.5, 1, 1, 0.25, 1.75], 2)).play;

// Combine rhythm and melody to get a musical phrase.
Pbind(\instrument, \patty, \dur, Pseq([0.5, 1, 1, 0.25, 1.75], inf), \degree, Pseq([0, 2, 4, -1], inf)).play;

// ------------------------------------------
// Arguments

// You can sequence ANY argument in any order.
// Pbind has quite a few default arguments. You may be interested in:
\instrument
\freq
\amp
\sustain
\scale
\degree
\note
\octave
\dur
\legato
// see Pbind documentation if you want more.

// Here's an example:
(
Pbind(\instrument, \patty,
	\dur, Prand([0.5, 1, 1, 0.25, 1.75], inf),
	\degree, Pseq([0, 2, 4, -1], inf),
	\legato, Pwhite(0.1),
	\octave, Prand([3,4,5,6,7], inf),
).play;
)

// What about custom arguments?
// Pbind can use any argument that your SynthDef declares.

// Does nothing because the default synth has no feedback argument
Pbind(\feedback, Pwhite(0.0, 4.0)).play; 
// But our SynthDef does have a feedback argument.
Pbind(\instrument, \patty, \feedback, Pwhite(0.0, 4.0)).play;

// ------------------------------------------
// Synching
Pbind(\instrument, \patty).play(quant:1);


// ------------------------------------------
// Modify without stopping the server

// Tell a famous musician to play our score, starting on the next beat.
Pdef(\jarret).play(quant:1);
// Giver the musician a score.
Pdef(\jarret, Pbind(\instrument, \patty, \octave, 4, \degree, Pwhite(0,7), \dur, Prand((1..4) * 0.25, inf)));
// Modify the score on-the-fly
Pdef(\jarret, Pbind(\instrument, \patty, \degree, Pseq([0,2,4],7), \dur, 0.25));
// jam
Pdef(\jarret).stop;
Pdef(\jarret).play;

 
// ------------------------------------------
// ... more
Ppar([]);
Pdefn();
~variables;