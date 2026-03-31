@magenta/music - v1.23.1
All

Inherited

    Globals "music_vae/model" MusicVAE 

Class MusicVAE

Main MusicVAE model class.

A MusicVAE is a variational autoencoder made up of an Encoder and Decoder, along with a DataConverter for converting between Tensor and NoteSequence objects for input and output.

Exposes methods for interpolation and sampling of musical sequences.
Hierarchy

    MusicVAE

Index
Constructors

    constructor

Properties

    dataConverter
    initialized
    zDims

Methods

    decode
    decodeTensors
    dispose
    encode
    encodeTensors
    initialize
    interpolate
    interpolateTensors
    isInitialized
    sample
    sampleTensors
    similar
    similarTensors

Constructors
constructor

    new MusicVAE(checkpointURL: string, spec?: MusicVAESpec): MusicVAE

        Defined in src/music_vae/model.ts:784

    MusicVAE constructor.
    Parameters
        checkpointURL: string

        Path to the checkpoint directory.
        Optional spec: MusicVAESpec

        (Optional) MusicVAESpec object. If undefined, will be loaded from a config.json file in the checkpoint directory.
    Returns MusicVAE

Properties
dataConverter
dataConverter: DataConverter

    Defined in src/music_vae/model.ts:775

initialized
initialized: boolean = false

    Defined in src/music_vae/model.ts:784

zDims
zDims: number

    Defined in src/music_vae/model.ts:782

Methods
decode

    decode(z: tf.Tensor2D, temperature?: number, controlArgs?: MusicVAEControlArgs, stepsPerQuarter?: number, qpm?: number): Promise<INoteSequence[]>

        Defined in src/music_vae/model.ts:1391

    Decodes the input latent vectors into NoteSequences.
    Parameters
        z: tf.Tensor2D

        The latent vectors to decode, sized [batchSize, zSize].
        Optional temperature: number

        (Optional) The softmax temperature to use when sampling. The argmax is used if not provided.
        Optional controlArgs: MusicVAEControlArgs

        (Optional) MusicVAEControlArgs object to use as conditioning.
        Default value stepsPerQuarter: number = constants.DEFAULT_STEPS_PER_QUARTER

        The step resolution of the resulting NoteSequence.
        Default value qpm: number = constants.DEFAULT_QUARTERS_PER_MINUTE

        The tempo of the resulting NoteSequences.
    Returns Promise<INoteSequence[]>

    The decoded NoteSequences.

decodeTensors

    decodeTensors(z: tf.Tensor2D, temperature?: number, controlArgs?: MusicVAEControlArgs): Promise<Tensor<R3>>

        Defined in src/music_vae/model.ts:1361

    Decodes the input latent vectors into tensors.
    Parameters
        z: tf.Tensor2D

        The latent vectors to decode, sized [batchSize, zSize].
        Optional temperature: number

        (Optional) The softmax temperature to use when sampling. The argmax is used if not provided.
        Optional controlArgs: MusicVAEControlArgs

        (Optional) MusicVAEControlArgs object to use as conditioning.
    Returns Promise<Tensor<R3>>

    The decoded tensors.

dispose

    dispose(): void

        Defined in src/music_vae/model.ts:812

    Disposes of any untracked Tensors to avoid GPU memory leaks.
    Returns void

encode

    encode(inputSequences: INoteSequence[], controlArgs?: MusicVAEControlArgs): Promise<Tensor<R2>>

        Defined in src/music_vae/model.ts:1328

    Encodes the input NoteSequences into latent vectors.
    Parameters
        inputSequences: INoteSequence[]

        An array of NoteSequences to encode.
        Optional controlArgs: MusicVAEControlArgs

        (Optional) MusicVAEControlArgs object to use as conditioning.
    Returns Promise<Tensor<R2>>

    A Tensor containing the batch of latent vectors, sized [inputSequences.length, zSize].

encodeTensors

    encodeTensors(inputTensors: tf.Tensor3D, controlArgs: MusicVAEControlArgs): Promise<Tensor<R2>>

        Defined in src/music_vae/model.ts:1287

    Encodes the input Tensors into latent vectors.
    Parameters
        inputTensors: tf.Tensor3D

        A 3D Tensor of sequences to encode.
        controlArgs: MusicVAEControlArgs

        (Optional) MusicVAEControlArgs object to use as conditioning.
    Returns Promise<Tensor<R2>>

    A Tensor containing the batch of latent vectors, sized [inputTensors.shape[0], zSize].

initialize

    initialize(): Promise<void>

        Defined in src/music_vae/model.ts:842

    Loads variables from the checkpoint and instantiates the Encoder and Decoder.
    Returns Promise<void>

interpolate

    interpolate(inputSequences: INoteSequence[], numInterps: number | number[], temperature?: number, controlArgs?: MusicVAEControlArgs): Promise<INoteSequence[]>

        Defined in src/music_vae/model.ts:1182

    Interpolates between the input NoteSequences in latent space.

    If 2 sequences are given, a single linear interpolation is computed, with the first output sequence being a reconstruction of sequence A and the final output being a reconstruction of sequence B, with numInterps total sequences.

    If 4 sequences are given, bilinear interpolation is used. The results are returned in row-major order for a matrix with the following layout: | A . . C | | . . . . | | . . . . | | B . . D | where the letters represent the reconstructions of the four inputs, in alphabetical order, with the number of output columns and rows specified by numInterps.
    Parameters
        inputSequences: INoteSequence[]

        An array of 2 or 4 NoteSequences to interpolate between.
        numInterps: number | number[]

        The number of pairwise interpolation sequences to return, including the reconstructions. If 4 inputs are given, this can be either a single number specifying the side length of a square, or a [columnCount, rowCount] array to specify a rectangle.
        Optional temperature: number

        (Optional) The softmax temperature to use when sampling from the logits. Argmax is used if not provided.
        Optional controlArgs: MusicVAEControlArgs

        (Optional) MusicVAEControlArgs object to use as conditioning.
    Returns Promise<INoteSequence[]>

    An array of interpolation NoteSequence objects, as described above.

