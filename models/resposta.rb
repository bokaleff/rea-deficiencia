class Resposta
  # Esse include torna essa classe apta a
  # ser persistida no Mongo
  include Mongoid::Document

  # Campos do formulário
  field :ra
  field :dataInicio
  field :dataTermino
  field :caritativo
  field :medico  
  field :social
end