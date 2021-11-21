class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    # 選択したmodelの値を@modelに代入
    @model = params["model"]     
    # 選択した検索方法の値を@methodに代入
    @content = params["content"] 
    # 検索ワードを@contentに代入
    @method = params["method"]  
    # @model, @content, @methodを代入したsearch_forを@recordsに代入
    @records = search_for(@model, @content, @method)
  end
  
  private
  def search_for(model, content, method)
    # 選択したモデルがuserだったら
    if model == 'user'
      # 選択した検索方法が完全一致だったら
      if method == 'perfect'
        User.where(name: content)
        
      # 選択した検索方法が前方一致だったら
      elsif method == 'forward'
        User.where("name LIKE?", content+'%')
        
      # 選択した検索方法が後方一致だったら
      elsif method == 'backward'
        User.where("name LIKE?", '%'+content)
      
      # 選択した検索方法が部分一致だったら
      else
        User.where('name LIKE?', '%'+content+'%')
      end
      
      # 選択したモデルがbookだったら
    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content)
      elsif method == 'forward'
        Book.where("title LIKE?", content+'%')
      elsif method == 'backward'
        Book.where("title LIKE?", '%'+content)
      else
        Book.where('title LIKE?', '%'+content+'%')
      end
    end
  end
end
