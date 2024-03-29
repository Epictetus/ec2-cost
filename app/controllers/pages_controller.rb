require File.expand_path('../../../lib/aws_price', __FILE__)

class PagesController < ApplicationController
  # GET /pages
  # GET /pages.json
  def index
    awc = AWSPrice.new
    @rate = awc.rate

    costs_st = awc.calc_cost :small => 0.1, :large => 0.4, :extra_large => 0.8 
    costs_mic = awc.calc_cost :micro => 0.027 
    costs_h_mem = awc.calc_cost :extra_large => 0.60, :double_extra_large => 1.2, :quad_extra_large => 2.39
    costs_h_cpu = awc.calc_cost :medium => 0.2, :extra_large => 0.8

    @costs = {"Standard" => costs_st, 
              "Micro" => costs_mic, 
              "High Memory" => costs_h_mem, 
              "High CPU" => costs_h_cpu}
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :ok }
    end
  end
end
