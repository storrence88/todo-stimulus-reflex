# frozen_string_literal: true

class TasksController < ApplicationController
  def show
    @list = List.find(params[:list_id])
    @task = @list.tasks.includes(:comments).find(params[:id])
  end
end
