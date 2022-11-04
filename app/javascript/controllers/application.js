import { Application } from "@hotwired/stimulus"
import * as d3 from "d3"
import Chart from 'chart.js/auto';

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
export {d3}
export {Chart}

