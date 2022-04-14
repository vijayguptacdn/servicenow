require 'openssl'

class SelfSignedCertificate
  def initialize
    @key = OpenSSL::PKey::RSA.new(1024)
    public_key = @key.public_key

    subject = "/C=BE/O=localhost/OU=localhost/CN=localhost"

    @cert = OpenSSL::X509::Certificate.new
    @cert.subject = @cert.issuer = OpenSSL::X509::Name.parse(subject)
    @cert.not_before = Time.now
    @cert.not_after = Time.now + 365 * 24 * 60 * 60
    @cert.public_key = public_key
    @cert.serial = 0x0
    @cert.version = 2

    ef = OpenSSL::X509::ExtensionFactory.new
    ef.subject_certificate = @cert
    ef.issuer_certificate = @cert
    @cert.extensions = [
        ef.create_extension("basicConstraints","CA:TRUE", true),
        ef.create_extension("subjectKeyIdentifier", "hash"),
    # ef.create_extension("keyUsage", "cRLSign,keyCertSign", true),
    ]
    @cert.add_extension ef.create_extension("authorityKeyIdentifier",
                                           "keyid:always,issuer:always")

    @cert.sign @key, OpenSSL::Digest::SHA1.new
  end

  def self_signed_pem
    @cert.to_pem
  end

  def private_key
    @key
  end
end


my_cert = SelfSignedCertificate.new
puts "Private Key:\n#{my_cert.private_key}"
puts "Self-signed PEM:\n#{my_cert.self_signed_pem}"

File.write('cert.pem', my_cert.self_signed_pem)
File.write('private.pem', my_cert.private_key)