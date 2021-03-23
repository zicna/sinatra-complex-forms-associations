class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  #rendering new owner form
  get '/owners/new' do 
    @pets = Pet.all
    erb :'/owners/new'
  end

  #creating new owner with associated pets
  post '/owners' do 
    @owner = Owner.create(params[:owner])
    if !params[:pet][:name].empty?
      @owner.pets << Pet.create(name: params[:pet][:name])
    end
    redirect to "owners/#{@owner.id}"
  end
  #rendering form to show the owner based on given :id in URL
  get '/owners/:id/edit' do 
    @owner = Owner.find_by_id(params[:id])
    @pets = Pet.all
    #binding.pry
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end
  #editing owners form edit form
  patch '/owners/:id' do 
    #binding.pry
    #in case our updated owner doesn't have any pet from offered ones we will not have "pet_ids" as key in "owner"
    if !params[:owner].keys.include?("pet_ids")
      binding.pry
      params[:owner]["pet_ids"] = []
    end
    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "owners/#{@owner.id}"

      
  end
end