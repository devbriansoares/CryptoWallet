namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
      show_spinner("Criando BD...") { %x(rails db:create) }
      show_spinner("Migrando BD...") { %x(rails db:migrate) }
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Você não está em ambiente de desenvolvimento"
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
      coins = [
                {
                description: "Bitcoin",
                acronym: "BTC",
                url_image: "https://i.pinimg.com/originals/fe/9b/c6/fe9bc614df69ea3b7b65f73b0952d205.png",
                mining_type: MiningType.all.find_by(acronym: 'PoW')
                },
                {
                description: "Ethereum",
                acronym: "ETC",
                url_image: "https://http2.mlstatic.com/D_NQ_NP_873994-MLB26608195019_012018-O.jpg",
                mining_type: MiningType.all.sample
                },
                {
                  description: "Cardano",
                  acronym: "ADA",
                  url_image: "https://s3.cointelegraph.com/storage/uploads/view/a7872fcc56858227ffa183256a5d55e1.png",
                  mining_type: MiningType.all.sample
                },
                {
                  description: "Tether",
                  acronym: "USDT",
                  url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/825.png",
                  mining_type: MiningType.all.sample
                },
                {
                description: "Dash",
                acronym: "DASH",
                url_image: "https://cryptologos.cc/logos/history/dash-logo-2014.svg?v=001",
                mining_type: MiningType.all.sample
                }
              ]
  
      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastra os Tipos de Mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando Tipos de Mineração...") do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
      ]

      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end

  private

  def show_spinner(msg_start)
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(Concluído!)")
  end
end
