class Crypto < ApplicationRecord

    def fill_attrs
        
        self.prev_block = Crypto.last.present? ? Crypto.last.data : ""
        
        self.time = Time.now.to_i
        
        self.data = Digest::SHA1.hexdigest(self.time.to_s+self.block_index.to_s)
        
        self.bits = self.data.bytesize
    end
end
