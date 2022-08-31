class CryptosController < ApplicationController
  before_action :set_crypto, only: %i[ destroy ]
  

  def create
    @crypto = Crypto.new(crypto_params)
    @crypto.fill_attrs
     respond_to do |format|
        # debugger
       if @crypto.save
        #  format.html { redirect_to root_path, notice: "greimer vino successfully created." }
        #  format.json { render :index, status: :created, location: @crypto }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend(
              'crypto', 
               partial: 'cryptos/crypto',
               locals: {crypto: @crypto}
            )
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
          )
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
