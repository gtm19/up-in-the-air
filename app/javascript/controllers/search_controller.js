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
    // console.log(document.getElementById('budget'));
    let bgt = document.getElementById('budget').value;
    console.log(bgt);
    // if (bgt == 0 || bgt == null) {
    //   // let bgt = parseInt(document.getElementById('budget-field').dataset.budget);
    //   let bgt = 1000;
    // }
    // console.log(bgt);

    let num = wNumb({decimals: 0, prefix: '£'});



    noUiSlider.create(slider, {
      connect: true,
      behaviour: 'tap',
      tooltips: [num],
      start: bgt,
      range: {
          min: 0,
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

    slider.noUiSlider.on('slide', (values) => {
      console.log(values)
      this.budgetTarget.value = Math.round(values[0])
        });
  }
}

