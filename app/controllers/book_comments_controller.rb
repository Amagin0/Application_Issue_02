class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comment.user_id = current_user.id
    unless @book_comment.save
      render 'error'
      #book_comments/error.js.erbを読み込む(課題外の内容）
    end
      #book_comments/create.js.erbを読み込む
  end

  def destroy
    @book = Book.find(params[:book_id])
    book_comment = @book.book_comments.find(params[:id])
    book_comment.destroy
    #book_comments/destroy.js.erbを読み込む
  end

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
