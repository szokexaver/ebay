class ItemsController < ApplicationController
    before_action :authenticate_user!, :except => [:show, :index]
    before_action :find_item, only: [:show, :edit, :update, :destroy]
    
    def index
        @items = Item.all.order("created_at DESC")
    end

    def show 
        @categories = @item.categories
    end

    def new
        @item = current_user.items.build
    end
    
    def create
        @item = current_user.items.build(item_params)
        puts params[:category_ids]

        if @item.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit
        if @item.user_id == current_user.id
            @categories = @item.categories.all
        else
            redirect_to item_path(@item)
        end
    end

    def update
        if @item.update(item_params)
            redirect_to item_path(@item)
        else
            render 'edit'
        end
    end

    def destroy
        if @item.user_id == current_user.id
            @item.destroy
            redirect_to root_path
        else
            redirect_to item_path(@item)
        end
    end

    private
        def item_params
            params.require(:item).permit(:name, :description, :item_img, :category_ids => [])
        end

        def find_item
            @item = Item.find(params[:id])
        end
end
