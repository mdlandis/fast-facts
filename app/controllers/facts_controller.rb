class FactsController < ApplicationController
  before_action :set_fact, only: [:show, :edit, :update, :destroy]

  # GET /facts
  # GET /facts.json
  def compare_dates(a, b)
    if a[6...10] > b[6...10]
      return 1
    elsif a[6...10] == b[6...10]
      if a[0...2] > b[0...2]
        return 1
      elsif a[0...2] == b[0...2]
        if a[3...5] > b[3...5]
          return 1
        elsif a[3...5] == b[3...5]
          return 0
        else
          return -1
        end
      else
        return -1
      end
    else
      return -1
    end

  end

  def index
    @facts = Fact.all
  end

  def view
    @facts = Fact.all
    @all_tags = Tag.all
    @all_categories = Category.all

    @tags_list = {}

    @facts.each do |fact|
      firstlist = []
      fact.tags.each do |tag|
        firstlist << tag.tag_word
      end
      @tags_list[fact.id] = firstlist
    end

    @ac_tags_list = []
    @ac_cats_list = []
    @all_tags.each do |tag|
      @ac_tags_list << tag.tag_word
    end
    @all_categories.each do |category|
      @ac_cats_list << category.category_name
    end

    @facts_to_show = []
    if params[:searching_by_what?] == "searching_by_tags"
      if params[:tags_input]
        tags_to_search_by = (params[:tags_input].strip)[0...-1].split(", ")
        if params[:andor] == "and"
          @facts.each do |fact|
            tag_word_list = []
            fact.tags.each do |tag|
              tag_word_list << tag.tag_word
            end
            if (tag_word_list - tags_to_search_by).empty?
              @facts_to_show << fact
            end
          end
        else
          @facts.each do |fact|
            tag_word_list = []
            fact.tags.each do |tag|
              tag_word_list << tag.tag_word
            end
            x = tag_word_list
            y = tags_to_search_by
            tmp = x & y
            if !tmp.empty?
              @facts_to_show << fact
            end
          end
        end
      end
    elsif params[:searching_by_what?] == "searching_by_cats"
      if params[:category_input]
        cats_to_search_by = (params[:category_input].strip)[0...-1].split(", ")
        if params[:andor] == "and"
          @facts.each do |fact|
            cat_word_list = []
            fact.tags.each do |tag|
              cat_word_list << tag.category.category_name
            end
            if (cat - cats_to_search_by).empty?
              @facts_to_show << fact
            end
          end
        else
          @facts.each do |fact|
            cat_word_list = []
            fact.tags.each do |tag|
              cat_word_list << tag.category.category_name
            end
            x = cat_word_list
            y = cats_to_search_by
            tmp = x & y
            if !tmp.empty?
              @facts_to_show << fact
            end
          end
        end
      end
    else
      @facts.each do |fact|
        @facts_to_show << fact
      end
    end
    if params[:sort_by_what?] == "tag_words"
      @facts_to_show.sort! { |a,b| a.tags[0].tag_word.downcase <=> b.tags[0].tag_word.downcase }
      if params[:sort_by_tags] == "asc"
        @facts_to_show.reverse!
      end
    elsif params[:sort_by_what?] == "source_date"
      @facts_to_show.sort! { |a,b| compare_dates(a.source.date_published, b.source.date_published) }
      if params[:sort_by_dates] == "desc"
        @facts_to_show.reverse!
      end
    elsif params[:sort_by_what?] == "source_title"
      @facts_to_show.sort! { |a,b| a.source.title.downcase <=> b.source.title.downcase }
      if params[:sort_by_titles] == "desc"
        @facts_to_show.reverse!
      end
    end
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
