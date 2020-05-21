#!/usr/bin/env ruby

require 'tempfile'

FN = '/tmp/test.png'

def test(name, &block)
  file_write_test name, &block
  io_copy_stream_test name, &block
  puts
end
  
def file_write_test(name)
  io = yield
  File.write(FN, io.read)
  puts "#{name}, File.write: #{File.new(FN).size}"
end

def io_copy_stream_test(name)
  io = yield
  IO.copy_stream(io, FN)
  puts "#{name}, IO.copy_stream: #{File.new(FN).size}"
end

test 'File.open, local' do
  File.open('./example.png')
end
test 'File.open, mounted' do
  File.open('/mnt/example.png')
end

test 'Tempfile.new + copy_file preserve=false, mounted' do
  tf = Tempfile.new(['example', '.png'])
  tf.set_encoding(Encoding::BINARY)
  FileUtils.copy_file('/mnt/example.png', tf.path)
  tf
end

test 'Tempfile.new + copy_file preserve=true, mounted' do
  tf = Tempfile.new(['example', '.png'])
  tf.set_encoding(Encoding::BINARY)
  FileUtils.copy_file('/mnt/example.png', tf.path, true)
  tf
end
