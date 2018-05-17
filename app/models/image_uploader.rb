require "image_processing/mini_magick"

class ImageUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :processing
  plugin :versions

  plugin :determine_mime_type
  plugin :cached_attachment_data
  plugin :remove_attachment

  process(:store) do |io|
    original = io.download
    processor = ImageProcessing::MiniMagick

    size_1920 = processor.source(original).resize_to_limit!(1920, 1920)
    size_600 = processor.source(size_1920).resize_to_limit!(600, 600)

    original.close!

    { original: io, large: size_1920, thumb: size_600 }
  end

  Attacher.validate do
    validate_max_size 1.megabyte, message: "is too large (max is 1 MB)"
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png']
  end

end