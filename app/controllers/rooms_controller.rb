class RoomsController < ApplicationController
  def new
    @room = Room.new
  end
  def create
    if Room.create(room_params)
      # binding.pry
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  def index
  end
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to root_path
  end
  private

  def room_params
    # user_idsというカラムはroomに存在しないが、中間テーブルのuser_idに一要素ずつ保存される
    params.require(:room).permit(:name, user_ids: [])
  end
end
