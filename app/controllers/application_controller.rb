class ApplicationController < Sinatra::Base
  set default_content_type: "application/json"
  
  #GET requests
  get '/bakeries' do
    bakeries = Bakery.all
    bakeries.to_json
  end
  
  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_goods = BakedGood.by_price
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_good = BakedGood.by_price.first
    baked_good.to_json
  end

  #POST requests
  #POST /baked_goods
  post '/baked_goods' do
    #create a new baked_good in db
    baked_good = BakedGood.create(
      name: params[:name],
      price: params[:price],
      bakery_id: params[:bakery_id]
    )

    #return the created baked_good as JSON
    baked_good.to_json
  end

  #PATCH requests
  #PATCH /bakeries/:id
  patch '/bakeries/:id' do
    #get the bakery whose id matches the passed id
    bakery = Bakery.find(params[:id])

    #update the name of the bakery
    bakery.update(name: params[:name])

    #return the updated bakery as JSON
    bakery.to_json
  end

  #DELETE request
  #DELETE /baked_goods/:id
  delete '/baked_goods/:id' do
    #find the baked_good to delete
    baked_good = BakedGood.find(params[:id])

    #delete the baked_good
    baked_good.destroy

    #return the deleted baked_good as JSON
    baked_good.to_json
  end

end
