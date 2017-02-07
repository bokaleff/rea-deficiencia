require 'sinatra'
require 'ims/lti'
require 'haml'
require 'base64'
require 'mongoid'

require_relative 'models/resposta'
require 'json'









  # Bloco para configurações de ambiente e serviços
  # integrados ao app
  configure do
    # Define o ambiente atual como o de produção
    # (já que estamos implantando esse app diretamente
    # em produção...)
    set :environment, :production

    # Lê o arquivo mongoid.yml da pasta config/, 
    # o qual contem dados de conexão com o 
    # Mongo como nome da base, host e porta
    Mongoid.load!("./config/mongoid.yml")
  end
  

  get '/' do
    @ra = Base64.decode64(params[:r]) if params[:r]
    haml :index
  end

  # HTTP POST /cadastro-submit
  # (Quando o usuário clica no botão "Enviar" do Cadastro)
  post '/response' do
    begin
      Resposta.create!({
        :ra           => params['ra'],
        :dataInicio   => params['dataInicio'],
        :dataTermino  => params['dataTermino'],
        :caritativo   => params['caritativo'],
        :medico       => params['medico'],
        :social       => params['social']
      })
      #resposta.save!
    rescue => e     
      return { :status => :exception, :message =>  e.message }.to_json
    end

    return { :status => :ok }.to_json
   
   
    ## Vamos gravar os dados preenchidos no banco?
    #dados_do_response = Response.new({
    #  :medico => medico,
    #  :caritativo => caritativo,
    #  :social => social,
    #  :r => r    
    #})
    
    #
    ## res = result, response...
    ## Você pode definir o nome da variável com o retorno da
    ## operação no banco

    ## Escrevendo na tela o resultado
    #texto = "Você tentou adicionar os seguintes dados: <br>\
    #  Campo: #{medico}<br>Campo: #{caritativo}<br>Campo: #{social}<br>Ra: #{r}}<br><br><br>\
    #  O retorno do banco foi: #{res.inspect}"
  
    ## A função inspect inspeciona o que está dentro da variável...
    
    #return texto
    
  end

