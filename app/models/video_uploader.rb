class VideoUploader < Shrine
  plugin :processing
  plugin :versions

  plugin :determine_mime_type
  plugin :cached_attachment_data
  plugin :remove_attachment
  plugin :add_metadata

  add_metadata do |io|
    video = FFMPEG::Video.new(io.path)
    { "duration" => video.duration}
  end

  metadata_method :duration
end