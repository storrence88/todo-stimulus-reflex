# frozen_string_literal: true

class ListReflex < StimulusReflex::Reflex
  delegate :current_user, to: :connection

  def create_task
    list = List.find(element.dataset.list_id)
    @new_task = list.tasks.create(task_params.merge(creator: current_user))

    if @new_task.persisted?
      cable_ready[ListChannel]
        .insert_adjacent_html(
          selector: "#list_#{list.id} #incomplete-tasks",
          position: 'beforeend',
          html: ApplicationController.render(@new_task)
        )
        .add_css_class(selector: "#list_#{list.id} #no-tasks", name: 'd-none')
        .broadcast_to(list)
    end

    @new_task = Task.new
  end

  private

  def task_params
    params.require(:task).permit(:name)
  end
end
