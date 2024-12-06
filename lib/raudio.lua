print("RAYLIB RAUDIO INIT: STARTED")
local safe_mode = true
local dll = require("lib.dll")
local ffi = dll.ffi
local rl = dll.rl
ffi.cdef("\13\nvoid InitAudioDevice(void);                                     // Initialize audio device and context\13\n\13\nvoid CloseAudioDevice(void);                                    // Close the audio device and context\13\n\13\nbool IsAudioDeviceReady(void);                                  // Check if audio device has been initialized successfully\13\n\13\nvoid SetMasterVolume(float volume);                             // Set master volume (listener)\13\n\13\nfloat GetMasterVolume(void);                                    // Get master volume (listener)\13\n\13\nWave LoadWave(const char *fileName);                            // Load wave data from file\13\n\13\nWave LoadWaveFromMemory(const char *fileType, const unsigned char *fileData, int dataSize); // Load wave from memory buffer, fileType refers to extension: i.e. '.wav'\13\n\13\nbool IsWaveValid(Wave wave);                                    // Checks if wave data is valid (data loaded and parameters)\13\n\13\nSound LoadSound(const char *fileName);                          // Load sound from file\13\n\13\nSound LoadSoundFromWave(Wave wave);                             // Load sound from wave data\13\n\13\nSound LoadSoundAlias(Sound source);                             // Create a new sound that shares the same sample data as the source sound, does not own the sound data\13\n\13\nbool IsSoundValid(Sound sound);                                 // Checks if a sound is valid (data loaded and buffers initialized)\13\n\13\nvoid UpdateSound(Sound sound, const void *data, int sampleCount); // Update sound buffer with new data\13\n\13\nvoid UnloadWave(Wave wave);                                     // Unload wave data\13\n\13\nvoid UnloadSound(Sound sound);                                  // Unload sound\13\n\13\nvoid UnloadSoundAlias(Sound alias);                             // Unload a sound alias (does not deallocate sample data)\13\n\13\nbool ExportWave(Wave wave, const char *fileName);               // Export wave data to file, returns true on success\13\n\13\nbool ExportWaveAsCode(Wave wave, const char *fileName);         // Export wave sample data to code (.h), returns true on success\13\n\13\nvoid PlaySound(Sound sound);                                    // Play a sound\13\n\13\nvoid StopSound(Sound sound);                                    // Stop playing a sound\13\n\13\nvoid PauseSound(Sound sound);                                   // Pause a sound\13\n\13\nvoid ResumeSound(Sound sound);                                  // Resume a paused sound\13\n\13\nbool IsSoundPlaying(Sound sound);                               // Check if a sound is currently playing\13\n\13\nvoid SetSoundVolume(Sound sound, float volume);                 // Set volume for a sound (1.0 is max level)\13\n\13\nvoid SetSoundPitch(Sound sound, float pitch);                   // Set pitch for a sound (1.0 is base level)\13\n\13\nvoid SetSoundPan(Sound sound, float pan);                       // Set pan for a sound (0.5 is center)\13\n\13\nWave WaveCopy(Wave wave);                                       // Copy a wave to a new wave\13\n\13\nvoid WaveCrop(Wave *wave, int initFrame, int finalFrame);       // Crop a wave to defined frames range\13\n\13\nvoid WaveFormat(Wave *wave, int sampleRate, int sampleSize, int channels); // Convert wave data to desired format\13\n\13\nfloat *LoadWaveSamples(Wave wave);                              // Load samples data from wave as a 32bit float data array\13\n\13\nvoid UnloadWaveSamples(float *samples);                         // Unload samples data loaded with LoadWaveSamples()\13\n\13\nMusic LoadMusicStream(const char *fileName);                    // Load music stream from file\13\n\13\nMusic LoadMusicStreamFromMemory(const char *fileType, const unsigned char *data, int dataSize); // Load music stream from data\13\n\13\nbool IsMusicValid(Music music);                                 // Checks if a music stream is valid (context and buffers initialized)\13\n\13\nvoid UnloadMusicStream(Music music);                            // Unload music stream\13\n\13\nvoid PlayMusicStream(Music music);                              // Start music playing\13\n\13\nbool IsMusicStreamPlaying(Music music);                         // Check if music is playing\13\n\13\nvoid UpdateMusicStream(Music music);                            // Updates buffers for music streaming\13\n\13\nvoid StopMusicStream(Music music);                              // Stop music playing\13\n\13\nvoid PauseMusicStream(Music music);                             // Pause music playing\13\n\13\nvoid ResumeMusicStream(Music music);                            // Resume playing paused music\13\n\13\nvoid SeekMusicStream(Music music, float position);              // Seek music to a position (in seconds)\13\n\13\nvoid SetMusicVolume(Music music, float volume);                 // Set volume for music (1.0 is max level)\13\n\13\nvoid SetMusicPitch(Music music, float pitch);                   // Set pitch for a music (1.0 is base level)\13\n\13\nvoid SetMusicPan(Music music, float pan);                       // Set pan for a music (0.5 is center)\13\n\13\nfloat GetMusicTimeLength(Music music);                          // Get music time length (in seconds)\13\n\13\nfloat GetMusicTimePlayed(Music music);                          // Get current music time played (in seconds)\13\n\13\nAudioStream LoadAudioStream(unsigned int sampleRate, unsigned int sampleSize, unsigned int channels); // Load audio stream (to stream raw audio pcm data)\13\n\13\nbool IsAudioStreamValid(AudioStream stream);                    // Checks if an audio stream is valid (buffers initialized)\13\n\13\nvoid UnloadAudioStream(AudioStream stream);                     // Unload audio stream and free memory\13\n\13\nvoid UpdateAudioStream(AudioStream stream, const void *data, int frameCount); // Update audio stream buffers with data\13\n\13\nbool IsAudioStreamProcessed(AudioStream stream);                // Check if any audio stream buffers requires refill\13\n\13\nvoid PlayAudioStream(AudioStream stream);                       // Play audio stream\13\n\13\nvoid PauseAudioStream(AudioStream stream);                      // Pause audio stream\13\n\13\nvoid ResumeAudioStream(AudioStream stream);                     // Resume audio stream\13\n\13\nbool IsAudioStreamPlaying(AudioStream stream);                  // Check if audio stream is playing\13\n\13\nvoid StopAudioStream(AudioStream stream);                       // Stop audio stream\13\n\13\nvoid SetAudioStreamVolume(AudioStream stream, float volume);    // Set volume for audio stream (1.0 is max level)\13\n\13\nvoid SetAudioStreamPitch(AudioStream stream, float pitch);      // Set pitch for audio stream (1.0 is base level)\13\n\13\nvoid SetAudioStreamPan(AudioStream stream, float pan);          // Set pan for audio stream (0.5 is centered)\13\n\13\nvoid SetAudioStreamBufferSizeDefault(int size);                 // Default size for new audio streams\13\ntypedef void (*AudioCallback)(void *bufferData, unsigned int frames);\13\n\13\nvoid SetAudioStreamCallback(AudioStream stream, AudioCallback callback); // Audio thread callback to request new data\13\n\13\nvoid AttachAudioStreamProcessor(AudioStream stream, AudioCallback processor); // Attach audio stream processor to stream, receives the samples as 'float'\13\n\13\nvoid DetachAudioStreamProcessor(AudioStream stream, AudioCallback processor); // Detach audio stream processor from stream\13\n\13\nvoid AttachAudioMixedProcessor(AudioCallback processor); // Attach audio stream processor to the entire audio pipeline, receives the samples as 'float'\13\n\13\nvoid DetachAudioMixedProcessor(AudioCallback processor); // Detach audio stream processor from the entire audio pipeline\13\n\13\n")
local function init_audio_device()
  return rl.InitAudioDevice()
