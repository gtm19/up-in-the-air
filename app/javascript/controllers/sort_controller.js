// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {

  static targets = ["ban"];

  connect() {
    const list = document.querySelector("#sortable-list")

    if (list.dataset.status == 'disabled') {
      return
    }

    this.sortable = Sortable.create(this.element, {
    onEnd: this.end.bind(this)
    })
    console.log(this)
  }

  end(event) {
    console.log(event)
    let id = event.item.dataset.id
    let tid = event.item.dataset.tid
    let tpid = event.item.dataset.tpid
    let data = new FormData()
    data.append('position', event.newIndex + 1)

    Rails.ajax({
    url: this.data.get("url").replace(":id", id).replace(":trip_id", tid).replace(":trip_participant_id", tpid),
    type: 'PUT',
    data: data
    })
  }

  updateVeto(event) {

    const list = document.querySelector("#sortable-list")
    if (list.dataset.status == 'disabled') {
      return
    }

    event.currentTarget.classList.toggle('veto-off')
    event.currentTarget.classList.toggle('veto-on')


    let id = event.currentTarget.dataset.id
    let tid = event.currentTarget.dataset.tid
    let tpid = event.currentTarget.dataset.tpid
    let data = new FormData()
    data.append('sub_action', 'veto')

    Rails.ajax({
    url: this.data.get("url").replace(":id", id).replace(":trip_id", tid).replace(":trip_participant_id", tpid),
    type: 'PUT',
    data: data
    })

    const veto_buttons = document.querySelectorAll("#veto-button")
    if ( event.currentTarget.classList.contains('veto-on')) {
      veto_buttons.forEach((button) => {
        button.classList.add('veto-hidden')
      });
      event.currentTarget.classList.toggle('veto-hidden')
    } else {
      veto_buttons.forEach((button) => {
        button.classList.remove('veto-hidden')
      });
    }
  }
}
