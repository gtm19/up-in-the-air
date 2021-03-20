// <div id="slider"></div>

import { Controller } from "stimulus"
import noUiSlider from "nouislider"
import 'nouislider/distribute/nouislider.css';

export default class extends Controller {

  static targets = ["budget"];

  connect(){
    console.log("I am connected!")

    let slider = document.getElementById('slider');

  noUiSlider.create(slider, {
    connect: true,
    behaviour: 'tap',
    tooltips: [false, wNumb({decimals: 0}), true],
    start: 300,
    range: {
        // Starting at 500, step the value by 500,
        // until 4000 is reached. From there, step by 1000.
        min: 0,
        // '10%': [100, 100],
        // '50%': [400, 600],
        max: 1000
    },
        pips: {
        mode: 'values',
        values: [200, 800],
        density: 50,
        format: wNumb({
            decimals: 0,
            prefix: '£'
        })
    }
});

slider.noUiSlider.on('change', (values) => {
  this.budgetTarget.value = values[0]
    });


  }
}

