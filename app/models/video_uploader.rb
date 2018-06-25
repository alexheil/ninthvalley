require "streamio-ffmpeg"

class VideoUploader < Shrine
  plugin :processing
  plugin :versions

  plugin :determine_mime_type
  plugin :cached_attachment_data
  plugin :remove_attachment
  plugin :add_metadata

  add_metadata do |io, context|
    video = Shrine.with_file(io) { |file| FFMPEG::Video.new(file.path) }
    { "duration"   => movie.duration }
  end

  metadata_method :duration
end