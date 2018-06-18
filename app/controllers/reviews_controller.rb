class ReviewsController < InheritedResources::Base
 
  private

    def review_params
      params.require(:review).permit(:review, :user_id, :product_id)
    end

  public 
  def create
    @product = Product.find(params[:product_id])
    params.permit!
    @review = @product.reviews.create(params[:review])

    respond_to do |format|
        format.html { redirect_to product_path(@product) }
        format.js 
   end
  end
end

