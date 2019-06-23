class BooksController < ApplicationController
      before_action :ensure_correct_user, only: [:edit, :update]

    def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      @user = current_user
      @nbook = Book.new
      flash[:notice] = "You have creatad book successfully."
      redirect_to book_path(@book.id)


    else
      @books = Book.all
      @user = current_user
      render :index

    end
    end
    def index
     @book = Book.new
     @books = Book.all
     @user = current_user

    end
    def show
     @book = Book.find(params[:id])
     @user = current_user
     @nbook = Book.new



    end

      def edit
    @book = Book.find(params[:id])
  end



  def update
     @book = Book.find(params[:id])
  if @book.update(book_params)
     @book = Book.find(params[:id])
     @user = current_user
     @nbook = Book.new
     flash[:notice] = "You have updated book successfully."

     render :show

     flash[:notice] = "You have updated book successfully."
  else
     render:edit
  end

end
def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
end
private
    def book_params
        params.require(:book).permit(:title, :body)
    end

  def ensure_correct_user
    @book = Book.find_by(id: params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end

end
end
