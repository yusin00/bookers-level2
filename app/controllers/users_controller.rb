class UsersController < ApplicationController
    before_action :is_matching_login_user, only: [:edit, :update]

    def index
         @user=current_user
         @users=User.all
         @book=Book.new
    end
    
    def show
      @user=User.find(params[:id])
      @book=Book.new
      @books=@user.books
    end

    def edit
      @user=User.find(params[:id])
    end

    def update
      @user=current_user

      if @user.update(user_params)
            # 詳細画面へリダイレクト
           #3. フラッシュメッセージを定義し、詳細画面へリダイレクト
         flash[:notice]="You have updated user successfully."
          redirect_to user_path(current_user.id)
      else
          #３フラッシュメッセージを定義し、new,html.erbを描画する
         render :edit
      end
    end

    private

    def is_matching_login_user
        user = User.find(params[:id])
        unless user.id == current_user.id
        redirect_to user_path(current_user.id)
        end
    end
   
    def user_params
      params.require(:user).permit(:name, :profile_image, :opinion, :introduction)
    end
end
