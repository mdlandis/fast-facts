class SourcesController < ApplicationController
  before_action :set_source, only: [:show, :edit, :update, :destroy]

  # GET /sources
  # GET /sources.json
  def index
    @sources = Source.all
  end

  # GET /sources/1
  # GET /sources/1.json
  def show
    @source = Source.find(params[:id])
    finallist = []
    count = 0
    @source.facts.each do |fact|
      firstlist = []
      fact.tags.each do |tag|
        firstlist << tag.tag_word
      end
      finallist[count] = firstlist
      count = count + 1
    end
    @tags_list = finallist
  end

  # GET /sources/new
  def new
    @source = Source.new
    @tags_list = Tag.all
  end

  # GET /sources/1/edit
  def edit
  end

  # POST /sources
  # POST /sources.json
  def create
    # @source = Source.new(source_params)
    @source = Source.new
    @source.url = source_params[:url]
    @source.title = source_params[:title]
    @source.authors = source_params[:authors]
    @source.date_published = source_params[:date_published]
    @source.original_source = source_params[:original_source]
    facts = source_params[:facts_attributes]

    Array(facts).each do |fact|
      tempfact = Fact.new
      tempfact.fact_text = fact[1][:fact_text]
      tempfact.notes = fact[1][:notes]
      tags = fact[1][:tags_attributes]
      Array(tags).each do |tag|
        temptag = Tag.find_by tag_word: tag[1][:tag_word]
        tempfact.tags << temptag
      end
      @source.facts << tempfact
    end





    respond_to do |format|
      if @source.save
        format.html { redirect_to @source, notice: 'Source was successfully created.' }
        format.json { render :show, status: :created, location: @source }
      else
        format.html { render :new }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sources/1
  # PATCH/PUT /sources/1.json
  def update
    respond_to do |format|
      if @source.update(source_params)
        format.html { redirect_to @source, notice: 'Source was successfully updated.' }
        format.json { render :show, status: :ok, location: @source }
      else
        format.html { render :edit }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sources/1
  # DELETE /sources/1.json
  def destroy
    @source.destroy
    respond_to do |format|
      format.html { redirect_to sources_url, notice: 'Source was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_source
      @source = Source.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def source_params
      params.require(:source).permit(
          :url,
          :title,
          :authors,
          :date_published,
          :original_source,
          facts_attributes: [:fact_text, :notes, tags_attributes: [:tag_word]]
      )
    end
end
