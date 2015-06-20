Pod::Spec.new do |s|
  name = "vorbis"
  libname = "lib" + name
  ver = "1.3.5"
  libver = libname + "-" + ver
  source = "http://downloads.xiph.org/releases/" + name + "/" + libver + ".tar.xz"
  sha1 = "7b4cdd4a73fadfed457ae40984cb0cc91146b300"

  s.name         = "Vorbis"
  s.version      = ver
  s.summary      = "libvorbis audio codec library"

  s.description  = <<-DESC
                   Xiph's Vorbis audio codec library, packaged for iOS.
                   Needed for decoding or encoding of audio in Ogg and WebM media.
                   DESC

  s.homepage     = "https://xiph.org/" + name + "/"

  s.license      = { :type => "BSD", :file => "COPYING" }

  s.author             = { "Brion Vibber (packager)" => "brion@pobox.com" }
  s.social_media_url   = "https://planet.xiph.org/"

  s.platform     = :ios, "6.0"

  s.source       = { :http => source,
                     :sha1 => sha1 }

  # hack for use of #include "foo/bar" in subdirs relative to base dir
  s.prepare_command = <<-CMD
                      test -e lib/modes/modes || cp -pr ../modes lib/modes/modes
                      test -e lib/modes/books || ln -pr ../books lib/modes/books
                      CMD

  s.compiler_flags = "-O3",
                     "-Wno-conversion",
                     "-Wno-unused-variable",
                     "-Wno-unused-function"

  s.source_files = "lib",
                   "include/**/*.h"
  s.exclude_files = "lib/psytune.c", # dead code that doesn't compile
                    "lib/tone.c", # test prog?
                    "lib/barkmel.c" # test prog?
  s.public_header_files = "include/**/*.h"
  s.header_dir = name
  
  s.dependency 'Ogg', '>=1.0'
end