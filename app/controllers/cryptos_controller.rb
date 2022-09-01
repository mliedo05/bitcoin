class CryptosController < ApplicationController
  before_action :set_crypto, only: %i[ destroy ]
  

  def create
    @crypto = Crypto.new(crypto_params)
    @crypto.fill_attrs
    respond_to do |format|
      if @crypto.save
        @crypto.block_index = @crypto.id
        @crypto.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend(
              'crypto', 
               partial: 'cryptos/crypto',
               locals: {crypto: @crypto}
            ),
            turbo_stream.update('notice', "Hash #{@crypto.data} created")
          ]
        end
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end


  def index
    @crypto = Crypto.new
    @pagy, @cryptos = pagy(Crypto.all)
  end

  def destroy
    @crypto.destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(
            @crypto
          ),
          turbo_stream.update('notice', "Hash #{@crypto.data} deleted")
        ]
      end
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
