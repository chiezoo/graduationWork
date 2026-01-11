class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
  @year = (params[:year] || Time.current.year).to_i
  @month = (params[:month] || Time.current.month).to_i
  @view_date = Date.new(@year, @month, 1)

  @events = current_user.events
end

  def show
    @event = current_user.events.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @event = current_user.events.build(time: params[:time].to_time)

    @medicine_history = Event.where(user_id: current_user.id)
                           .pluck(:medicine1, :medicine2, :medicine3)
                           .flatten
                           .compact
                           .uniq
                           .reject(&:empty?)
  end

def create
  @event = current_user.events.build(event_params)

  if params[:select_hour].present? && params[:select_minute].present?
    new_time = @event.time.in_time_zone('Tokyo').change(
      hour: params[:select_hour].to_i, 
      min: params[:select_minute].to_i
    )
    @event.time = new_time
  end

  if @event.save
    redirect_to events_path, notice: "登録しました"
  else
    render :new, status: :unprocessable_entity
  end
end

  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: "削除しました", status: :see_other
  end


  private

  def event_params
  params.require(:event).permit(:title, :content, :time, :memo, :medicine1, :medicine2, :medicine3, :pain_level)
  end
end
