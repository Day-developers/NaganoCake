class Public::SearchesController < ApplicationController

  def search
    @genres = Genre.all
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @value).page(params[:page]).per(8)
  end

  private

  def match(value)
    #.orを使用することで、valueに一致するカラムのデータをnameカラムとgenre_idカラムから探してくる
    Item.where(name: value).or(Item.where(genre_id: value))
  end

  def search_for(how, value)
    case how
    when 'match'
      match(value)
    end
  end
end