end
local function close_audio_device()
  return rl.CloseAudioDevice()
end
local function is_audio_device_ready()
  return rl.IsAudioDeviceReady()
end
local function set_master_volume(volume)
  return rl.SetMasterVolume(volume)
end
local function get_master_volume()
  return rl.GetMasterVolume()
end
local function load_wave(file_name)
  return rl.LoadWave(file_name)
end
local function load_wave_from_memory(file_type, file_data, data_size)
  return rl.LoadWaveFromMemory(file_type, file_data, data_size)
end
local function is_wave_valid(wave)
  return rl.IsWaveValid(wave)
end
local function load_sound(file_name)
  return rl.LoadSound(file_name)
end
local function load_sound_from_wave(wave)
  return rl.LoadSoundFromWave(wave)
end
local function load_sound_alias(source)
  return rl.LoadSoundAlias(source)
end
local function is_sound_valid(sound)
  return rl.IsSoundValid(sound)
end
local function update_sound(sound, data, sample_count)
  return rl.UpdateSound(sound, data, sample_count)
end
local function unload_wave(wave)
  return rl.UnloadWave(wave)
end
local function unload_sound(sound)
  return rl.UnloadSound(sound)
end
local function unload_sound_alias(alias)
  return rl.UnloadSoundAlias(alias)
