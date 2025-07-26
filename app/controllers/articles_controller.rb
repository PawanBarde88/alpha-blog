class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
   # before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
    end

    def new

    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
        @article = Article.new(params.require(:article).permit(:title, :description))
        @article.user = User.first
        @article.save
        redirect_to @article
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "Article was updated successfully"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
      end

      private

      def set_article
        @article = Article.find(params[:id])
      end
    
      def article_params
        params.require(:article).permit(:title, :description)
      end
       
      def require_same_user
        if current_user != @article.user
          flash[:alert] = "You can only edit or delete your own article"
          redirect_to @article
        end
      end


end