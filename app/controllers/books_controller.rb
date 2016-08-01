class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy,:upvote,:downvote]
  before_action :authenticate_user!, except: [:index,:show]

  def index
    @books = Book.all
  end

  def show
  end

  
  def new
    @book = current_user.books.build
  end

  
  def edit
  end

  def create
    @book = current_user.books.build(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

   def favorite
    type = params[:type]
    if @type == "favorite"
      current_user.favorites << @book
      redirect_to :back, notice: "You favorited #{@book.Title}"

    elsif type == "unfavorite"
      current_user.favorites.delete(@book)
      redirect_to :back, notice: "You Unfavorited #{@book.Title}"

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
  end

  def upvote
    @book.upvote_by current_user
    redirect_to :book

  end

  def downvote
    @book.downvote_by current_user
    redirect_to :book
  end



  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:Title, :Summary, :Rating, :Author, :Ranking, :Awards, :Recommended_by, :Amazon, :Audiobook, :Animated_Review,:image)
    end
end
