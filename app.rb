class Ddd < Object
  attr_accessor :numero, :precos
  
  def initialize(numero)
    @numero = numero
    @precos = {}
  end
  
  def add_price(destino, preco)
    preco_final = {}
    @precos[destino] = preco
  end
  
  def calcular_valor_ligacao(tempo_usado, destino)
    if @precos[destino] != nil 
      tempo_usado * @precos[destino]
    else
      "-"
    end
  end
end



class Pacote < Object
  attr_accessor :nome, :tempo
  
  def initialize(nome, tempo)
    @nome = nome
    @tempo = tempo
  end
  
  def calcular_valor_ligacao(tempo_usado, preco_p_min)
    tempo_sobra = tempo_usado - @tempo
    
    if tempo_sobra <= 0
      return 0
    else
      return (tempo_sobra * (preco_p_min * 1.1))
    end
  end
  
end



#class PacotexDdd < Object
#  attr_accessor :ddd, :pacote
  
#  def initialize(ddd, pacote)
#    @ddd = ddd
#    @pacote = pacote
#  end
  
#  def calcular_valor(tempo, destino)
#    @pacote.calcular_valor(tempo, ddd.precos[destino])
#  end
#end


class Ligacao
  attr_accessor :origem, :destino, :tempo, :plano
  
  def initialize(origem, destino, tempo, plano)
    @origem = origem
    @destino = destino
    @tempo = tempo
    @plano = plano
  end
  
  def calcular_valor_com_plano
    if @origem.precos[@destino] != nil
      @plano.calcular_valor_ligacao(@tempo, @origem.precos[@destino])
    else
      "-"
    end
  end
  
  def calcular_valor_sem_plano
    @origem.calcular_valor_ligacao(@tempo, @destino)
  end
end



pacote30 = Pacote.new("FaleMais 30", 30)
pacote60 = Pacote.new("FaleMais 60", 60)
pacote120 = Pacote.new("FaleMais 120", 120)

pacoteArray = [pacote30, pacote60, pacote120]
pacoteArray.each do |pacote|
  puts "Pacote #{pacote.nome} oferece #{pacote.tempo.to_s} minutos."
end


ddd11 = Ddd.new(11)
ddd16 = Ddd.new(16)
ddd17 = Ddd.new(17)
ddd18 = Ddd.new(18)

ddd11.add_price(ddd16, 1.9)
ddd11.add_price(ddd17, 1.7)
ddd11.add_price(ddd18, 0.9)

ddd16.add_price(ddd11, 2.9)

ddd17.add_price(ddd11, 2.7)

ddd18.add_price(ddd11, 1.9)
  
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


p30d11 = Ligacao.new(ddd11, ddd16, 20, pacote30)
p60d11 = Ligacao.new(ddd11, ddd17, 80, pacote60)
p120d18 = Ligacao.new(ddd18, ddd11, 200, pacote120)
p30d18 = Ligacao.new(ddd18, ddd17, 100, pacote30)


planos_e_destinos = [p30d11, p60d11, p120d18, p30d18]

puts "Origem | Destino | Tempo | Plano | Com FaleMais | Sem FaleMais"

planos_e_destinos.each do |planoddd|
  puts "#{planoddd.origem.numero}     #{planoddd.destino.numero}      #{planoddd.tempo}" +
       "      #{planoddd.plano.nome}       #{planoddd.calcular_valor_com_plano}        #{planoddd.calcular_valor_sem_plano}"
end





