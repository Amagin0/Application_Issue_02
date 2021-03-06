class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit,:update,:following,:followers]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_book = @books.create_today
    @yesterday_book = @books.create_yesterday
    @two_days_ago_book = @books.create_two_days_ago
    @three_days_ago_book = @books.create_three_days_ago
    @four_days_ago_book = @books.create_four_days_ago
    @five_days_ago_book = @books.create_five_days_ago
    @six_days_ago_book = @books.create_six_days_ago
    @oneweek_book = @books.create_one_week
    @oneweek_ago_book = @books.create_one_week_ago


    if user_signed_in?
      @currentUserEntry = UserRoom.where(user_id: current_user.id)
      @userEntry = UserRoom.where(user_id: @user.id)
      unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id
              @haveRoom = true
              @roomId = cu.room_id
            end
          end
        end
        unless @haveRoom
          @room = Room.new
          @user_room = UserRoom.new
        end
      end
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.id = current_user.id
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日付を選択してください"
    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE?', "#{create_at}%"]).count
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end

