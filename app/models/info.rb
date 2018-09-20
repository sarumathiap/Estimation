require 'base64'
require 'digest'
require 'openssl'
class Info < ApplicationRecord
	
	before_save :password_encryption
	private
	def password_encryption
		rand_iv = (0...8).map { (65 + rand(26)).chr }.join
    	rand_key = (0...8).map { (65 + rand(26)).chr }.join
    	iv = Digest::SHA256.hexdigest(rand_iv)[0..15]
    	key = Digest::SHA256.hexdigest(rand_iv)[0..31]
    	self.username = Info.encrypt(username , iv, key)
    	self.password = Info.encrypt(password , iv, key)
    	self.iv = iv
    	self.key = key
	end

	private
	def self.encrypt(cleardata , iv , key)
      cipher = OpenSSL::Cipher.new('AES-256-CBC')
      cipher.encrypt  
      cipher.key = key 
      cipher.iv  = iv 

      encrypted = ''
      encrypted << cipher.update(cleardata)
      encrypted << cipher.final 
      Info.b64enc(encrypted)
    end
    
    private
    def self.b64enc(data)
      Base64.encode64(data).gsub(/\n/, '')
    end
end
