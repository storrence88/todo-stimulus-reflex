import { Controller } from 'stimulus';
import StimulusReflex from 'stimulus_reflex';

export default class extends Controller {
  static targets = ['form'];

  connect() {
    StimulusReflex.register(this);
  }

  beforeCreateTask(element) {
    element.querySelectorAll('input').forEach((input) => input.blur());
    element.classList.add('form-disabled');
  }

  createTaskSuccess() {
    this.formTarget.reset();
  }

  createTaskError(_element, _name, error) {
    alert(error);
  }
}