end
local function export_wave(wave, file_name)
  return rl.ExportWave(wave, file_name)
end
local function export_wave_as_code(wave, file_name)
  return rl.ExportWaveAsCode(wave, file_name)
end
local function play_sound(sound)
  return rl.PlaySound(sound)
end
local function stop_sound(sound)
  return rl.StopSound(sound)
end
local function pause_sound(sound)
  return rl.PauseSound(sound)
end
local function resume_sound(sound)
  return rl.ResumeSound(sound)
end
local function is_sound_playing(sound)
  return rl.IsSoundPlaying(sound)
end
local function set_sound_volume(sound, volume)
  return rl.SetSoundVolume(sound, volume)
end
local function set_sound_pitch(sound, pitch)
  return rl.SetSoundPitch(sound, pitch)
end
local function set_sound_pan(sound, pan)
  return rl.SetSoundPan(sound, pan)
end
local function wave_copy(wave)
  return rl.WaveCopy(wave)
end
local function wave_crop(wave, init_frame, final_frame)
  return rl.WaveCrop(wave, init_frame, final_frame)
end
local function wave_format(wave, sample_rate, sample_size, channels)
  return rl.WaveFormat(wave, sample_rate, sample_size, channels)
end
local function load_wave_samples(wave)
  return rl.LoadWaveSamples(wave)
end
local function unload_wave_samples(samples)
  return rl.UnloadWaveSamples(samples)
end
local function load_music_stream(file_name)
  return rl.LoadMusicStream(file_name)
end
local function load_music_stream_from_memory(file_type, data, data_size)
  return rl.LoadMusicStreamFromMemory(file_type, data, data_size)
end
local function is_music_valid(music)
  return rl.IsMusicValid(music)
end
local function unload_music_stream(music)
  return rl.UnloadMusicStream(music)
end
local function play_music_stream(music)
  return rl.PlayMusicStream(music)
end
local function is_music_stream_playing(music)
  return rl.IsMusicStreamPlaying(music)
end
local function update_music_stream(music)
  return rl.UpdateMusicStream(music)
end
local function stop_music_stream(music)
  return rl.StopMusicStream(music)
end
local function pause_music_stream(music)
  return rl.PauseMusicStream(music)
end
local function resume_music_stream(music)
  return rl.ResumeMusicStream(music)
end
local function seek_music_stream(music, position)
  return rl.SeekMusicStream(music, position)
end
local function set_music_volume(music, volume)
  return rl.SetMusicVolume(music, volume)
end
local function set_music_pitch(music, pitch)
  return rl.SetMusicPitch(music, pitch)
end
local function set_music_pan(music, pan)
  return rl.SetMusicPan(music, pan)
end
local function get_music_time_length(music)
  return rl.GetMusicTimeLength(music)
end
local function get_music_time_played(music)
  return rl.GetMusicTimePlayed(music)
end
local function load_audio_stream(sample_rate, sample_size, channels)
  return rl.LoadAudioStream(sample_rate, sample_size, channels)
end
local function is_audio_stream_valid(stream)
  return rl.IsAudioStreamValid(stream)
end
local function unload_audio_stream(stream)
  return rl.UnloadAudioStream(stream)
end
local function update_audio_stream(stream, data, frame_count)
  return rl.UpdateAudioStream(stream, data, frame_count)
end
local function is_audio_stream_processed(stream)
  return rl.IsAudioStreamProcessed(stream)
end
local function play_audio_stream(stream)
  return rl.PlayAudioStream(stream)
end
local function pause_audio_stream(stream)
  return rl.PauseAudioStream(stream)
end
local function resume_audio_stream(stream)
  return rl.ResumeAudioStream(stream)
end
local function is_audio_stream_playing(stream)
  return rl.IsAudioStreamPlaying(stream)
end
local function stop_audio_stream(stream)
  return rl.StopAudioStream(stream)
end
local function set_audio_stream_volume(stream, volume)
  return rl.SetAudioStreamVolume(stream, volume)
