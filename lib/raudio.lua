print("RAYLIB RAUDIO INIT: STARTED")
local safe_mode = true
local ffi = require("ffi")
local os = ffi.os
local rl
if (os == "Windows") then
  rl = ffi.load("lib\\raylib-5.5_win64_mingw-w64\\lib\\raylib.dll")
elseif (os == "Linux") then
  rl = ffi.load("lib/raylib-5.5_linux_amd64/lib/libraylib.so")
else
  rl = nil
end
ffi.cdef("\nvoid InitAudioDevice(void);                                     // Initialize audio device and context\n\nvoid CloseAudioDevice(void);                                    // Close the audio device and context\n\nbool IsAudioDeviceReady(void);                                  // Check if audio device has been initialized successfully\n\nvoid SetMasterVolume(float volume);                             // Set master volume (listener)\n\nfloat GetMasterVolume(void);                                    // Get master volume (listener)\n\nWave LoadWave(const char *fileName);                            // Load wave data from file\n\nWave LoadWaveFromMemory(const char *fileType, const unsigned char *fileData, int dataSize); // Load wave from memory buffer, fileType refers to extension: i.e. '.wav'\n\nbool IsWaveValid(Wave wave);                                    // Checks if wave data is valid (data loaded and parameters)\n\nSound LoadSound(const char *fileName);                          // Load sound from file\n\nSound LoadSoundFromWave(Wave wave);                             // Load sound from wave data\n\nSound LoadSoundAlias(Sound source);                             // Create a new sound that shares the same sample data as the source sound, does not own the sound data\n\nbool IsSoundValid(Sound sound);                                 // Checks if a sound is valid (data loaded and buffers initialized)\n\nvoid UpdateSound(Sound sound, const void *data, int sampleCount); // Update sound buffer with new data\n\nvoid UnloadWave(Wave wave);                                     // Unload wave data\n\nvoid UnloadSound(Sound sound);                                  // Unload sound\n\nvoid UnloadSoundAlias(Sound alias);                             // Unload a sound alias (does not deallocate sample data)\n\nbool ExportWave(Wave wave, const char *fileName);               // Export wave data to file, returns true on success\n\nbool ExportWaveAsCode(Wave wave, const char *fileName);         // Export wave sample data to code (.h), returns true on success\n\nvoid PlaySound(Sound sound);                                    // Play a sound\n\nvoid StopSound(Sound sound);                                    // Stop playing a sound\n\nvoid PauseSound(Sound sound);                                   // Pause a sound\n\nvoid ResumeSound(Sound sound);                                  // Resume a paused sound\n\nbool IsSoundPlaying(Sound sound);                               // Check if a sound is currently playing\n\nvoid SetSoundVolume(Sound sound, float volume);                 // Set volume for a sound (1.0 is max level)\n\nvoid SetSoundPitch(Sound sound, float pitch);                   // Set pitch for a sound (1.0 is base level)\n\nvoid SetSoundPan(Sound sound, float pan);                       // Set pan for a sound (0.5 is center)\n\nWave WaveCopy(Wave wave);                                       // Copy a wave to a new wave\n\nvoid WaveCrop(Wave *wave, int initFrame, int finalFrame);       // Crop a wave to defined frames range\n\nvoid WaveFormat(Wave *wave, int sampleRate, int sampleSize, int channels); // Convert wave data to desired format\n\nfloat *LoadWaveSamples(Wave wave);                              // Load samples data from wave as a 32bit float data array\n\nvoid UnloadWaveSamples(float *samples);                         // Unload samples data loaded with LoadWaveSamples()\n\nMusic LoadMusicStream(const char *fileName);                    // Load music stream from file\n\nMusic LoadMusicStreamFromMemory(const char *fileType, const unsigned char *data, int dataSize); // Load music stream from data\n\nbool IsMusicValid(Music music);                                 // Checks if a music stream is valid (context and buffers initialized)\n\nvoid UnloadMusicStream(Music music);                            // Unload music stream\n\nvoid PlayMusicStream(Music music);                              // Start music playing\n\nbool IsMusicStreamPlaying(Music music);                         // Check if music is playing\n\nvoid UpdateMusicStream(Music music);                            // Updates buffers for music streaming\n\nvoid StopMusicStream(Music music);                              // Stop music playing\n\nvoid PauseMusicStream(Music music);                             // Pause music playing\n\nvoid ResumeMusicStream(Music music);                            // Resume playing paused music\n\nvoid SeekMusicStream(Music music, float position);              // Seek music to a position (in seconds)\n\nvoid SetMusicVolume(Music music, float volume);                 // Set volume for music (1.0 is max level)\n\nvoid SetMusicPitch(Music music, float pitch);                   // Set pitch for a music (1.0 is base level)\n\nvoid SetMusicPan(Music music, float pan);                       // Set pan for a music (0.5 is center)\n\nfloat GetMusicTimeLength(Music music);                          // Get music time length (in seconds)\n\nfloat GetMusicTimePlayed(Music music);                          // Get current music time played (in seconds)\n\nAudioStream LoadAudioStream(unsigned int sampleRate, unsigned int sampleSize, unsigned int channels); // Load audio stream (to stream raw audio pcm data)\n\nbool IsAudioStreamValid(AudioStream stream);                    // Checks if an audio stream is valid (buffers initialized)\n\nvoid UnloadAudioStream(AudioStream stream);                     // Unload audio stream and free memory\n\nvoid UpdateAudioStream(AudioStream stream, const void *data, int frameCount); // Update audio stream buffers with data\n\nbool IsAudioStreamProcessed(AudioStream stream);                // Check if any audio stream buffers requires refill\n\nvoid PlayAudioStream(AudioStream stream);                       // Play audio stream\n\nvoid PauseAudioStream(AudioStream stream);                      // Pause audio stream\n\nvoid ResumeAudioStream(AudioStream stream);                     // Resume audio stream\n\nbool IsAudioStreamPlaying(AudioStream stream);                  // Check if audio stream is playing\n\nvoid StopAudioStream(AudioStream stream);                       // Stop audio stream\n\nvoid SetAudioStreamVolume(AudioStream stream, float volume);    // Set volume for audio stream (1.0 is max level)\n\nvoid SetAudioStreamPitch(AudioStream stream, float pitch);      // Set pitch for audio stream (1.0 is base level)\n\nvoid SetAudioStreamPan(AudioStream stream, float pan);          // Set pan for audio stream (0.5 is centered)\n\nvoid SetAudioStreamBufferSizeDefault(int size);                 // Default size for new audio streams\ntypedef void (*AudioCallback)(void *bufferData, unsigned int frames);\n\nvoid SetAudioStreamCallback(AudioStream stream, AudioCallback callback); // Audio thread callback to request new data\n\nvoid AttachAudioStreamProcessor(AudioStream stream, AudioCallback processor); // Attach audio stream processor to stream, receives the samples as 'float'\n\nvoid DetachAudioStreamProcessor(AudioStream stream, AudioCallback processor); // Detach audio stream processor from stream\n\nvoid AttachAudioMixedProcessor(AudioCallback processor); // Attach audio stream processor to the entire audio pipeline, receives the samples as 'float'\n\nvoid DetachAudioMixedProcessor(AudioCallback processor); // Detach audio stream processor from the entire audio pipeline\n\n")
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
