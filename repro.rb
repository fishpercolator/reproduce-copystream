#!/usr/bin/env ruby

require 'action_dispatch'

include ActionDispatch::TestProcess

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
test 'fixture_file_upload, local' do
  fixture_file_upload('./example.png')
end
test 'fixture_file_upload, mounted' do
  fixture_file_upload('/mnt/example.png')
end
