
MusicRNN_IO

HTML controls for Magenta.js MusicRNN (Symbolic Music LSTM Model)

Input: note-duration lists, chords, temp, duration, density

Output: note and duration lists


@magenta/music - v1.23.1
All

Inherited

    Globals "music_rnn/model" MusicRNN 

Class MusicRNN

Main MusicRNN model class.

A MusicRNN is an LSTM-based language model for musical notes.
Hierarchy

    MusicRNN

Index
Constructors

    constructor

Methods

    continueSequence
    continueSequenceAndReturnProbabilities
    dispose
    initialize
    isInitialized

Constructors
constructor

    new MusicRNN(checkpointURL: string, spec?: MusicRNNSpec): MusicRNN

        Defined in src/music_rnn/model.ts:83

    MusicRNN constructor.
    Parameters
        checkpointURL: string

        Path to the checkpoint directory.
        Optional spec: MusicRNNSpec

        (Optional) MusicRNNSpec object. If undefined, will be loaded from a config.json file in the checkpoint directory.
    Returns MusicRNN

Methods
continueSequence

    continueSequence(sequence: INoteSequence, steps: number, temperature?: number, chordProgression?: string[]): Promise<INoteSequence>

        Defined in src/music_rnn/model.ts:212

    Continues a provided quantized NoteSequence.
    Parameters
        sequence: INoteSequence

        The sequence to continue. Must be quantized.
        steps: number

        How many steps to continue.
        Optional temperature: number

        (Optional) The softmax temperature to use when sampling from the logits. Argmax is used if not provided. Temperature can be any number value above 0, however, anything above 1.5 will essentially result in random results.
        Optional chordProgression: string[]

        (Optional) Chord progression to use as conditioning. A chord progression param is an array of chords that are passed to the tonal package for parsing, so they're in that format. Example: ["G", "Em", "C", "D"]
    Returns Promise<INoteSequence>

continueSequenceAndReturnProbabilities

    continueSequenceAndReturnProbabilities(sequence: INoteSequence, steps: number, temperature?: number, chordProgression?: string[]): Promise<{ probs: Float32Array[]; sequence: Promise<INoteSequence> }>

        Defined in src/music_rnn/model.ts:231

    Continues a provided quantized NoteSequence, and returns the computed probability distribution at each step.
    Parameters
        sequence: INoteSequence

        The sequence to continue. Must be quantized.
        steps: number

        How many steps to continue.
        Optional temperature: number

        (Optional) The softmax temperature to use when sampling from the logits. Argmax is used if not provided.
        Optional chordProgression: string[]

        (Optional) Chord progression to use as conditioning.
    Returns Promise<{ probs: Float32Array[]; sequence: Promise<INoteSequence> }>

dispose

    dispose(): void

        Defined in src/music_rnn/model.ts:188
    Returns void

initialize

    initialize(): Promise<void>

        Defined in src/music_rnn/model.ts:127

    Loads variables from the checkpoint and instantiates the Encoder and Decoder.
    Returns Promise<void>

isInitialized

    isInitialized(): boolean

        Defined in src/music_rnn/model.ts:104

    Returns true iff model is initialized.
    Returns boolean

    Globals
    "music_rnn/model"

    MusicRNN
        constructor
        continueSequence
        continueSequenceAndReturnProbabilities
        dispose
        initialize
        isInitialized

    MusicRNNSpec