interpolateTensors

    interpolateTensors(inputTensors: tf.Tensor3D, numInterps: number | number[], temperature?: number, controlArgs?: MusicVAEControlArgs): Promise<Tensor<R3>>

        Defined in src/music_vae/model.ts:1135

    Interpolates between the input Tensors in latent space.

    If 2 sequences are given, a single linear interpolation is computed, with the first output sequence being a reconstruction of sequence A and the final output being a reconstruction of sequence B, with numInterps total sequences.

    If 4 sequences are given, bilinear interpolation is used. The results are returned in row-major order for a matrix with the following layout: | A . . C | | . . . . | | . . . . | | B . . D | where the letters represent the reconstructions of the four inputs, in alphabetical order, with the number of output columns and rows specified by numInterps.
    Parameters
        inputTensors: tf.Tensor3D

        A 3D Tensor containing 2 or 4 sequences to interpolate between.
        numInterps: number | number[]

        The number of pairwise interpolation sequences to return, including the reconstructions. If 4 inputs are given, this can be either a single number specifying the side length of a square, or a [columnCount, rowCount] array to specify a rectangle.
        Optional temperature: number

        (Optional) The softmax temperature to use when sampling from the logits. Argmax is used if not provided.
        Optional controlArgs: MusicVAEControlArgs

        (Optional) MusicVAEControlArgs object to use as conditioning.
    Returns Promise<Tensor<R3>>

    A 3D Tensor of interpolations.

isInitialized

    isInitialized(): boolean

        Defined in src/music_vae/model.ts:1009

    Returns true iff model is intialized.
    Returns boolean

sample

    sample(numSamples: number, temperature?: number, controlArgs?: MusicVAEControlArgs, stepsPerQuarter?: number, qpm?: number): Promise<INoteSequence[]>

        Defined in src/music_vae/model.ts:1512

    Samples sequences from the model prior.
    Parameters
        numSamples: number

        The number of samples to return.
        Default value temperature: number = 0.5

        The softmax temperature to use when sampling.
        Optional controlArgs: MusicVAEControlArgs

        (Optional) MusicVAEControlArgs object to use as conditioning.
        Default value stepsPerQuarter: number = constants.DEFAULT_STEPS_PER_QUARTER

        The step resolution of the resulting NoteSequences.
        Default value qpm: number = constants.DEFAULT_QUARTERS_PER_MINUTE

        The tempo of the resulting NoteSequences.
    Returns Promise<INoteSequence[]>

    An array of sampled NoteSequence objects.

sampleTensors

    sampleTensors(numSamples: number, temperature?: number, controlArgs?: MusicVAEControlArgs): Promise<Tensor<R3>>

        Defined in src/music_vae/model.ts:1483

    Samples tensors from the model prior.
    Parameters
        numSamples: number

        The number of samples to return.
        Default value temperature: number = 0.5

        The softmax temperature to use when sampling.
        Optional controlArgs: MusicVAEControlArgs

        (Optional) MusicVAEControlArgs object to use as conditioning.
    Returns Promise<Tensor<R3>>

    A Tensor3D of samples.

similar

    similar(inputSequence: INoteSequence, numSamples: number, similarity: number, temperature?: number, controlArgs?: MusicVAEControlArgs): Promise<INoteSequence[]>

        Defined in src/music_vae/model.ts:1592

    Generates similar NoteSequences to an input NoteSequence.

    This is done by sampling new Zs from a unit Gaussian and interpolating between the encoded input NoteSequence and the sampled Zs.
    Parameters
        inputSequence: INoteSequence

        The input NoteSequence.
        numSamples: number

        The number of samples to return.
        similarity: number

        The degree of similarity between the generated sequences and the input sequence. Must be between 0 and 1, where 1 is most similar and 0 is least similar.
        Optional temperature: number

        The softmax temperature to use when sampling.
        Optional controlArgs: MusicVAEControlArgs

        (Optional) MusicVAEControlArgs object to use as conditioning.
    Returns Promise<INoteSequence[]>

    An array of generated NoteSequence objects.

similarTensors

    similarTensors(inputTensor: tf.Tensor2D, numSamples: number, similarity: number, temperature?: number, controlArgs?: MusicVAEControlArgs): Promise<Tensor<R3>>

        Defined in src/music_vae/model.ts:1551

    Generates similar tensors to an input tensor.

    This is done by sampling new Zs from a unit Gaussian and interpolating between the encoded input tensor and the sampled Zs.
    Parameters
        inputTensor: tf.Tensor2D

        The input tensor, a Tensor2D.
        numSamples: number

        The number of samples to return.
        similarity: number

        The degree of similarity between the generated tensors and the input tensor. Must be between 0 and 1, where 1 is most similar and 0 is least similar.
        Optional temperature: number

        The softmax temperature to use when sampling.
        Optional controlArgs: MusicVAEControlArgs

        (Optional) MusicVAEControlArgs object to use as conditioning.
    Returns Promise<Tensor<R3>>

    A Tensor3D of samples.

