class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

    def destroy
      book=Book.find(params[:id])
      book.destroy
      redirect_to'/books'
    end

      def create
        #1.%2.データを受け取り新規登録するためのインスタンス作成
        @book=Book.new(book_params)
        @book.user_id = current_user.id
        @user = current_user
        #3. データをデータベースに保存するためのsave  メソッド実行
        if @book.save
            # 詳細画面へリダイレクト
           #3. フラッシュメッセージを定義し、詳細画面へリダイレクト
         flash[:notice]="You have created book successfully."
          redirect_to book_path(@book.id)
        else
           @books=Book.all

          #３フラッシュメッセージを定義し、new,html.erbを描画する
        render:index
        end
      end

    def index
      @user = current_user
      @books=Book.all
      @book=Book.new
    end

    def show
      @book=Book.find(params[:id])
      @user = @book.user
    end

    def edit
      @book = Book.find(params[:id])
      @user = current_user
    end

    def update
      @book = Book.find(params[:id])
      if @book.update(book_params)

            # 詳細画面へリダイレクト
           #3. フラッシュメッセージを定義し、詳細画面へリダイレクト
         flash[:notice]="Book was successfully created."
          redirect_to book_path(@book.id)
        else
          #３フラッシュメッセージを定義し、new,html.erbを描画する
        render :edit
        end
    end
    private
    def is_matching_login_user
        book = Book.find(params[:id])
        unless book.user.id == current_user.id
        redirect_to books_path
        end
    end
    #ストロングパラメータ
    def book_params
    params.require(:book).permit(:title, :body, :image)
    end
  end
