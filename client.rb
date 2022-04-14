#!/usr/bin/ruby

require "socket"
require "thread"
require "openssl"
require 'net/http'

host = 'localhost'
port = Integer(2000)

socket = TCPSocket.new(host, port)


sslContext = OpenSSL::SSL::SSLContext.new
sslContext.cert = OpenSSL::X509::Certificate.new(File.open("cert.pem"))
ssl = OpenSSL::SSL::SSLSocket.new(socket, sslContext)
ssl.sync_close = true
ssl.connect


#puts ssl.peer_cert   # this is nil

ssl.puts "GET / HTTP/1.1\r\n"
ssl.puts "\r\n"

while line = ssl.gets
  puts line.chop
end

ssl.close
