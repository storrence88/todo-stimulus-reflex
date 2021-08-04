# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskReflex, type: :reflex do
  let(:reflex) { build_reflex(connection: { current_user: user }) }
  let(:user) { FactoryBot.create :user }

  describe '#toggle' do
    subject { reflex.run(:toggle) }

    context 'element is checked' do
      let(:task) { FactoryBot.create :task }

      it 'completes the task' do
        reflex.element.dataset.id = task.id
        reflex.element.checked = true

        expect { subject }.to change { task.reload.complete? }.from(false).to(true)
      end
    end
  end
end
