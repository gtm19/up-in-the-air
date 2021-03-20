// <div id="slider"></div>

import { Controller } from "stimulus"
import noUiSlider from "nouislider"
import 'nouislider/distribute/nouislider.css'
import wNumb from "wnumb"

export default class extends Controller {

  static targets = ["budget"];

  connect(){
    console.log("I am connected!")

    let slider = document.getElementById('slider');

    let bgt = document.getElementById('budget').value;
    if (bgt == 0 || bgt == null) {
      let bgt = parseInt(document.getElementById('budget-field').dataset.budget);
    }
    console.log(bgt);
    // console.log(input);
    let test = wNumb({decimals: 0});
    // this.budgetTarget.value = 300


    noUiSlider.create(slider, {
      connect: true,
      behaviour: 'tap',
      tooltips: [test],
      start: bgt,
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
          values: [0, 200, 400, 600, 800, 1000],
          density: 50,
          format: wNumb({
              decimals: 0,
              prefix: '£'
          })
      }
    });

    slider.noUiSlider.on('change', (values) => {
      console.log(values)
      this.budgetTarget.value = Math.round(values[0])
        });
  }
}

