class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy,:upvote,:downvote]
  
  before_filter :must_be_admin, only: [:edit, :new]


  def search
    if params[:search].present?
      @books = Book.search(params[:search])
    else
      @books = Book.all
    end
  end

  def must_be_admin
    unless current_user && current_user.admin?
      redirect_to root_path, notice: ""
    end
  end


  def index
    if params[:category].blank?
      @books = Book.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 16)
      @cat_1, @cat_2, @cat_3 = Category.take(3)
      @books_for_cat_1= @cat_1.books.take(4)
      @books_for_cat_2 = @cat_2.books.take(4)
      @books_for_cat_3 = @cat_3.books.take(4)
    else
      @category_id = Category.find_by(name: params[:category]).id
      @books = Book.where(category_id: @category_id).order("created_at DESC").paginate(:page => params[:page], :per_page => 16)

    end
  end

  def show
    @random_book=Book.where.not(id: @book).order("RANDOM()").limit(4)
    @reviews=Review.where(book_id: @book.id).order("created_at DESC")
    @Audiobook = YouTubeAddy.extract_video_id(@book.Audiobook)
    @Animated_Review = YouTubeAddy.extract_video_id(@book.Animated_Review)

     if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
  end

  def new
    @book = current_user.books.build
    @categories = Category.all.map{ |c| [c.name,c.id] }

  end

  
  def edit
  end

  def create
    @book = current_user.books.build(book_params)
    @book.category_id = params[:category_id]

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
    book = Book.find(params[:id])
     if current_user.books << book
      redirect_to :book
    end
  end

  def dashboard
    
      
    
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
      params.require(:book).permit(:Title, :Summary, :Rating, :Author, :Ranking, :Awards, :Recommended_by, :Amazon, :Audiobook, :Animated_Review,:image,:category_id)
    end
end
