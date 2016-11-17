class Admin::StatisticsController < ApplicationController
  layout "admin_application"
  def index
    @items = Item.all
  end
end
