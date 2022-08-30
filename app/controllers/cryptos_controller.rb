class CryptosController < ApplicationController
  before_action :set_crypto, only: %i[ destroy ]
  def create
    @crypto = Crypto.new(crypto_params)
    @crypto.fill_attrs
     respond_to do |format|
        # debugger
       if @crypto.save
         format.html { redirect_to root_path, notice: "greimer vino successfully created." }
         format.json { render :index, status: :created, location: @crypto }
       else
         format.html { render :index, status: :unprocessable_entity }
       end
     end
  end


  def index
    @crypto = Crypto.new
    @cryptos = Crypto.all
  end

  def destroy
    @crypto.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: " was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  
  private

  def crypto_params
    params.require(:crypto).permit(:id, :data, :prev_block, :block_index, :time, :bits)
  end

  def set_crypto
    @crypto = Crypto.find(params[:id])
  end

end