end
local function set_audio_stream_pitch(stream, pitch)
  return rl.SetAudioStreamPitch(stream, pitch)
end
local function set_audio_stream_pan(stream, pan)
  return rl.SetAudioStreamPan(stream, pan)
end
local function set_audio_stream_buffer_size_default(size)
  return rl.SetAudioStreamBufferSizeDefault(size)
end
local function set_audio_stream_callback(stream, callback)
  return rl.SetAudioStreamCallback(stream, callback)
end
local function attach_audio_stream_processor(stream, processor)
  return rl.AttachAudioStreamProcessor(stream, processor)
end
local function detach_audio_stream_processor(stream, processor)
  return rl.DetachAudioStreamProcessor(stream, processor)
end
local function attach_audio_mixed_processor(processor)
  return rl.AttachAudioMixedProcessor(processor)
end
local function detach_audio_mixed_processor(processor)
  return rl.DetachAudioMixedProcessor(processor)
end
return {["init-audio-device"] = init_audio_device, ["close-audio-device"] = close_audio_device, ["is-audio-device-ready"] = is_audio_device_ready, ["set-master-volume"] = set_master_volume, ["get-master-volume"] = get_master_volume, ["load-wave"] = load_wave, ["load-wave-from-memory"] = load_wave_from_memory, ["is-wave-valid"] = is_wave_valid, ["load-sound"] = load_sound, ["load-sound-from-wave"] = load_sound_from_wave, ["load-sound-alias"] = load_sound_alias, ["is-sound-valid"] = is_sound_valid, ["update-sound"] = update_sound, ["unload-wave"] = unload_wave, ["unload-sound"] = unload_sound, ["unload-sound-alias"] = unload_sound_alias, ["export-wave"] = export_wave, ["export-wave-as-code"] = export_wave_as_code, ["play-sound"] = play_sound, ["stop-sound"] = stop_sound, ["pause-sound"] = pause_sound, ["resume-sound"] = resume_sound, ["is-sound-playing"] = is_sound_playing, ["set-sound-volume"] = set_sound_volume, ["set-sound-pitch"] = set_sound_pitch, ["set-sound-pan"] = set_sound_pan, ["wave-copy"] = wave_copy, ["wave-crop"] = wave_crop, ["wave-format"] = wave_format, ["load-wave-samples"] = load_wave_samples, ["unload-wave-samples"] = unload_wave_samples, ["load-music-stream"] = load_music_stream, ["load-music-stream-from-memory"] = load_music_stream_from_memory, ["is-music-valid"] = is_music_valid, ["unload-music-stream"] = unload_music_stream, ["play-music-stream"] = play_music_stream, ["is-music-stream-playing"] = is_music_stream_playing, ["update-music-stream"] = update_music_stream, ["stop-music-stream"] = stop_music_stream, ["pause-music-stream"] = pause_music_stream, ["resume-music-stream"] = resume_music_stream, ["seek-music-stream"] = seek_music_stream, ["set-music-volume"] = set_music_volume, ["set-music-pitch"] = set_music_pitch, ["set-music-pan"] = set_music_pan, ["get-music-time-length"] = get_music_time_length, ["get-music-time-played"] = get_music_time_played, ["load-audio-stream"] = load_audio_stream, ["is-audio-stream-valid"] = is_audio_stream_valid, ["unload-audio-stream"] = unload_audio_stream, ["update-audio-stream"] = update_audio_stream, ["is-audio-stream-processed"] = is_audio_stream_processed, ["play-audio-stream"] = play_audio_stream, ["pause-audio-stream"] = pause_audio_stream, ["resume-audio-stream"] = resume_audio_stream, ["is-audio-stream-playing"] = is_audio_stream_playing, ["stop-audio-stream"] = stop_audio_stream, ["set-audio-stream-volume"] = set_audio_stream_volume, ["set-audio-stream-pitch"] = set_audio_stream_pitch, ["set-audio-stream-pan"] = set_audio_stream_pan, ["set-audio-stream-buffer-size-default"] = set_audio_stream_buffer_size_default, ["set-audio-stream-callback"] = set_audio_stream_callback, ["attach-audio-stream-processor"] = attach_audio_stream_processor, ["detach-audio-stream-processor"] = detach_audio_stream_processor, ["attach-audio-mixed-processor"] = attach_audio_mixed_processor, ["detach-audio-mixed-processor"] = detach_audio_mixed_processor}
