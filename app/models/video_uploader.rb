require "streamio-ffmpeg"

class VideoUploader < Shrine
  plugin :processing
  plugin :versions

  plugin :determine_mime_type
  plugin :cached_attachment_data
  plugin :remove_attachment
  plugin :add_metadata

  add_metadata do |io|
    video = FFMPEG::Movie.new(io.path)
    { "duration" => video.duration}
  end

  metadata_method :duration

  Attacher.validate do
    validate_max_size 200.megabyte, message: "is too large (max is 1 MB)"
    validate_mime_type_inclusion ['video/mp4']
  end
end