class FactsController < ApplicationController
  before_action :set_fact, only: [:show, :edit, :update, :destroy]

  # GET /facts
  # GET /facts.json
  def index
    @facts = Fact.all
  end

  def view
    @facts = Fact.all
    @all_tags = Tag.all
    @all_categories = Category.all

    finallist = []
    count = 0
    @facts.each do |fact|
      firstlist = []
      fact.tags.each do |tag|
        firstlist << tag.tag_word
      end
      finallist[count] = firstlist
      count = count + 1
    end
    @tags_list = finallist

    @ac_tags_list = '['
    @all_tags.each do |tag|
      @ac_tags_list += "{value:" + tag.id.to_s + ",label:\'" + tag.tag_word + "\'},"
    end
    @ac_tags_list[-1] = ']'
    @ac_tags_list+=';'

    @ac_cats_list = '['
    @all_categories.each do |category|
      @ac_cats_list += "{value:" + category.id.to_s + ",label:\'" + category.category_name + "\'},"
    end

    @ac_cats_list[-1] = ']'
    @ac_cats_list+=';'


  end

  # GET /facts/1
  # GET /facts/1.json
  def show
    @fact = Fact.find(params[:id])
    firstlist = []
    @fact.tags.each do |tag|
      firstlist << tag.tag_word
    end
    @tags_list = firstlist
    @source = Source.find(@fact.source_id)
  end

  # GET /facts/new
  def new
    @fact = Fact.new
  end

  # GET /facts/1/edit
  def edit
    @tags_list = Tag.all
  end

  # POST /facts
  # POST /facts.json
  def create
    @fact = Fact.new(fact_params)

    respond_to do |format|
      if @fact.save
        format.html { redirect_to @fact, notice: 'Fact was successfully created.' }
        format.json { render :show, status: :created, location: @fact }
      else
        format.html { render :new }
        format.json { render json: @fact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facts/1
  # PATCH/PUT /facts/1.json
  def update
    @tags_list = Tag.all
    @fact = Fact.find(params[:id])
    @fact.fact_text = params[:fact][:fact_text]
    @fact.notes = params[:fact][:notes]
    @fact.last_modified_by = current_user.name
    @fact.tags.clear
    tags = params[:fact][:tags_attributes]
    Array(tags).each do |tag|
      if tag[1][:_destroy] != "1"
        temptag = Tag.find_by tag_word: tag[1][:tag_word]
        if @fact.tags.include?(temptag) == false
          @fact.tags << temptag
        end
      end
    end

    respond_to do |format|
      if @fact.update(fact_params)
        format.html { redirect_to @fact, notice: 'Fact was successfully updated.' }
        format.json { render :show, status: :ok, location: @fact }
      else
        format.html { render :edit }
        format.json { render json: @fact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facts/1
  # DELETE /facts/1.json
  def destroy
    @fact.destroy
    respond_to do |format|
      format.html { redirect_to facts_url, notice: 'Fact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fact
      @fact = Fact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fact_params
      params.require(:fact).permit(
          :fact_text,
          :notes,
          :destroy,
          tags_attributes: [:id, :tag_word, :_destroy]
      )
    end
end
