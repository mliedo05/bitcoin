class Crypto < ApplicationRecord

    def fill_attrs
        
        self.prev_block = Crypto.last.present? ? Crypto.last.data : ""
        
        self.block_index = rand(1..100)
        
        self.time = Time.at(rand * Time.now.to_i)
        
        self.data = self.data+self.prev_block+(self.block_index).to_s+(self.time).to_s
        
        self.bits = self.data.bytesize
    end
end
