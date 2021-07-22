import { Controller } from "stimulus"
import StimulusReflex from 'stimulus_reflex'

export default class extends Controller {
  connect() {
    console.log("Task Controller connected!");
    StimulusReflex.register(this);
  }
}
