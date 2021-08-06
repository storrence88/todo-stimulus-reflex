# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskReflex, type: :reflex do
  let(:reflex) { build_reflex(connection: { current_user: user }) }
  let(:user) { FactoryBot.create :user }

  describe '#toggle' do
    subject { reflex.run(:toggle) }

    context 'element is checked' do
      let(:task) { FactoryBot.create :task }

      before do
        reflex.element.dataset.id = task.id
        reflex.element.checked = true
      end

      it 'completes the task' do
        expect { subject }.to change { task.reload.complete? }.from(false).to(true)
        expect(task.completer).to eq(user)
        expect(task.completed_at).to be_present
      end

      it 'broadcasts CableReady operations' do
        expect { subject }.to broadcast(
          remove: { selector: "#task_#{task.id}" },
          insert_adjacent_html: {
            selector: "#list_#{task.list_id} #complete-tasks",
            position: 'beforeend',
            html: kind_of(String)
          },
          broadcast_to: task.list
        )
      end
    end

    context 'element is unchecked' do
      let(:task) { FactoryBot.create :task, :complete }

      before do
        reflex.element.dataset.id = task.id
        reflex.element.checked = false
      end

      it 'incompletes the task' do
        expect { subject }.to change { task.reload.complete? }.from(true).to(false)
        expect(task.completed_at).to be_nil
      end

      it 'broadcasts CableReady operations' do
        expect { subject }.to broadcast(
          remove: { selector: "#task_#{task.id}" },
          insert_adjacent_html: {
            selector: "#list_#{task.list_id} #incomplete-tasks",
            position: 'beforeend',
            html: kind_of(String)
          },
          broadcast_to: task.list
        )
      end
    end
  end

  describe '#assigns' do
    subject { reflex.run(:assign) }

    let(:task) { FactoryBot.create :task }
    let(:assignee) { FactoryBot.create :user }

    before do
      reflex.element.dataset.id = task.id
      reflex.element.value = assignee.id
    end

    it 'assigns a user the task' do
      expect { subject }.to change { task.reload.assignee }.from(nil).to(assignee)
      expect(subject).to morph("#task-#{task.id}-assignee").with(task.assignee_name)
    end
  end

  describe '#reorder' do
    subject { reflex.run(:reorder, position) }

    let(:task) { FactoryBot.create(:task, position: 10) }
    let(:position) { 5 }

    it 'reorders a task' do
      reflex.element.dataset.id = task.id
      expect { subject }.to change { task.reload.position }.from(10).to(5)
      expect(subject).to morph(:nothing)
    end
  end
end
