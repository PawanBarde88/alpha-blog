class ArticlesController < ApplicationController
    
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

end