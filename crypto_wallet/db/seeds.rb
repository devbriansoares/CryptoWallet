spinner = TTY::Spinner.new("[:spinner] Cadastrando moedas")
spinner.auto_spin

coins = [
          {
          description: "Bitcoin",
          acronym: "BTC",
          url_image: "https://i.pinimg.com/originals/fe/9b/c6/fe9bc614df69ea3b7b65f73b0952d205.png"
          },
          {
          description: "Ethereum",
          acronym: "ETC",
          url_image: "https://http2.mlstatic.com/D_NQ_NP_873994-MLB26608195019_012018-O.jpg"
          },
          {
          description: "Dash",
          acronym: "DASH",
          url_image: "https://cryptologos.cc/logos/history/dash-logo-2014.svg?v=001"
          }
        ]

coins.each do |coin|
  Coin.find_or_create_by!(coin)
end

spinner.success("(Concluído!)")