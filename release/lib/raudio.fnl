(print "RAYLIB RAUDIO INIT: STARTED")
(local safe-mode true)

(local dll (require :lib.dll))
(local ffi (. dll :ffi))
(local rl (. dll :rl))

(ffi.cdef "
void InitAudioDevice(void);                                     // Initialize audio device and context

void CloseAudioDevice(void);                                    // Close the audio device and context

bool IsAudioDeviceReady(void);                                  // Check if audio device has been initialized successfully

void SetMasterVolume(float volume);                             // Set master volume (listener)

float GetMasterVolume(void);                                    // Get master volume (listener)

Wave LoadWave(const char *fileName);                            // Load wave data from file

Wave LoadWaveFromMemory(const char *fileType, const unsigned char *fileData, int dataSize); // Load wave from memory buffer, fileType refers to extension: i.e. '.wav'

bool IsWaveValid(Wave wave);                                    // Checks if wave data is valid (data loaded and parameters)

Sound LoadSound(const char *fileName);                          // Load sound from file

Sound LoadSoundFromWave(Wave wave);                             // Load sound from wave data

Sound LoadSoundAlias(Sound source);                             // Create a new sound that shares the same sample data as the source sound, does not own the sound data

bool IsSoundValid(Sound sound);                                 // Checks if a sound is valid (data loaded and buffers initialized)

void UpdateSound(Sound sound, const void *data, int sampleCount); // Update sound buffer with new data

void UnloadWave(Wave wave);                                     // Unload wave data

void UnloadSound(Sound sound);                                  // Unload sound

void UnloadSoundAlias(Sound alias);                             // Unload a sound alias (does not deallocate sample data)

bool ExportWave(Wave wave, const char *fileName);               // Export wave data to file, returns true on success

bool ExportWaveAsCode(Wave wave, const char *fileName);         // Export wave sample data to code (.h), returns true on success

void PlaySound(Sound sound);                                    // Play a sound

void StopSound(Sound sound);                                    // Stop playing a sound

void PauseSound(Sound sound);                                   // Pause a sound

void ResumeSound(Sound sound);                                  // Resume a paused sound

bool IsSoundPlaying(Sound sound);                               // Check if a sound is currently playing

void SetSoundVolume(Sound sound, float volume);                 // Set volume for a sound (1.0 is max level)

void SetSoundPitch(Sound sound, float pitch);                   // Set pitch for a sound (1.0 is base level)

void SetSoundPan(Sound sound, float pan);                       // Set pan for a sound (0.5 is center)

Wave WaveCopy(Wave wave);                                       // Copy a wave to a new wave

void WaveCrop(Wave *wave, int initFrame, int finalFrame);       // Crop a wave to defined frames range

void WaveFormat(Wave *wave, int sampleRate, int sampleSize, int channels); // Convert wave data to desired format

float *LoadWaveSamples(Wave wave);                              // Load samples data from wave as a 32bit float data array

void UnloadWaveSamples(float *samples);                         // Unload samples data loaded with LoadWaveSamples()

Music LoadMusicStream(const char *fileName);                    // Load music stream from file

Music LoadMusicStreamFromMemory(const char *fileType, const unsigned char *data, int dataSize); // Load music stream from data

bool IsMusicValid(Music music);                                 // Checks if a music stream is valid (context and buffers initialized)

void UnloadMusicStream(Music music);                            // Unload music stream

void PlayMusicStream(Music music);                              // Start music playing

bool IsMusicStreamPlaying(Music music);                         // Check if music is playing

void UpdateMusicStream(Music music);                            // Updates buffers for music streaming

void StopMusicStream(Music music);                              // Stop music playing

void PauseMusicStream(Music music);                             // Pause music playing

void ResumeMusicStream(Music music);                            // Resume playing paused music

void SeekMusicStream(Music music, float position);              // Seek music to a position (in seconds)

void SetMusicVolume(Music music, float volume);                 // Set volume for music (1.0 is max level)

void SetMusicPitch(Music music, float pitch);                   // Set pitch for a music (1.0 is base level)

void SetMusicPan(Music music, float pan);                       // Set pan for a music (0.5 is center)

float GetMusicTimeLength(Music music);                          // Get music time length (in seconds)

float GetMusicTimePlayed(Music music);                          // Get current music time played (in seconds)

AudioStream LoadAudioStream(unsigned int sampleRate, unsigned int sampleSize, unsigned int channels); // Load audio stream (to stream raw audio pcm data)

bool IsAudioStreamValid(AudioStream stream);                    // Checks if an audio stream is valid (buffers initialized)

void UnloadAudioStream(AudioStream stream);                     // Unload audio stream and free memory

void UpdateAudioStream(AudioStream stream, const void *data, int frameCount); // Update audio stream buffers with data

bool IsAudioStreamProcessed(AudioStream stream);                // Check if any audio stream buffers requires refill

void PlayAudioStream(AudioStream stream);                       // Play audio stream

void PauseAudioStream(AudioStream stream);                      // Pause audio stream

void ResumeAudioStream(AudioStream stream);                     // Resume audio stream

bool IsAudioStreamPlaying(AudioStream stream);                  // Check if audio stream is playing

void StopAudioStream(AudioStream stream);                       // Stop audio stream

void SetAudioStreamVolume(AudioStream stream, float volume);    // Set volume for audio stream (1.0 is max level)

void SetAudioStreamPitch(AudioStream stream, float pitch);      // Set pitch for audio stream (1.0 is base level)

void SetAudioStreamPan(AudioStream stream, float pan);          // Set pan for audio stream (0.5 is centered)

void SetAudioStreamBufferSizeDefault(int size);                 // Default size for new audio streams
typedef void (*AudioCallback)(void *bufferData, unsigned int frames);

void SetAudioStreamCallback(AudioStream stream, AudioCallback callback); // Audio thread callback to request new data

void AttachAudioStreamProcessor(AudioStream stream, AudioCallback processor); // Attach audio stream processor to stream, receives the samples as 'float'

void DetachAudioStreamProcessor(AudioStream stream, AudioCallback processor); // Detach audio stream processor from stream

void AttachAudioMixedProcessor(AudioCallback processor); // Attach audio stream processor to the entire audio pipeline, receives the samples as 'float'

void DetachAudioMixedProcessor(AudioCallback processor); // Detach audio stream processor from the entire audio pipeline

")

;------------------------------------------------------------------------------------
; Audio Loading and Playing Functions (Module: audio)
;------------------------------------------------------------------------------------
; Audio device management functions
(fn init-audio-device []
	"Initialize audio device and context"
	(rl.InitAudioDevice ))

(fn close-audio-device []
	"Close the audio device and context"
	(rl.CloseAudioDevice ))

(fn is-audio-device-ready []
	"Check if audio device has been initialized successfully"
	(rl.IsAudioDeviceReady ))

(fn set-master-volume [volume]
	"Set master volume (listener)"
	(rl.SetMasterVolume volume))

(fn get-master-volume []
	"Get master volume (listener)"
	(rl.GetMasterVolume ))

; Wave/Sound loading/unloading functions
(fn load-wave [file-name]
	"Load wave data from file"
	(rl.LoadWave file-name))

(fn load-wave-from-memory [file-type file-data data-size]
	"Load wave from memory buffer, fileType refers to extension: i.e. '.wav'"
	(rl.LoadWaveFromMemory file-type file-data data-size))

(fn is-wave-valid [wave]
	"Checks if wave data is valid (data loaded and parameters)"
	(rl.IsWaveValid wave))

(fn load-sound [file-name]
	"Load sound from file"
	(rl.LoadSound file-name))

(fn load-sound-from-wave [wave]
	"Load sound from wave data"
	(rl.LoadSoundFromWave wave))

(fn load-sound-alias [source]
	"Create a new sound that shares the same sample data as the source sound, does not own the sound data"
	(rl.LoadSoundAlias source))

(fn is-sound-valid [sound]
	"Checks if a sound is valid (data loaded and buffers initialized)"
	(rl.IsSoundValid sound))

(fn update-sound [sound data sample-count]
	"Update sound buffer with new data"
	(rl.UpdateSound sound data sample-count))

(fn unload-wave [wave]
	"Unload wave data"
	(rl.UnloadWave wave))

(fn unload-sound [sound]
	"Unload sound"
	(rl.UnloadSound sound))

(fn unload-sound-alias [alias]
	"Unload a sound alias (does not deallocate sample data)"
	(rl.UnloadSoundAlias alias))

(fn export-wave [wave file-name]
	"Export wave data to file, returns true on success"
	(rl.ExportWave wave file-name))

(fn export-wave-as-code [wave file-name]
	"Export wave sample data to code (.h), returns true on success"
	(rl.ExportWaveAsCode wave file-name))

; Wave/Sound management functions
(fn play-sound [sound]
	"Play a sound"
	(rl.PlaySound sound))

(fn stop-sound [sound]
	"Stop playing a sound"
	(rl.StopSound sound))

(fn pause-sound [sound]
	"Pause a sound"
	(rl.PauseSound sound))

(fn resume-sound [sound]
	"Resume a paused sound"
	(rl.ResumeSound sound))

(fn is-sound-playing [sound]
	"Check if a sound is currently playing"
	(rl.IsSoundPlaying sound))

(fn set-sound-volume [sound volume]
	"Set volume for a sound (1.0 is max level)"
	(rl.SetSoundVolume sound volume))

(fn set-sound-pitch [sound pitch]
	"Set pitch for a sound (1.0 is base level)"
	(rl.SetSoundPitch sound pitch))

(fn set-sound-pan [sound pan]
	"Set pan for a sound (0.5 is center)"
	(rl.SetSoundPan sound pan))

(fn wave-copy [wave]
	"Copy a wave to a new wave"
	(rl.WaveCopy wave))

(fn wave-crop [wave init-frame final-frame]
	"Crop a wave to defined frames range"
	(rl.WaveCrop wave init-frame final-frame))

(fn wave-format [wave sample-rate sample-size channels]
	"Convert wave data to desired format"
	(rl.WaveFormat wave sample-rate sample-size channels))

(fn load-wave-samples [wave]
	"Load samples data from wave as a 32bit float data array"
	(rl.LoadWaveSamples wave))

(fn unload-wave-samples [samples]
	"Unload samples data loaded with LoadWaveSamples()"
	(rl.UnloadWaveSamples samples))

; Music management functions
(fn load-music-stream [file-name]
	"Load music stream from file"
	(rl.LoadMusicStream file-name))

(fn load-music-stream-from-memory [file-type data data-size]
	"Load music stream from data"
	(rl.LoadMusicStreamFromMemory file-type data data-size))

(fn is-music-valid [music]
	"Checks if a music stream is valid (context and buffers initialized)"
	(rl.IsMusicValid music))

(fn unload-music-stream [music]
	"Unload music stream"
	(rl.UnloadMusicStream music))

(fn play-music-stream [music]
	"Start music playing"
	(rl.PlayMusicStream music))

(fn is-music-stream-playing [music]
	"Check if music is playing"
	(rl.IsMusicStreamPlaying music))

(fn update-music-stream [music]
	"Updates buffers for music streaming"
	(rl.UpdateMusicStream music))

(fn stop-music-stream [music]
	"Stop music playing"
	(rl.StopMusicStream music))

(fn pause-music-stream [music]
	"Pause music playing"
	(rl.PauseMusicStream music))

(fn resume-music-stream [music]
	"Resume playing paused music"
	(rl.ResumeMusicStream music))

(fn seek-music-stream [music position]
	"Seek music to a position (in seconds)"
	(rl.SeekMusicStream music position))

(fn set-music-volume [music volume]
	"Set volume for music (1.0 is max level)"
	(rl.SetMusicVolume music volume))

(fn set-music-pitch [music pitch]
	"Set pitch for a music (1.0 is base level)"
	(rl.SetMusicPitch music pitch))

(fn set-music-pan [music pan]
	"Set pan for a music (0.5 is center)"
	(rl.SetMusicPan music pan))

(fn get-music-time-length [music]
	"Get music time length (in seconds)"
	(rl.GetMusicTimeLength music))

(fn get-music-time-played [music]
	"Get current music time played (in seconds)"
	(rl.GetMusicTimePlayed music))

; AudioStream management functions
(fn load-audio-stream [sample-rate sample-size channels]
	"Load audio stream (to stream raw audio pcm data)"
	(rl.LoadAudioStream sample-rate sample-size channels))

(fn is-audio-stream-valid [stream]
	"Checks if an audio stream is valid (buffers initialized)"
	(rl.IsAudioStreamValid stream))

(fn unload-audio-stream [stream]
	"Unload audio stream and free memory"
	(rl.UnloadAudioStream stream))

(fn update-audio-stream [stream data frame-count]
	"Update audio stream buffers with data"
	(rl.UpdateAudioStream stream data frame-count))

(fn is-audio-stream-processed [stream]
	"Check if any audio stream buffers requires refill"
	(rl.IsAudioStreamProcessed stream))

(fn play-audio-stream [stream]
	"Play audio stream"
	(rl.PlayAudioStream stream))

(fn pause-audio-stream [stream]
	"Pause audio stream"
	(rl.PauseAudioStream stream))

(fn resume-audio-stream [stream]
	"Resume audio stream"
	(rl.ResumeAudioStream stream))

(fn is-audio-stream-playing [stream]
	"Check if audio stream is playing"
	(rl.IsAudioStreamPlaying stream))

(fn stop-audio-stream [stream]
	"Stop audio stream"
	(rl.StopAudioStream stream))

(fn set-audio-stream-volume [stream volume]
	"Set volume for audio stream (1.0 is max level)"
	(rl.SetAudioStreamVolume stream volume))

(fn set-audio-stream-pitch [stream pitch]
	"Set pitch for audio stream (1.0 is base level)"
	(rl.SetAudioStreamPitch stream pitch))

(fn set-audio-stream-pan [stream pan]
	"Set pan for audio stream (0.5 is centered)"
	(rl.SetAudioStreamPan stream pan))

(fn set-audio-stream-buffer-size-default [size]
	"Default size for new audio streams"
	(rl.SetAudioStreamBufferSizeDefault size))

(fn set-audio-stream-callback [stream callback]
	"Audio thread callback to request new data"
	(rl.SetAudioStreamCallback stream callback))

(fn attach-audio-stream-processor [stream processor]
	"Attach audio stream processor to stream, receives the samples as 'float'"
	(rl.AttachAudioStreamProcessor stream processor))

(fn detach-audio-stream-processor [stream processor]
	"Detach audio stream processor from stream"
	(rl.DetachAudioStreamProcessor stream processor))

(fn attach-audio-mixed-processor [processor]
	"Attach audio stream processor to the entire audio pipeline, receives the samples as 'float'"
	(rl.AttachAudioMixedProcessor processor))

(fn detach-audio-mixed-processor [processor]
	"Detach audio stream processor from the entire audio pipeline"
	(rl.DetachAudioMixedProcessor processor))

{: init-audio-device
 : close-audio-device
 : is-audio-device-ready
 : set-master-volume
 : get-master-volume
 : load-wave
 : load-wave-from-memory
 : is-wave-valid
 : load-sound
 : load-sound-from-wave
 : load-sound-alias
 : is-sound-valid
 : update-sound
 : unload-wave
 : unload-sound
 : unload-sound-alias
 : export-wave
 : export-wave-as-code
 : play-sound
 : stop-sound
 : pause-sound
 : resume-sound
 : is-sound-playing
 : set-sound-volume
 : set-sound-pitch
 : set-sound-pan
 : wave-copy
 : wave-crop
 : wave-format
 : load-wave-samples
 : unload-wave-samples
 : load-music-stream
 : load-music-stream-from-memory
 : is-music-valid
 : unload-music-stream
 : play-music-stream
 : is-music-stream-playing
 : update-music-stream
 : stop-music-stream
 : pause-music-stream
 : resume-music-stream
 : seek-music-stream
 : set-music-volume
 : set-music-pitch
 : set-music-pan
 : get-music-time-length
 : get-music-time-played
 : load-audio-stream
 : is-audio-stream-valid
 : unload-audio-stream
 : update-audio-stream
 : is-audio-stream-processed
 : play-audio-stream
 : pause-audio-stream
 : resume-audio-stream
 : is-audio-stream-playing
 : stop-audio-stream
 : set-audio-stream-volume
 : set-audio-stream-pitch
 : set-audio-stream-pan
 : set-audio-stream-buffer-size-default
 : set-audio-stream-callback
 : attach-audio-stream-processor
 : detach-audio-stream-processor
 : attach-audio-mixed-processor
 : detach-audio-mixed-processor}