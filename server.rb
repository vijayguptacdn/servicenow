require "socket"
require "openssl"
require "thread"

listeningPort = Integer(2000)

server = TCPServer.new('127.0.0.1', listeningPort)
sslContext = OpenSSL::SSL::SSLContext.new
sslContext.cert = OpenSSL::X509::Certificate.new(File.open("cert.pem"))
sslContext.key = OpenSSL::PKey::RSA.new(File.open("private.pem"))
sslServer = OpenSSL::SSL::SSLServer.new(server, sslContext)

puts "Listening on port #{listeningPort}"

while session = sslServer.accept
  request = session.gets
  puts request
 
  session.print "HTTP/1.1 200\r\n" # 1
  session.print "Content-Type: text/html\r\n" # 2
  session.print "\r\n" # 3
  session.print "Certificate Expiration Date:  #{sslContext.cert.not_after}"
 
  session.close
end


server = Server.new(listeningPort)
server.start
server.join