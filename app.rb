SPACE = " "

#==============================================
# CLASSE DDD de Origem
#==============================================
class  Ddd < Object
  attr_accessor :numero, :precos
  
#---------------------------------------------
# Instancia com o número do DDD e a tabela
#     de preços (hash) zerada
  def initialize(numero)
    @numero = numero
    @precos = {}
  end
  
#---------------------------------------------
# Adiciona o par "Destino/Preço por minuto" à
#     tabela hash
  def add_price(destino, preco)
    preco_final = {}
    @precos[destino] = preco
  end

#---------------------------------------------
# Calcula o valor da ligação por minuto sem plano
  def calcular_valor_ligacao(tempo_usado, destino)
    if @precos[destino] != nil 
      valor = tempo_usado * @precos[destino]
      valor.round(3).to_s
    else
      "-"
    end
  end
end
#==============================================



#==============================================
# CLASSE Pacote
#==============================================
class Pacote < Object
  attr_accessor :nome, :tempo

#---------------------------------------------
# Instancia objeto com nome do pacote e
#     tempo (franquia)
  def initialize(nome, tempo)
    @nome = nome
    @tempo = tempo
  end

#---------------------------------------------
# Calcula valor da ligação usando o plano
  def calcular_valor_ligacao(tempo_usado, preco_p_min)
    tempo_sobra = tempo_usado - @tempo
    
    if tempo_sobra <= 0
      return 0
    else
      return (tempo_sobra * (preco_p_min * 1.1))
    end
  end
end
#==============================================



#==============================================
# CLASSE Ligação
#==============================================
class Ligacao
  attr_accessor :origem, :destino, :tempo, :plano

#---------------------------------------------
# Instancia objeto com
#      a Origem da ligação (classe Ddd),
#      o Destino (classe Ddd),
#      a duração da ligação (tempo),
#      e o Plano (classe Pacote)
  def initialize(origem, destino, tempo, plano)
    @origem = origem
    @destino = destino
    @tempo = tempo
    @plano = plano
  end

#---------------------------------------------
# Calcula valor COM o plano
  def calcular_valor_com_plano
    if @origem.precos[@destino] != nil
      valor = @plano.calcular_valor_ligacao(@tempo, @origem.precos[@destino])
      valor.round(2).to_s
    else
      "-"
    end
  end

#---------------------------------------------
# Calcula valor SEM o plano
  def calcular_valor_sem_plano
    @origem.calcular_valor_ligacao(@tempo, @destino)
  end
end
#==============================================




#==============================================
#  TESTES
#==============================================

# Instância dos pacotes
pacote30 = Pacote.new("FaleMais 30", 30)
pacote60 = Pacote.new("FaleMais 60", 60)
pacote120 = Pacote.new("FaleMais 120", 120)

# Varrer pacotes criados e exibir informações na tela
pacoteArray = [pacote30, pacote60, pacote120]
pacoteArray.each do |pacote|
  puts "Pacote #{pacote.nome} oferece #{pacote.tempo.to_s} minutos."
end

# Instância dos DDDs de origem
ddd11 = Ddd.new(11)
ddd16 = Ddd.new(16)
ddd17 = Ddd.new(17)
ddd18 = Ddd.new(18)

#Adicionando preços à tabela do DDD 11
ddd11.add_price(ddd16, 1.9)
ddd11.add_price(ddd17, 1.7)
ddd11.add_price(ddd18, 0.9)
#Adicionando preços à tabela do DDD 16
ddd16.add_price(ddd11, 2.9)
#Adicionando preços à tabela do DDD 17
ddd17.add_price(ddd11, 2.7)
#Adicionando preços à tabela do DDD 18
ddd18.add_price(ddd11, 1.9)

# Varrer DDDs criados e exibir informações na tela
listings = [ddd11, ddd16, ddd17, ddd18]
listings.each do |i|
  puts "------------------------"
  puts 'DDD ' + i.numero.to_s
  puts "------------------------"
  i.precos.each do |key, value|
    puts 'Destino: ' + key.numero.to_s + ', Preco: ' + value.to_s
  end
  puts ""
end

# Instância das ligações
p30d11 = Ligacao.new(ddd11, ddd16, 20, pacote30)
p60d11 = Ligacao.new(ddd11, ddd17, 80, pacote60)
p120d18 = Ligacao.new(ddd18, ddd11, 200, pacote120)
p30d18 = Ligacao.new(ddd18, ddd17, 100, pacote30)


# Array com todas as ligaçõas para exibição
planos_e_destinos = [p30d11, p60d11, p120d18, p30d18]
# Colunas
puts "Origem | Destino | Tempo | Plano        | Com FaleMais | Sem FaleMais"
# Exibição na tela
planos_e_destinos.each do |planoddd|
  
  tempo = planoddd.tempo.to_s
  if tempo.length < 3
    tempo += SPACE
  end
  
  nome_plano = planoddd.plano.nome
  if nome_plano.length < 12
    nome_plano += SPACE
  end
  
  valor_c_plano = planoddd.calcular_valor_com_plano
  num = valor_c_plano.length - 5
  num.times do
    valor_c_plano += SPACE
  end
  
  puts planoddd.origem.numero.to_s            + SPACE*7 +
       planoddd.destino.numero.to_s           + SPACE*8 + 
       tempo                                  + SPACE*5 + 
       nome_plano                             + SPACE*3 + 
       valor_c_plano                          + SPACE*6 + 
       planoddd.calcular_valor_sem_plano
end