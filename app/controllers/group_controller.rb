class GroupController < ApplicationController
  bfore_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def new
    @group = Group.new
  end 
  
  def edit
  end 
  
  def index
    @book = Book.new
    @groups = Group.all
    @user = User.find(current_user.id)
  end 
  
  def show
    @book = Book.new
    @user = User.find(current_user.id)
    @group = @group.find(params[:id])
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_group_path
    else 
      render 'new'
    end 
  end
  
  def update
    if @group.update(group_params)
      redirect_to groups_path
    else 
      render "edit"
    end 
  end 
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end 
  
  
  
end
