class GroupsController < ApplicationController
    include AccessControlConcern
    skip_before_action :verify_authenticity_token
    before_action :require_login, :except => [ :index ]
    
    def index
        @groups = Group.all
    end

    def show
        @group = Group.find(params[:id]) rescue not_found
        @group_user = GroupUser.where(group_id:params[:id])
        @post = Post.new
        @posts = Post.where(groupid:params[:id])
    end

    def new
        @group = Group.new
    end

    def create
        begin
            user = current_user
        rescue
            flash.alert = "User information unknown. Did you login?"
            redirect_to new_group_path, status: :ok and return
        end

        @group = Group.new(groupname:group_params[:groupname],pic_url:group_params[:pic_url])
        if @group.save
            @group_user = GroupUser.new(group_id:@group.id,user_id:user.id,permission:true)
            if @group_user.save
                redirect_to group_path(@group), status: :ok
            else
                render :new, status: :unprocessable_entity
            end
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    def edit
        @group = Group.find(params[:id]) rescue not_found
    end
  
    def update
        @group = Group.find(params[:id]) rescue not_found

        if @group.update(groupname:group_params[:groupname],pic_url:group_params[:pic_url])
            redirect_to @group, status: :ok
        else
            render :edit, status: :unprocessable_entity
        end
    end
  
    def destroy
        GroupUser.where(group_id:params[:id]).each do |group_user|
            group_user.destroy
        end
        Post.where(groupid:params[:id]).each do |post|
            post.destroy
        end
        @group = Group.find(params[:id]) rescue not_found
        @group.destroy
        redirect_to groups_path, status: :see_other
    end

    private
      def group_params
        params.require(:group).permit(:groupname, :pic_url)
      end

end
