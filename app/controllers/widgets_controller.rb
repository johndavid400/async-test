class WidgetsController < ApplicationController
  before_action :set_widget, only: %i[ show edit update destroy ]
  before_action :set_option_id, only: %i[ create update ]

  # GET /widgets or /widgets.json
  def index
    @widgets = get_widgets
  end

  # GET /widgets/1 or /widgets/1.json
  def show
  end

  # GET /widgets/new
  def new
    @widget = Widget.new
  end

  # GET /widgets/1/edit
  def edit
  end

  # POST /widgets or /widgets.json
  def create
    @widget = Widget.new(widget_params)

    respond_to do |format|
      if @widget.save
        format.html { redirect_to edit_widget_path(@widget), notice: "Widget was successfully created." }
        format.json { render :show, status: :created, location: @widget }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @widget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /widgets/1 or /widgets/1.json
  def update
    respond_to do |format|
      if @widget.update(widget_params)
        format.html { redirect_to edit_widget_path(@widget), notice: "Widget was successfully updated." }
        format.json { render :show, status: :ok, location: @widget }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @widget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /widgets/1 or /widgets/1.json
  def destroy
    @widget.destroy
    respond_to do |format|
      format.html { redirect_to widgets_url, notice: "Widget was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_widget
      @widget = Widget.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def widget_params
      params.require(:widget).permit(:name, :option_id)
    end

    def set_option_id
      params[:widget][:option_id] = params[:widget][:options]&.map(&:to_i)&.sum.to_i
    end

    def get_widgets
      return Widget.find_by_option(params[:search]) if params[:search].present?

      Widget.all
    end
end
