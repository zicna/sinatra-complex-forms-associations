class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    #binding.pry
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    #binding.pry
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    #binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    #@pet.update(name: params[:pet][:name], owner_id: params[:pet][:owner_id])
    if !params["owner"]["name"].empty?
      
      owner = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = owner.id
    #else
      #@pet.update(name: params[:pet][:name], owner_id: params[:pet][:owner_id])
    end
    #@pet.update(name: params[:pet][:name], owner_id: params[:pet][:owner_id])
    @pet.save
    redirect "pets/#{@pet.id}"
  end



  
end