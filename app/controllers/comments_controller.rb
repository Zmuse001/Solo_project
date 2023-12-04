class CommentsController < ApplicationController
    def create
        @fitness = Fitness.find(params[:article_id])
        @comment = @fitness.comments.create(comment_params)
        redirect_to article_path(@fitness)
      end
    
      def destroy
        @fitness = Fitness.find(params[:article_id])
        @comment = @fitness.comments.find(params[:id])
        @comment.destroy
        redirect_to article_path(@fitness), status: :see_other
      end
    
      private
        def comment_params
          params.require(:comment).permit(:commenter, :body, :status)
        end

end
