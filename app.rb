require 'sinatra'
require 'faker'
get '/' do #cuando ingrese a la url hace lo siguiente
  @name = Faker::Name.name #creamos una variable de instancia que podemos imprimir en los view
  @libros = Faker::Book.title #estamos usando la gema faker para probar
  @chewie = Faker::StarWars.wookiee_sentence # <3 mori de amor
  @lol = Faker::LeagueOfLegends.quote
  erb :index #estamos llamando a la vista index
end
